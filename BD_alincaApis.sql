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

-- Empresa com nome de fazenda/produtora
INSERT INTO tbEmpresa (razaoSocial, nomeFantasia, cnpj, cdgAtivacao, fkEndereco)
VALUES INSERT INTO tbEmpresa (razaoSocial, nomeFantasia, cnpj, cdgAtivacao, fkEndereco)
VALUES ('Rancho Lon Lon LTDA', 'Lon Lon', '98765432000100', 'Epona', 1), 
('Fazenda do Jorge LTDA', 'Fazenda do Jorge', '73645179859019', 'C0br4', 2),
('Kerplunk Honey LTDA', 'Kerplunk', '10000000000003', 'Idi0t', 3),
('Oak Apiarios LTDA', 'PokeHoney', '10000000000004', 'Pich', 4),
('Stark Apiaries LTDA', 'Iron Honey', '10000000000005', 'Javis', 5),
('Wayne Farms LTDA', 'BatHoney', '10000000000006', 'Batmn', 6),
('Shire Honey LTDA', 'Sweet Ring', '10000000000007', 'Preci', 7),
('Mushroom Kingdom LTDA', 'Toad Honey', '10000000000008', 'Mario', 8),
('Magic Honey LTDA', 'Wizard Bees', '10000000000009', 'Exlli', 9),
('Upside Honey LTDA', 'Stranger Bees', '10000000000010', 'Elevn', 10),
('Pandora Nectar LTDA', 'NaVi Honey', '10000000000011', 'Eywa1', 11),
('Vice Honey LTDA', 'GTA Bees', '10000000000012', 'Tommy', 12),
('Skyrim Honey LTDA', 'Dragon Bees', '10000000000013', 'FRoDh', 13),
('Raccoon Honey LTDA', 'Zombie Bees', '10000000000014', 'Umela', 14),
('Wakanda Nectar LTDA', 'Vibranium Honey', '10000000000015', 'Pther', 15),
('Night City Honey LTDA', 'Cyber Bees', '10000000000016', 'Johny', 16),
('Jurassic Honey LTDA', 'Dino Bees', '10000000000017', 'TRex1', 17),
('Midgard Honey LTDA', 'Spartan Bees', '10000000000018', 'Krtos', 18),
('Liberty Honey LTDA', 'Urban Bees', '10000000000019', 'Niko2', 19),
('Halo Honey LTDA', 'Spartan Honey', '10000000000020', '11734', 20),
('Arkham Honey LTDA', 'Dark Bees', '10000000000021', 'Joker', 21),
('Capsule Honey LTDA', 'Saiyan Honey', '10000000000022', 'kkrot', 22),
('Overwatch Honey LTDA', 'Hero Bees', '10000000000023', 'Paylo', 23),
('Assassin Honey LTDA', 'Hidden Bees', '10000000000024', 'Ezio5', 24),
('Valorant Honey LTDA', 'Tactical Bees', '10000000000025', 'Spike', 25),
('Elden Honey LTDA', 'Golden Bees', '10000000000026', 'Trshd', 26);

INSERT INTO tbUsuario (nome, datanasc, cpf, senha, email, fkEmpresa)
VALUES ('Talon', '1970-05-20', '12345678901', 'Malon1234', 'talon@lonlon.com', 1),
('Malon', '1998-12-03', '92282791889', 'Epona12345', 'malon@lonlon.com', 1),
('Jorge', '1980-09-17', '87862401801', 'Alonso01', 'jorge@jorge.com', 2),
('Jimmy', '1990-01-01', '11111111111', 'saintJimmy', 'jesusofssuburbia@kerplunk.com', 3),
('Ash', '1995-05-22', '11111111112', 'Pikachu123', 'ash@poke.com', 4),
('Tony Stark', '1975-05-29', '11111111113', 'IamIronMan', 'tony@stark.com', 5),
('Bruce Wayne', '1972-02-19', '11111111114', 'IamBatman', 'bruce@wayne.com', 6),
('Frodo', '1988-09-22', '11111111115', 'OneRing', 'frodo@shire.com', 7),
('Mario', '1985-07-09', '11111111116', 'ItsMeMario', 'mario@nintendo.com', 8),
('Harry Potter', '1989-07-31', '11111111117', 'Hogwarts', 'harry@hogwarts.com', 9),
('Eleven', '2000-01-01', '11111111118', '011powers', 'eleven@hawkins.com', 10),
('Jake Sully', '1980-03-03', '11111111119', 'Avatar', 'jake@pandora.com', 11),
('Tommy Vercetti', '1970-01-01', '11111111120', 'ViceCity', 'tommy@gta.com', 12),
('Dovahkiin', '1990-01-01', '11111111121', 'DragonBorn', 'dragon@skyrim.com', 13),
('Leon Kennedy', '1985-02-02', '11111111122', 'RPD123', 'leon@raccoon.com', 14),
('TChalla', '1980-03-03', '11111111123', 'Wakanda', 'tchalla@wakanda.com', 15),
('V', '1995-04-04', '11111111124', 'Cyberpunk', 'v@nightcity.com', 16),
('Alan Grant', '1970-05-05', '11111111125', 'Jurassic', 'grant@jurassic.com', 17),
('Kratos', '1975-06-06', '11111111126', 'Sparta', 'kratos@midgard.com', 18),
('Niko Bellic', '1980-07-07', '11111111127', 'Liberty', 'niko@gta.com', 19),
('Master Chief', '1970-08-08', '11111111128', 'Halo117', 'chief@halo.com', 20),
('Coringa', '1975-09-09', '11111111129', 'WhySoSerious', 'joker@arkham.com', 21),
('Goku', '1984-10-10', '11111111130', 'Kamehameha', 'goku@capsule.com', 22),
('Tracer', '1990-11-11', '11111111131', 'Blink', 'tracer@overwatch.com', 23),
('Ezio Auditore', '1987-12-12', '11111111132', 'Assassin', 'ezio@ac.com', 24),
('Jett', '1998-01-01', '11111111133', 'Valorant', 'jett@valorant.com', 25),
('Tarnished', '1999-02-02', '11111111134', 'EldenRing', 'elden@ring.com', 26);

INSERT INTO tbApiario (identificacaoApiario, idEmpresa)
VALUES ('Apiario no Setor Sul', 1),
('Apiario no Setor Oeste', 1),
('Apiario no Setor Norte', 2),
('Apiario no Alley', 3),
('Apiario Rota Pokémon', 4),
('Apiario Torre Stark', 5),
('Apiario Caverna do Batman', 6),
('Apiario Condado Verde', 7),
('Apiario Reino Cogumelo', 8),
('Apiario Escola de Magia', 9),
('Apiario Mundo Invertido', 10),
('Apiario Floresta Pandora', 11),
('Apiario Vice City Sul', 12),
('Apiario Montanhas de Skyrim', 13),
('Apiario Cidade Raccoon', 14),
('Apiario Reino Wakanda', 15),
('Apiario Night City Central', 16),
('Apiario Isla Nublar Norte', 17),
('Apiario Midgard Florestal', 18),
('Apiario Liberty Downtown', 19),
('Apiario Base Halo', 20),
('Apiario Arkham Asylum', 21),
('Apiario Monte Paozu', 22),
('Apiario Watchpoint Alpha', 23),
('Apiario Florença Antiga', 24),
('Apiario Bind Site A', 25),
('Apiario Elden Tree', 26);

INSERT INTO tbSensor (idApiario)
VALUES (1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26);


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