CREATE DATABASE IF NOT EXISTS aliancaapis;
USE aliancaapis;

-- MySQL dump corrigido
-- Database: aliancaapis
-- Fix: CONSTRAINT fkSen2 agora aponta para sensor(idSensor) em vez de leitura(fkSensor)

SET FOREIGN_KEY_CHECKS = 0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ----------------------------
-- Table: endereco
-- ----------------------------
DROP TABLE IF EXISTS `endereco`;
CREATE TABLE `endereco` (
  `idEndereco` int NOT NULL,
  `cep` char(8) NOT NULL,
  `logradouro` varchar(255) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` char(2) NOT NULL,
  `numero` int NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `endereco` WRITE;
INSERT INTO `endereco` VALUES
(1,'15000000','Rodovia Lurelin','Zona Rural','Itapecerica da Serra','SP',0,'Entrada pela porteira de madeira'),
(2,'78192976','Estrada Amarela','Zona Rural','Ibaté','SP',10,'Ao lado do Trilho'),
(3,'15000003','Estrada solitária','Zona Rural','America','SP',10,'Aberta nos feriados'),
(4,'15000004','Rota 1','Zona Rural','Pallet','SP',1,'Saída do laboratório do Professor Oak'),
(5,'15000005','Rua Stark','Centro','Nova York','SP',3000,'Torre dos Vingadores'),
(6,'15000006','Avenida Wayne','Centro','Gotham','SP',1007,'Wayne Enterprises'),
(7,'15000007','Estrada do Anel','Zona Rural','Condado','SP',9,'Casa do Bilbo'),
(8,'15000008','Rua Toad','Reino Cogumelo','Peach City','SP',64,'Castelo da Peach'),
(9,'15000009','Beco Diagonal','Centro','Londres','SP',7,'Banco Gringotes'),
(10,'15000010','Rua Hawkins','Subúrbio','Hawkins','SP',11,'Laboratório'),
(11,'15000011','Estrada Pandora','Selva','Pandora','SP',22,'Árvore das Almas'),
(12,'15000012','Rua Vice City','Praia','Vice City','SP',80,'Malibu Club'),
(13,'15000013','Estrada Skyrim','Montanhas','Whiterun','SP',99,'Portão principal'),
(14,'15000014','Rua Raccoon','Centro','Raccoon City','SP',13,'Delegacia'),
(15,'15000015','Avenida Wakanda','Centro','Wakanda','SP',1,'Palácio'),
(16,'15000016','Rua Cyberpunk','Centro','Night City','SP',77,'Afterlife'),
(17,'15000017','Estrada Jurassic','Ilha','Isla Nublar','SP',5,'Centro de visitantes'),
(18,'15000018','Rua Kratos','Montanhas','Midgard','SP',23,'Casa na floresta'),
(19,'15000019','Rua Liberty','Centro','Liberty City','SP',45,'Ponte'),
(20,'15000020','Estrada Halo','Espacial','Instalação 04','SP',117,'Base UNSC'),
(21,'15000021','Rua Arkham','Centro','Gotham','SP',666,'Asilo Arkham'),
(22,'15000022','Estrada Dragon Ball','Montanhas','Monte Paozu','SP',4,'Casa do Goku'),
(23,'15000023','Rua Overwatch','Centro','Watchpoint','SP',76,'Base'),
(24,'15000024','Estrada Assassin','Centro','Florença','SP',15,'Torre'),
(25,'15000025','Rua Valorant','Centro','Bind','SP',12,'Teleporte'),
(26,'15000026','Estrada Elden','Montanhas','Lands Between','SP',99,'Árvore Áurea');
UNLOCK TABLES;

-- ----------------------------
-- Table: empresa
-- ----------------------------
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `idEmpresa` int NOT NULL AUTO_INCREMENT,
  `razaoSocial` varchar(255) NOT NULL,
  `nomeFantasia` varchar(255) NOT NULL,
  `cnpj` char(14) NOT NULL,
  `fkEndereco` int NOT NULL,
  `fkMatriz` int DEFAULT NULL,
  PRIMARY KEY (`idEmpresa`),
  KEY `fkEnd` (`fkEndereco`),
  KEY `fkMat` (`fkMatriz`),
  CONSTRAINT `fkEnd` FOREIGN KEY (`fkEndereco`) REFERENCES `endereco` (`idEndereco`),
  CONSTRAINT `fkMat` FOREIGN KEY (`fkMatriz`) REFERENCES `empresa` (`idEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `empresa` WRITE;
INSERT INTO `empresa` VALUES
(1,'Rancho Lon Lon LTDA','Lon Lon','98765432000100',1,NULL),
(2,'Fazenda do Jorge LTDA','Fazenda do Jorge','73645179859019',2,NULL),
(3,'Kerplunk Honey LTDA','Kerplunk','10000000000003',3,NULL),
(4,'Oak Apiarios LTDA','PokeHoney','10000000000004',4,NULL),
(5,'Stark Apiaries LTDA','Iron Honey','10000000000005',5,NULL),
(6,'Wayne Farms LTDA','BatHoney','10000000000006',6,NULL),
(7,'Shire Honey LTDA','Sweet Ring','10000000000007',7,NULL),
(8,'Mushroom Kingdom LTDA','Toad Honey','10000000000008',8,NULL),
(9,'Magic Honey LTDA','Wizard Bees','10000000000009',9,NULL),
(10,'Upside Honey LTDA','Stranger Bees','10000000000010',10,NULL);
UNLOCK TABLES;

-- ----------------------------
-- Table: apiario
-- ----------------------------
DROP TABLE IF EXISTS `apiario`;
CREATE TABLE `apiario` (
  `idApiario` int NOT NULL AUTO_INCREMENT,
  `identificacaoApiario` varchar(40) DEFAULT NULL,
  `fkEmpresa` int DEFAULT NULL,
  PRIMARY KEY (`idApiario`),
  KEY `fkEmp` (`fkEmpresa`),
  CONSTRAINT `fkEmp` FOREIGN KEY (`fkEmpresa`) REFERENCES `empresa` (`idEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `apiario` WRITE;
INSERT INTO `apiario` VALUES
(1,'Apiario no Setor Sul',1),
(2,'Apiario no Setor Oeste',1),
(3,'Apiario no Setor Norte',1),
(4,'Apiario no Alley',1);
UNLOCK TABLES;

-- ----------------------------
-- Table: sensor
-- ----------------------------
DROP TABLE IF EXISTS `sensor`;
CREATE TABLE `sensor` (
  `idSensor` int NOT NULL AUTO_INCREMENT,
  `fkApiario` int DEFAULT NULL,
  PRIMARY KEY (`idSensor`),
  KEY `fkCol` (`fkApiario`),
  CONSTRAINT `fkCol` FOREIGN KEY (`fkApiario`) REFERENCES `apiario` (`idApiario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `sensor` WRITE;
INSERT INTO `sensor` VALUES (1,1),(2,2),(3,3),(4,4);
UNLOCK TABLES;

-- ----------------------------
-- Table: leitura
-- ----------------------------
DROP TABLE IF EXISTS `leitura`;
CREATE TABLE `leitura` (
  `idLeitura` int NOT NULL AUTO_INCREMENT,
  `temperatura` float DEFAULT NULL,
  `dataHora` datetime DEFAULT CURRENT_TIMESTAMP,
  `fkSensor` int NOT NULL,
  PRIMARY KEY (`idLeitura`,`fkSensor`),
  KEY `fkSen` (`fkSensor`),
  CONSTRAINT `fkSen` FOREIGN KEY (`fkSensor`) REFERENCES `sensor` (`idSensor`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- (sem dados)

-- ----------------------------
-- Table: alerta
-- CORRIGIDO: fkSen2 agora aponta para sensor(idSensor)
-- ----------------------------
DROP TABLE IF EXISTS `alerta`;
CREATE TABLE `alerta` (
  `idAlerta` int NOT NULL AUTO_INCREMENT,
  `descricaoAlerta` varchar(100) DEFAULT NULL,
  `dataHora` datetime DEFAULT NULL,
  `fkSensor` int NOT NULL,
  `fkLeitura` int NOT NULL,
  PRIMARY KEY (`idAlerta`,`fkSensor`,`fkLeitura`),
  KEY `fkLei` (`fkLeitura`),
  KEY `fkSen2` (`fkSensor`),
  CONSTRAINT `fkLei` FOREIGN KEY (`fkLeitura`) REFERENCES `leitura` (`idLeitura`),
  CONSTRAINT `fkSen2` FOREIGN KEY (`fkSensor`) REFERENCES `sensor` (`idSensor`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- (sem dados)

-- ----------------------------
-- Table: usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `classe` varchar(30) DEFAULT NULL,
  `fkEmpresa` int NOT NULL,
  PRIMARY KEY (`idUsuario`,`fkEmpresa`),
  UNIQUE KEY `email` (`email`),
  KEY `fkEmp2` (`fkEmpresa`),
  CONSTRAINT `fkEmp2` FOREIGN KEY (`fkEmpresa`) REFERENCES `empresa` (`idEmpresa`),
  CONSTRAINT `chkClas` CHECK ((`classe` in (_utf8mb4'gestor',_utf8mb4'producao',_utf8mb4'n3')))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `usuario` WRITE;
INSERT INTO `usuario` VALUES
(1,'Talon','Malon1234','talon@lonlon.com','gestor',1),
(2,'Malon','Epona12345','malon@lonlon.com','producao',1),
(3,'Jorge','Alonso01','jorge@jorge.com','gestor',2),
(4,'Jimmy','saintJimmy','jesusofssuburbia@kerplunk.com','producao',3),
(5,'Ash','Pikachu123','ash@poke.com','producao',4),
(6,'Matheus Rosa','123456','matheussene.rosa2016@gmail.com','gestor',1),
(7,'Matheus Rosa','123456','matheus@email.com','gestor',1),
(8,'Lucas Rosa','123456','lucas@gmail.com','producao',1),
(9,'sofia lobeiro','123456','sofia@gmail.com','producao',1),
(10,'Yuri Aguileira','123456','yuri@email.com','producao',1),
(11,'N3','12345','n3@aliancaapis.com','n3',1);
UNLOCK TABLES;

-- ----------------------------
-- Views
-- ----------------------------

DROP VIEW IF EXISTS `vw_login`;
CREATE VIEW `vw_login` AS
  SELECT `idUsuario`, `nome`, `email`, `senha`, `classe`, `fkEmpresa`
  FROM `usuario`;

DROP VIEW IF EXISTS `vw_temperaturaindividual`;
CREATE VIEW `vw_temperaturaindividual` AS
  SELECT
    `l`.`temperatura` AS `temperatura`,
    `l`.`dataHora` AS `horario`,
    `a`.`identificacaoApiario` AS `nome_apiario`,
    `a`.`idApiario` AS `id_apiario`,
    `a`.`fkEmpresa` AS `id_empresa`
  FROM `leitura` `l`
  JOIN `sensor` `s` ON `l`.`fkSensor` = `s`.`idSensor`
  JOIN `apiario` `a` ON `a`.`idApiario` = `s`.`fkApiario`;

DROP VIEW IF EXISTS `vw_ultima_leitura_apiario`;
CREATE VIEW `vw_ultima_leitura_apiario` AS
  SELECT `v1`.`id_apiario`, `v1`.`id_empresa`, `v1`.`temperatura`
  FROM `vw_temperaturaindividual` `v1`
  WHERE `v1`.`horario` = (
    SELECT MAX(`v2`.`horario`)
    FROM `vw_temperaturaindividual` `v2`
    WHERE `v2`.`id_apiario` = `v1`.`id_apiario`
  );

DROP VIEW IF EXISTS `vw_kpi_ideal`;
CREATE VIEW `vw_kpi_ideal` AS
  SELECT `dataHora`, COUNT(`fkSensor`) AS `quantidade_ideal`
  FROM `leitura`
  WHERE `temperatura` BETWEEN 34.5 AND 36
  GROUP BY `dataHora`;

DROP VIEW IF EXISTS `vw_kpi_alerta`;
CREATE VIEW `vw_kpi_alerta` AS
  SELECT `dataHora`, COUNT(`fkSensor`) AS `quantidade_alerta`
  FROM `leitura`
  WHERE (`temperatura` BETWEEN 30 AND 34.4)
     OR (`temperatura` BETWEEN 36.1 AND 40)
  GROUP BY `dataHora`;

DROP VIEW IF EXISTS `vw_kpi_critico`;
CREATE VIEW `vw_kpi_critico` AS
  SELECT `dataHora`, COUNT(`fkSensor`) AS `quantidade_critica`
  FROM `leitura`
  WHERE `temperatura` <= 29.9 OR `temperatura` >= 40.1
  GROUP BY `dataHora`;

DROP VIEW IF EXISTS `vw_alertas`;
CREATE VIEW `vw_alertas` AS
  SELECT
    `a`.`idAlerta`,
    `a`.`descricaoAlerta` AS `descricao`,
    `a`.`dataHora` AS `horario`,
    `l`.`temperatura`,
    `e`.`idEmpresa`
  FROM `alerta` `a`
  JOIN `leitura` `l` ON `a`.`fkLeitura` = `l`.`idLeitura`
  JOIN `sensor` `s` ON `s`.`idSensor` = `l`.`fkSensor`
  JOIN `apiario` `ap` ON `ap`.`idApiario` = `s`.`fkApiario`
  JOIN `empresa` `e` ON `e`.`idEmpresa` = `ap`.`fkEmpresa`;

-- ----------------------------
-- Restore
-- ----------------------------
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

SET FOREIGN_KEY_CHECKS = 1;