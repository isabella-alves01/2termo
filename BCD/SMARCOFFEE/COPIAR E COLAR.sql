-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.

CREATE DATABASE IF NOT EXISTS ISABELLA_SMARTCOFFEE;

USE ISABELLA_SMARTCOFFEE;
CREATE TABLE Fornecerdor  (
telefone varchar(15) not null,
data_de_entrega_produtos date not null,
email varchar(20) not null,
ID_fornecedor int auto_increment primary key,
nome_fornecedor varchar(20) not null,
CNPJ  int not null
)

CREATE TABLE Categoria (
ID_categoria  int auto_increment primary key ,
desconto_padrao float not null ,
descricao  varchar(50) not null,
nome_categoria varchar(20) not null
)

drop table pedidos:

CREATE TABLE Pedidos (
ID_Pedido int auto_increment primary key ,
Quantidade int not null,
Valor int not null,
Pagamento_feito varchar(4) not null,
Data_do_pedido date not null,
tipo_pedido ENUM('Delivery', 'Presencial') DEFAULT 'Presencial'
);

CREATE TABLE Clientes (
ID_Cliente int auto_increment primary key ,
Nome varchar(20) not null,
Email varchar(40) not null,
CPF varchar(14) not null null unique,
Telefone varchar(15) not null,
data_cadrastro date not null
);

CREATE TABLE Progama_de_fidelidade (
ID_Progama int auto_increment primary key ,
Telefone varchar(15) not null,
Nome varchar(20) not null,
CPF varchar(14) not null,
Quantidade_de_pedidos int not null,
Pontos_acumulados int not null,
data_ultima_atualizacso date not null
);

CREATE TABLE Produtos (
Vencimento date not null,
ID_Produto int auto_increment primary key PRIMARY KEY,
Valor int not null,
Tipo_de_produto varchar(20) not null,
nome varchar(30) not null,
Descricao varchar(100) not null,
preco_unitario int not null,
Categoria varchar(30)  not null
)

CREATE TABLE Funcionarios (
Cargo varchar(15) not null,
Salario int not null,
Setor varchar (10) not null,
Nome varchar(20) not null,
ID_Funcionario int auto_increment primary key PRIMARY KEY,
cpf_funcionario varchar(14) not null,
data_demissao date not null
)

CREATE TABLE pagamento (
Pagamento_feito varchar(4) not null,
ID_Pagamento int auto_increment primary key PRIMARY KEY,
CPF varchar(14) not null,
Valor int not null,
Forma_de_pagamento varchar(10) not null,
forma_pagamento varchar(20) not null,
status_pagamento varchar(10) not null
)

CREATE TABLE Estoque (
  Tipo_de_produto varchar(15) not null,
  ID_insumo int auto_increment primary key,
  Produtos_em_falta varchar(50) not null,
  Quantidade_maxima int not null,
  quantidade_minima int not null,
  quantidade_atual int not null,
  kg varchar(1),
  ml varchar(1),
  un varchar(1)
)

CREATE TABLE Delivery (
    Horario_de_despache time not null,
    Pagamento_feito varchar(4) not null,
    ID_Delivery int auto_increment primary key,
    Endereco varchar(30) not null,
    Horario_que_foi_entregue time not null,
    Horario_maximo_para_ser_entregue time not null,
    taxa_entrega int not null,
    status_entrega varchar(30) not null
)



CREATE TABLE Atende (
ID_Funcionario int,
ID_Pedido int,
ID_Atende int auto_increment primary key,
FOREIGN KEY(ID_Funcionario) REFERENCES Funcionarios(ID_Funcionario),
FOREIGN KEY(ID_Pedido) REFERENCES Pedidos(ID_Pedido)
)

CREATE TABLE Contem (
ID_Produto int,
ID_Pedido int,
ID_Contem int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Produto) REFERENCES Produtos (ID_Produto),
FOREIGN KEY(ID_Pedido) REFERENCES Pedidos (ID_Pedido)
)

CREATE TABLE Possui ( 
ID_Pagamento int,
ID_Pedido int,
ID_Possui int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Pagamento) REFERENCES pagamento (ID_Pagamento),
FOREIGN KEY(ID_Pedido) REFERENCES Pedidos (ID_Pedido)
);

CREATE TABLE Gera ( 
ID_Delivery int ,
ID_Pedido int,
ID_Gera int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Delivery) REFERENCES Delivery (ID_Delivery),
FOREIGN KEY(ID_Pedido) REFERENCES Pedidos (ID_Pedido)
)

CREATE TABLE Entrega (
ID_Delivery int ,
ID_Funcionario int,
ID_entrega int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Delivery) REFERENCES Delivery (ID_Delivery),
FOREIGN KEY(ID_Funcionario) REFERENCES Funcionarios (ID_Funcionario)
)

CREATE TABLE ID_insumo (
ID_Produto int,
ID_Estoque int,
ID_insumo int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Produto) REFERENCES Produtos (ID_Produto),
FOREIGN KEY(ID_Estoque) REFERENCES Estoque (ID_insumo)
)

CREATE TABLE fornece (
ID_Estoque int ,
ID_fornecedor int ,
ID_fornece int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_Estoque) REFERENCES Estoque (ID_insumo),
FOREIGN KEY(ID_fornecedor) REFERENCES Fornecerdor  (ID_fornecedor)
)

CREATE TABLE tem (
ID_categoria  int,
ID_Produto int,
ID_tem int auto_increment primary key PRIMARY KEY,
FOREIGN KEY(ID_categoria ) REFERENCES Categoria (ID_categoria),
FOREIGN KEY(ID_Produto) REFERENCES Produtos (ID_Produto)
)




