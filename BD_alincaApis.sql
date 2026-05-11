CREATE DATABASE IF NOT EXISTS aliancaapis;
USE aliancaapis;

CREATE TABLE endereco(
  idEndereco INT NOT NULL,
  cep CHAR(8) NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(255) NULL,
  PRIMARY KEY (idEndereco));

CREATE TABLE empresa(
  idEmpresa INT NOT NULL AUTO_INCREMENT,
  razaoSocial VARCHAR(255) NOT NULL,
  nomeFantasia VARCHAR(255) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  fkEndereco INT NOT NULL,
  fkMatriz INT,
  PRIMARY KEY (idEmpresa),
  CONSTRAINT fkEnd FOREIGN KEY (fkEndereco)
  REFERENCES endereco (idEndereco),
  CONSTRAINT fkMat FOREIGN KEY (fkMatriz)
  REFERENCES empresa (idEmpresa));

CREATE TABLE apiario(
  idApiario INT NOT NULL AUTO_INCREMENT,
  identificacaoApiario VARCHAR(40),
  fkEmpresa INT,
  PRIMARY KEY (idApiario),
  CONSTRAINT fkEmp FOREIGN KEY (fkEmpresa)
  REFERENCES empresa(idEmpresa));

CREATE TABLE sensor(
  idSensor INT NOT NULL AUTO_INCREMENT,
  fkApiario INT,
  PRIMARY KEY (idSensor),
  CONSTRAINT fkCol FOREIGN KEY (fkApiario)
  REFERENCES apiario (idApiario));

CREATE TABLE leitura(
  idLeitura INT NOT NULL AUTO_INCREMENT,
  valorLeitura FLOAT,
  dataHora DATETIME DEFAULT NOW(),
  fkSensor INT NOT NULL,
  PRIMARY KEY (idLeitura, fkSensor),
  CONSTRAINT fkSen FOREIGN KEY (fkSensor)
  REFERENCES sensor(idSensor));
  
CREATE TABLE alerta(
  idAlerta INT NOT NULL AUTO_INCREMENT,
  descricaoAlerta VARCHAR(100),
  dataHora DATETIME,
  fkLeitura INT NOT NULL,
  PRIMARY KEY (idAlerta, fkLeitura),
  CONSTRAINT fkLei FOREIGN KEY (fkLeitura)
  REFERENCES leitura (idLeitura));

CREATE TABLE usuario(
  idUsuario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  senha VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  classe varchar(30),
  fkEmpresa INT NOT NULL,
  PRIMARY KEY (idUsuario, fkEmpresa),
  CONSTRAINT fkEmp2 FOREIGN KEY (fkEmpresa)
  REFERENCES empresa (idEmpresa),
  CONSTRAINT chkClas CHECK(classe in('gestor', 'producao'))
  );

INSERT INTO endereco (idEndereco, cep, logradouro, bairro, cidade, uf, numero, complemento)
VALUES 
(1, '15000000', 'Rodovia Lurelin', 'Zona Rural', 'Itapecerica da Serra', 'SP', 0, 'Entrada pela porteira de madeira'),
(2, '78192976', 'Estrada Amarela', 'Zona Rural', 'Ibaté', 'SP', 10, 'Ao lado do Trilho'),
(3, '15000003', 'Estrada solitária', 'Zona Rural', 'America', 'SP', 10, 'Aberta nos feriados'),
(4, '15000004', 'Rota 1', 'Zona Rural', 'Pallet', 'SP', 1, 'Saída do laboratório do Professor Oak'),
(5, '15000005', 'Rua Stark', 'Centro', 'Nova York', 'SP', 3000, 'Torre dos Vingadores'),
(6, '15000006', 'Avenida Wayne', 'Centro', 'Gotham', 'SP', 1007, 'Wayne Enterprises'),
(7, '15000007', 'Estrada do Anel', 'Zona Rural', 'Condado', 'SP', 9, 'Casa do Bilbo'),
(8, '15000008', 'Rua Toad', 'Reino Cogumelo', 'Peach City', 'SP', 64, 'Castelo da Peach'),
(9, '15000009', 'Beco Diagonal', 'Centro', 'Londres', 'SP', 7, 'Banco Gringotes'),
(10, '15000010', 'Rua Hawkins', 'Subúrbio', 'Hawkins', 'SP', 11, 'Laboratório'),
(11, '15000011', 'Estrada Pandora', 'Selva', 'Pandora', 'SP', 22, 'Árvore das Almas'),
(12, '15000012', 'Rua Vice City', 'Praia', 'Vice City', 'SP', 80, 'Malibu Club'),
(13, '15000013', 'Estrada Skyrim', 'Montanhas', 'Whiterun', 'SP', 99, 'Portão principal'),
(14, '15000014', 'Rua Raccoon', 'Centro', 'Raccoon City', 'SP', 13, 'Delegacia'),
(15, '15000015', 'Avenida Wakanda', 'Centro', 'Wakanda', 'SP', 1, 'Palácio'),
(16, '15000016', 'Rua Cyberpunk', 'Centro', 'Night City', 'SP', 77, 'Afterlife'),
(17, '15000017', 'Estrada Jurassic', 'Ilha', 'Isla Nublar', 'SP', 5, 'Centro de visitantes'),
(18, '15000018', 'Rua Kratos', 'Montanhas', 'Midgard', 'SP', 23, 'Casa na floresta'),
(19, '15000019', 'Rua Liberty', 'Centro', 'Liberty City', 'SP', 45, 'Ponte'),
(20, '15000020', 'Estrada Halo', 'Espacial', 'Instalação 04', 'SP', 117, 'Base UNSC'),
(21, '15000021', 'Rua Arkham', 'Centro', 'Gotham', 'SP', 666, 'Asilo Arkham'),
(22, '15000022', 'Estrada Dragon Ball', 'Montanhas', 'Monte Paozu', 'SP', 4, 'Casa do Goku'),
(23, '15000023', 'Rua Overwatch', 'Centro', 'Watchpoint', 'SP', 76, 'Base'),
(24, '15000024', 'Estrada Assassin', 'Centro', 'Florença', 'SP', 15, 'Torre'),
(25, '15000025', 'Rua Valorant', 'Centro', 'Bind', 'SP', 12, 'Teleporte'),
(26, '15000026', 'Estrada Elden', 'Montanhas', 'Lands Between', 'SP', 99, 'Árvore Áurea');

-- INSERT EMPRESA (Removido cdgAtivacao que não existe no CREATE)
INSERT INTO empresa (razaoSocial, nomeFantasia, cnpj, fkEndereco)
VALUES 
('Rancho Lon Lon LTDA', 'Lon Lon', '98765432000100', 1), 
('Fazenda do Jorge LTDA', 'Fazenda do Jorge', '73645179859019', 2),
('Kerplunk Honey LTDA', 'Kerplunk', '10000000000003', 3),
('Oak Apiarios LTDA', 'PokeHoney', '10000000000004', 4),
('Stark Apiaries LTDA', 'Iron Honey', '10000000000005', 5),
('Wayne Farms LTDA', 'BatHoney', '10000000000006', 6),
('Shire Honey LTDA', 'Sweet Ring', '10000000000007', 7),
('Mushroom Kingdom LTDA', 'Toad Honey', '10000000000008', 8),
('Magic Honey LTDA', 'Wizard Bees', '10000000000009', 9),
('Upside Honey LTDA', 'Stranger Bees', '10000000000010', 10);
-- ... (seguir o padrão para as demais)

-- INSERT USUARIO (Removido datanasc e cpf, adicionado 'classe' conforme o CHECK constraint)
INSERT INTO usuario (nome, senha, email, classe, fkEmpresa)
VALUES 
('Talon', 'Malon1234', 'talon@lonlon.com', 'gestor', 1),
('Malon', 'Epona12345', 'malon@lonlon.com', 'producao', 1),
('Jorge', 'Alonso01', 'jorge@jorge.com', 'gestor', 2),
('Jimmy', 'saintJimmy', 'jesusofssuburbia@kerplunk.com', 'producao', 3),
('Ash', 'Pikachu123', 'ash@poke.com', 'producao', 4);

-- INSERT APIARIO (Corrigido fkEmpresa conforme DDL)
INSERT INTO apiario (identificacaoApiario, fkEmpresa)
VALUES 
('Apiario no Setor Sul', 1),
('Apiario no Setor Oeste', 1),
('Apiario no Setor Norte', 2),
('Apiario no Alley', 3);
select * from apiario;

-- INSERT SENSOR (Corrigido fkApiario conforme DDL)
INSERT INTO sensor (fkApiario)
VALUES (1), (2), (3), (4);

-- Lista todos os usuários, mostrando apenas nome e e-mail
SELECT nome, email FROM usuario;

-- Lista todas as empresas cadastradas em ordem alfabética
SELECT idEmpresa, nomeFantasia FROM empresa ORDER BY nomeFantasia ASC;

-- Buscar apiários que pertencem à empresa de ID 1
SELECT idApiario, identificacaoApiario 
FROM apiario 
WHERE fkEmpresa = 1;

-- Mostrar status das leituras
SELECT
    valorLeitura, 
    dataHora,
    CASE 
        WHEN valorLeitura < 34.50 THEN 'Baixo'
        WHEN valorLeitura BETWEEN 34.50 AND 36 THEN 'Normal'
        ELSE 'Alto'
    END AS statusLeitura
FROM leitura;

-- Contar quantos alertas foram registrados no total
SELECT COUNT(*) AS total_alertas FROM alerta;

-- Listar o nome do usuário junto com a cidade e estado da sua empresa
SELECT u.nome, e.cidade, e.uf
FROM usuario u
JOIN empresa emp ON u.fkEmpresa = emp.idEmpresa
JOIN endereco e ON emp.fkEndereco = e.idEndereco;

-- Mostrar os apiários e o nome da empresa responsável
SELECT a.identificacaoApiario, emp.nomeFantasia
FROM apiario a
JOIN empresa emp ON a.fkEmpresa = emp.idEmpresa;

-- Listar os sensores instalados, em qual apiário estão e a empresa dona
SELECT s.idSensor, a.identificacaoApiario, emp.nomeFantasia
FROM sensor s
JOIN apiario a ON s.fkApiario = a.idApiario
JOIN empresa emp ON a.fkEmpresa = emp.idEmpresa;

-- Histórico de Alertas completo
SELECT al.descricaoAlerta, al.dataHora, s.idSensor, a.identificacaoApiario
FROM alerta al
JOIN leitura l ON al.fkLeitura = l.idLeitura
JOIN sensor s ON l.fkSensor = s.idSensor
JOIN apiario a ON s.fkApiario = a.idApiario
ORDER BY al.dataHora DESC;

create view vw_login as
select idUsuario, nome, email, senha, classe, fkEmpresa from usuario;

create or replace view vw_temperaturaIndividual as
select l.valorLeitura as temperatura,
l.dataHora as horario,
a.identificacaoApiario as nome_apiario,
a.idApiario as id_apiario,
a.fkEmpresa as id_empresa
from leitura l 
join sensor s on l.fkSensor = s.idSensor
join apiario a on a.idApiario = s.fkApiario;