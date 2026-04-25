CREATE DATABASE IF NOT EXISTS aliancaapis;
USE aliancaapis;

CREATE TABLE tbEndereco(
  idEndereco INT NOT NULL,
  cep CHAR(8) NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(255) NULL,
  PRIMARY KEY (idEndereco));
  

CREATE TABLE tbEmpresa(
  idEmpresa INT NOT NULL AUTO_INCREMENT,
  razaoSocial VARCHAR(255) NOT NULL,
  nomeFantasia VARCHAR(255) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  cdgAtivacao CHAR(5) NOT NULL,
  fkEndereco INT NOT NULL,
  PRIMARY KEY (idEmpresa),
  CONSTRAINT fkEnd FOREIGN KEY (fkEndereco)
  REFERENCES tbEndereco (idEndereco));

CREATE TABLE tbApiario(
  idApiario INT NOT NULL AUTO_INCREMENT,
  identificacaoApiario VARCHAR(40),
  idEmpresa INT,
  PRIMARY KEY (idApiario),
  CONSTRAINT fkEmp FOREIGN KEY (idEmpresa)
    REFERENCES tbEmpresa(idEmpresa));

CREATE TABLE tbSensor(
  idSensor INT NOT NULL AUTO_INCREMENT,
  idApiario INT,
  PRIMARY KEY (idSensor),
  CONSTRAINT fkCol FOREIGN KEY (idApiario)
  REFERENCES tbApiario (idApiario));

CREATE TABLE tbLeitura(
  idLeitura INT NOT NULL AUTO_INCREMENT,
  valorLeitura FLOAT,
  dataHora DATETIME,
  fkSensor INT NOT NULL,
  PRIMARY KEY (idLeitura, fkSensor),
  CONSTRAINT fkSen FOREIGN KEY (fkSensor)
  REFERENCES tbSensor(idSensor));

CREATE TABLE tbAlerta(
  idAlerta INT NOT NULL AUTO_INCREMENT,
  descricaoAlerta VARCHAR(100),
  dataHora DATETIME,
  fkLeitura INT NOT NULL,
  PRIMARY KEY (idAlerta, fkLeitura),
  CONSTRAINT fkLei FOREIGN KEY (fkLeitura)
  REFERENCES tbLeitura (idLeitura));

CREATE TABLE tbUsuario(
  idUsuario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  datanasc DATE,
  cpf CHAR(11) UNIQUE,
  senha VARCHAR(50),
  email VARCHAR(100),
  fkEmpresa INT NOT NULL,
  PRIMARY KEY (idUsuario, fkEmpresa),
  CONSTRAINT fkEmp2 FOREIGN KEY (fkEmpresa)
  REFERENCES tbEmpresa (idEmpresa));

INSERT INTO tbEndereco (idEndereco, cep, logradouro, bairro, cidade, uf, numero, complemento)
VALUES (1, '15000000', 'Rodovia Lurelin', 'Zona Rural', 'Itapecerica da Serra', 'SP', 0, 'Entrada pela porteira de madeira'),
(2, '78192976', 'Estrada Amarela', 'Zona Rural', 'Ibaté', 'SP', 10, 'Ao lado do Trilho');

-- Empresa com nome de fazenda/produtora
INSERT INTO tbEmpresa (razaoSocial, nomeFantasia, cnpj, cdgAtivacao, fkEndereco)
VALUES ('Rancho Lon Lon LTDA', 'Lon Lon', '98765432000100', 'Epona', 1), 
('Fazenda do Jorge LTDA', 'Fazenda do Jorge', '73645179859019', 'C0br4', 2);

INSERT INTO tbUsuario (nome, datanasc, cpf, senha, email, fkEmpresa)
VALUES ('Talon', '1970-05-20', '12345678901', 'Malon1234', 'talon@lonlon.com', 1),
('Malon', '1998-12-03', '92282791889', 'Epona12345', 'malon@lonlon.com', 1),
('Jorge', '1980-09-17', '87862401801', 'Alonso01', 'jorge@jorge.com', 2);

INSERT INTO tbApiario (identificacaoApiario, idEmpresa)
VALUES ('Apiario no Setor Sul', 1),
('Apiario no Setor Oeste', 1),
('Apiario no Setor Norte', 2);

INSERT INTO tbSensor (idApiario)
VALUES (1),
(2),
(3);


-- Lista todos os usuários (antigos apicultores), mostrando apenas nome e e-mail
SELECT nome, email 
FROM tbUsuario;

-- Lista todas as empresas (antigas 'serviços') cadastradas em ordem alfabética
SELECT idEmpresa, nomeFantasia 
FROM tbEmpresa 
ORDER BY nomeFantasia ASC;

-- Buscar colmeias que pertencem à empresa de ID 1
SELECT idApiario, identificacaoApiario 
FROM tbApiario 
WHERE idEmpresa = 1;

-- Mostrar todas as leituras de sensores com valor maior que o permitido para colmeias
SELECT idLeitura, valorLeitura, dataHora 
FROM tbLeitura 
WHERE valorLeitura > 36.0;

-- Contar quantos alertas foram registrados no total
SELECT COUNT(*) AS total_alertas 
FROM tbAlerta;

-- Listar o nome do usuário junto com a cidade e estado da sua empresa
SELECT u.nome, e.cidade, e.uf
FROM tbUsuario u
JOIN tbEmpresa emp ON u.fkEmpresa = emp.idEmpresa
JOIN tbEndereco e ON emp.fkEndereco = e.idEndereco;

-- Mostrar as colmeias e o nome da empresa responsável
SELECT c.identificacaoApiario, emp.nomeFantasia
FROM tbApiario c
JOIN tbEmpresa emp ON c.idEmpresa = emp.idEmpresa;

-- Listar os tipos de sensores instalados, em qual colmeia estão e a empresa dona
SELECT s.idSensor, c.identificacaoApiario, emp.nomeFantasia
FROM tbSensor s
JOIN tbApiario c ON s.idApiario = c.idApiario
JOIN tbEmpresa emp ON c.idEmpresa = emp.idEmpresa;

-- Histórico de Alertas: Descrição, data, tipo de sensor e identificação da colmeia
SELECT al.descricaoAlerta, al.dataHora, s.idSensor, c.identificacaoApiario
FROM tbAlerta al
JOIN tbLeitura l ON al.fkLeitura = l.idLeitura
JOIN tbSensor s ON l.fkSensor = s.idSensor
JOIN tbApiario c ON s.idApiario = c.idApiario
ORDER BY al.dataHora DESC;