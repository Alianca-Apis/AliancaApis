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
