CREATE USER 'user_apisinsert' IDENTIFIED BY 'urubu100';
GRANT INSERT ON aliancaapis.tbleitura TO 'user_apisinsert';

CREATE DATABASE IF NOT EXISTS aliancaApis; 
USE aliancaApis; 

CREATE TABLE tbEndereco( 
	idEndereco INT PRIMARY KEY,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(255) NOT NULL, 
    bairro VARCHAR(100) NOT NULL, 
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(50) NOT NULL
); 

CREATE TABLE tbEmpresa(
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(255) NOT NULL,
    nomeFantasia VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    cdgAtivacao CHAR(5)  NOT NULL,
    fkEndereco INT NOT NULL,
    complemento VARCHAR(100),
    numeroEnd INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES tbEndereco(idEndereco)
);

CREATE TABLE tbUsuario( 
    idUsuario INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR (50), 
    datanasc DATE, 
    cpf CHAR (11) UNIQUE,
    senha VARCHAR(50),
    email VARCHAR(100),
    fkEmpresa INT,
    CONSTRAINT fk_endereco FOREIGN KEY (fkEmpresa) REFERENCES tbEmpresa(idEmpresa)
); 

CREATE TABLE tbColmeias( 
    idColmeia INT PRIMARY KEY AUTO_INCREMENT, 
    identificacaoColmeia VARCHAR (40),
    idEmpresa INT,
    FOREIGN KEY (idEmpresa) REFERENCES tbEmpresa(idEmpresa)
); 

CREATE TABLE tbSensor( 
    idSensor INT PRIMARY KEY AUTO_INCREMENT, 
    tipoSensor VARCHAR (40),
    idColmeia INT,
    FOREIGN KEY (idColmeia) REFERENCES tbColmeias(idColmeia)
); 

CREATE TABLE tbLeitura( 
    idLeitura INT PRIMARY KEY AUTO_INCREMENT, 
    valorLeitura FLOAT, 
    dataHora DATETIME,
    idSensor INT,
    FOREIGN KEY (idSensor) REFERENCES tbSensor(idSensor)
); 

CREATE TABLE tbAlerta( 
    idAlerta INT PRIMARY KEY AUTO_INCREMENT, 
    descricaoAlerta VARCHAR(100), 
    dataHora DATETIME,
    idLeitura INT,
    FOREIGN KEY (idLeitura) REFERENCES tbLeitura(idLeitura)
);

-- Selects para verificação de dados:

-- Lista todos os apicultores, mostrando apenas nome e e-mail
SELECT nomeApicultor, emailApicultor 
FROM tbApicultor;

-- Lista todos os serviços cadastrados em ordem alfabética
SELECT idServico, nomeServico 
FROM tbServico 
ORDER BY nomeServico ASC;

-- Buscar colmeias que pertencem ao apicultor de ID 1
SELECT idColmeia, identificacaoColmeia 
FROM tbColmeias 
WHERE idApicultor = 1;

-- Mostrar todas as leituras de sensores com valor maior que 40.0
SELECT idLeitura, valorLeitura, dataHora 
FROM tbLeitura 
WHERE valorLeitura > 40.0;

-- Contar quantos alertas foram registrados no total
SELECT COUNT(*) AS total_alertas 
FROM tbAlerta;

-- Listar o nome do apicultor junto com a cidade e estado
SELECT a.nomeApicultor, e.cidadeEndereco, e.ufEndereco
FROM tbApicultor a
JOIN tbEndereco e ON a.idEndereco = e.idEndereco;

-- Relatório de Pedidos: Mostrar o nome do pedido, o cliente e o serviço
SELECT p.nomePedido, a.nomeApicultor, s.nomeServico
FROM tbPedido p
JOIN tbApicultor a ON p.idApicultor = a.idApicultor
JOIN tbServico s ON p.idServico = s.idServico;

-- Mostrar as colmeias e o nome dos seus respectivos donos
SELECT c.identificacaoColmeia, a.nomeApicultor
FROM tbColmeias c
JOIN tbApicultor a ON c.idApicultor = a.idApicultor;

-- Listar os tipos de sensores instalados, em qual colmeia estão e a quem a colmeia pertence
SELECT s.tipoSensor, c.identificacaoColmeia, a.nomeApicultor
FROM tbSensor s
JOIN tbColmeias c ON s.idColmeia = c.idColmeia
JOIN tbApicultor a ON c.idApicultor = a.idApicultor;

-- Histórico de Alertas: Mostrar a descrição do alerta, a data/hora, o tipo de sensor e a identificação da colmeia
SELECT al.descricaoAlerta, al.dataHora, s.tipoSensor, c.identificacaoColmeia
FROM tbAlerta al
JOIN tbSensor s ON al.idSensor = s.idSensor
JOIN tbColmeias c ON s.idColmeia = c.idColmeia
ORDER BY al.dataHora DESC;