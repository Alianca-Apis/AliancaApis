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
  REFERENCES tbendereco (idEndereco));

CREATE TABLE tbColmeias(
  idColmeia INT NOT NULL AUTO_INCREMENT,
  identificacaoColmeia VARCHAR(40),
  idEmpresa INT,
  PRIMARY KEY (idColmeia),
  CONSTRAINT fkEmp FOREIGN KEY (idEmpresa)
    REFERENCES tbempresa(idEmpresa));

CREATE TABLE tbSensor(
  idSensor INT NOT NULL AUTO_INCREMENT,
  tipoSensor VARCHAR(40),
  idColmeia INT,
  PRIMARY KEY (idSensor),
  CONSTRAINT fkCol FOREIGN KEY (idColmeia)
  REFERENCES tbcolmeias (idColmeia));

CREATE TABLE tbLeitura(
  idLeitura INT NOT NULL AUTO_INCREMENT,
  valorLeitura FLOAT,
  dataHora DATETIME,
  fkSensor INT NOT NULL,
  PRIMARY KEY (idLeitura, fkSensor),
  CONSTRAINT fkSen FOREIGN KEY (fkSensor)
  REFERENCES tbsensor(idSensor));

CREATE TABLE tbAlerta(
  idAlerta INT NOT NULL AUTO_INCREMENT,
  descricaoAlerta VARCHAR(100),
  dataHora DATETIME,
  fkLeitura INT NOT NULL,
  PRIMARY KEY (idAlerta, fkLeitura),
  CONSTRAINT fkLei FOREIGN KEY (fkLeitura)
  REFERENCES tbleitura (idLeitura));

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
  REFERENCES tbempresa (idEmpresa));


-- Lista todos os usuários (antigos apicultores), mostrando apenas nome e e-mail
SELECT nome, email 
FROM tbUsuario;

-- Lista todas as empresas (antigas 'serviços') cadastradas em ordem alfabética
SELECT idEmpresa, nomeFantasia 
FROM tbEmpresa 
ORDER BY nomeFantasia ASC;

-- Buscar colmeias que pertencem à empresa de ID 1
SELECT idColmeia, identificacaoColmeia 
FROM tbColmeias 
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
SELECT c.identificacaoColmeia, emp.nomeFantasia
FROM tbColmeias c
JOIN tbEmpresa emp ON c.idEmpresa = emp.idEmpresa;

-- Listar os tipos de sensores instalados, em qual colmeia estão e a empresa dona
SELECT s.tipoSensor, c.identificacaoColmeia, emp.nomeFantasia
FROM tbSensor s
JOIN tbColmeias c ON s.idColmeia = c.idColmeia
JOIN tbEmpresa emp ON c.idEmpresa = emp.idEmpresa;

-- Histórico de Alertas: Descrição, data, tipo de sensor e identificação da colmeia
SELECT al.descricaoAlerta, al.dataHora, s.tipoSensor, c.identificacaoColmeia
FROM tbAlerta al
JOIN tbLeitura l ON al.fkLeitura = l.idLeitura
JOIN tbSensor s ON l.fkSensor = s.idSensor
JOIN tbColmeias c ON s.idColmeia = c.idColmeia
ORDER BY al.dataHora DESC;