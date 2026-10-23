-- Active: 1788519384518@@127.0.0.1@3306@sesi_cr_ta
-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.

CREATE DATABASE IF NOT EXISTS SESI_CR_TA;
USE SESI_CR_TA;

CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Cliente VARCHAR(100)
);

CREATE TABLE Pedido (
    IDcliente INT,
    Data_Pedido DATE,
    FOREIGN KEY (IDcliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Estoque (
    id_Estoque INT AUTO_INCREMENT,
    id_Produto INT,
    Nome_Produto VARCHAR(100),
    Quantidade INT,
    PRIMARY KEY (id_Estoque, id_Produto)
);

CREATE TABLE Fornecedor (
    id_Fornecedor INT PRIMARY KEY,
    Razao_Social VARCHAR(100)
);

CREATE TABLE Produto (
    id_Produto INT PRIMARY KEY,
    Nome_Produto VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS Cliente (
    id_Pedido INT PRIMARY KEY,
    CPF VARCHAR(14)
);


CREATE TABLE IF NOT EXISTS Pedido (
    id_Pedido INT PRIMARY KEY,
    Data_Pedido DATE
);

ALTER TABLE Pedido ADD COLUMN id_Pedido INT AUTO_INCREMENT PRIMARY KEY FIRST;
CREATE TABLE Realiza (
    ID_Cliente INT NOT NULL,
    id_Pedido INT NOT NULL,
    PRIMARY KEY (ID_Cliente, id_Pedido),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (id_Pedido) REFERENCES Pedido(id_Pedido)
);
CREATE TABLE Relacao_Item_Pedido (
    id_Produto INT,
    id_Fornecedor INT,
    Item_pedido INT,
    Valor DECIMAL(10,2),
    PRIMARY KEY (id_Produto, id_Fornecedor),
    FOREIGN KEY (id_Produto) REFERENCES Produto(id_Produto),
    FOREIGN KEY (id_Fornecedor) REFERENCES Fornecedor(id_Fornecedor)
);



QUESTÃO 1 
 ---CATEGORIA--- POSSUI --- PRODUTO 
 1,N E 1,1


 QUESTÃO 2 

 --FUNCIONARIO --- REGISTRA -- PEDIDO

 QUESTÃO 3 

 ---FORNECEDOR --- FORNECE --- PRODUTO 

 QUESTÃO 4 

---CLIENTE --- RESERVA --- MESA
0,N E 1,1

QUESTÃO 5

---PEDIDO --- POSSUI --- ITEM_PEDIDO
1,N E 1,1 
