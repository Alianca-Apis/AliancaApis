CREATE DATABASE aliancaApis; 
USE aliancaApis; 

CREATE TABLE tbEndereco( 
    idEndereco INT PRIMARY KEY AUTO_INCREMENT, 
    logradouroEndereco VARCHAR (100), 
    numeroEndereco VARCHAR (20), 
    cidadeEndereco VARCHAR (40), 
    ufEndereco VARCHAR (20), 
    paisEndereco VARCHAR (50) 
); 

CREATE TABLE tbApicultor( 
    idApicultor INT PRIMARY KEY AUTO_INCREMENT, 
    nomeApicultor VARCHAR (50), 
    datanasc DATE, 
    cpfApicultor CHAR (11) UNIQUE,
    emailApicultor VARCHAR(100),
    idEndereco INT,
    FOREIGN KEY (idEndereco) REFERENCES tbEndereco(idEndereco)
); 

CREATE TABLE tbServico( 
    idServico INT PRIMARY KEY AUTO_INCREMENT, 
    nomeServico VARCHAR (50) 
); 

CREATE TABLE tbPedido( 
    idPedido INT PRIMARY KEY AUTO_INCREMENT, 
    nomePedido VARCHAR (50),
    idApicultor INT,
    idServico INT,
    FOREIGN KEY (idApicultor) REFERENCES tbApicultor(idApicultor),
    FOREIGN KEY (idServico) REFERENCES tbServico(idServico)
); 

CREATE TABLE tbColmeias( 
    idColmeia INT PRIMARY KEY AUTO_INCREMENT, 
    identificacaoColmeia VARCHAR (40),
    idApicultor INT,
    FOREIGN KEY (idApicultor) REFERENCES tbApicultor(idApicultor)
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
    idSensor INT,
    FOREIGN KEY (idSensor) REFERENCES tbSensor(idSensor)
);

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
