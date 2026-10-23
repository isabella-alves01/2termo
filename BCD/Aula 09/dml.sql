-- Active: 1788519384518@@127.0.0.1@3306@smartcoffee_dml_isabella1


DROP DATABASE IF NOT EXISTS SMARTCOFFEE_DML_ISABELLA1;
CREATE DATABASE IF NOT EXISTS SMARTCOFFEE_DML_ISABELLA1;

CREATE TABLE Cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)NOT NULL,
    email VARCHAR(120)NOT NULL,
    telefone VARCHAR(15),
    cidade VARCHAR(60) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE 
);

CREATE TABLE categoria(
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY
    (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME NOT NULL,
    status_pedido ENUM('ABERTO', 'PREPARANDO', 'FINALIZADO','CANCELADO') NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
    
);



CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(150),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);


CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10.2) NOT NULL,
    data_pagamento DATETIME,
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pagamento_forma_pagamento FOREIGN KEY (id_forma_pagamento)
    REFERENCES forma_pagamento (id_forma_pagamento)
);


INSERT INTO categoria(nome) VALUES
('Cafés'),
('Bebidas Geladas'),
('Bebidas Quentes'),
('Salgados'),
('Sobremesas'),
('Combo');


INSERT INTO produto(nome,preco,ativo,id_categoria) VALUES
('Café Tradicional',7.00,TRUE,1),
('Sobremesa', 23.00,TRUE,2),
('salgados',10.00,TRUE,3),
('bebidas',8.00,TRUE,4),
('comida',45.00,TRUE,5)

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES 
('2026-10-02 08:16:00','PREPARANDO', 0.00,10),
('2026-12-03 09:14:00','FINALIZADO',0.00,11),
('2026-10-30 04:44:00', 'FINALIZADO', 0.00,12),
('2026-10-30 04:03:00', 'CANCELADO', 0.00,13),
('2026-10-31 04:04:00', 'ABERTO', 0.00,14);


SELECT * FROM pedido;

INSERT INTO categoria(nome) VALUES
('especiais da house');

--Procedimento de uma compra
--PASSO 1: REALIAR CADASTRO CLIENTE

INSERT INTO cliente(nome, email, telefone,cidade,ativo) VALUES
('Carlos Silva','carlossilva3@gmail.com',19999999999999,'Santos',TRUE);


SET @cliente_compra = LAST_INSERT_ID();

---PASSO 2: REALIZAR O PEDIDO

INSERT INTO pedido (data_pedido,status_pedido, valor_total,id_cliente) VALUES
(NOW(),'ABERTO',0.00,@cliente_compra);

SET @pedido_compra = LAST_INSERT_ID();

--PASSO 3: INSERINDO ITENS

INSERT INTO item_pedido(id_pedido, id_produto, quantidade, preco_unitario) VALUES
(@pedido_compra,4,1,13.00), (@pedido_compra,9,1,9.00);

-- PASSO 4 - ATUALIZANDO TOTAL E STATUS
UPDATE pedido ativo
SET valor_total = 22.00,
    status = 'PREPARANDO'
    WHERE id_pedido = @pedido_compra;

-- PASSO 5 - REGISTRAR PAGAMENTO 
INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento) VALUES
(@pedido_compra,2,22.00,NOW());


--PASSO 6 - CONSULAR O PEDIDO E RESULTADO

SELECT p.id_pedido,
c.nome AS Nome_Cliente,
p.status AS Status_Pedido,
p.valor_total AS Compra_Total
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido = @pedido_compra;

INSERT INTO cliente(nome,email,telefone,cidade,ativo) VALUES
('Arthur Nunes','arthur@email.com','1999999991','Rondonia',TRUE),
('Beatriz Raissa','beatriz@email.com','1999999991','Limeira',TRUE),
('Davi Ferreira','davi@email.com',NULL,'Limeira',TRUE),
('Francisco Magri','chico@email.com','1999999994','Limeira',TRUE),
('Franz Kramer','franz@email.com','1999999994','Limeira',TRUE),
('Gabriel Nouqueira','gabriel@email.com','1999999995','Limeira',TRUE),
('Gabrielli Araujo','gabrielli@email.com','1999999996','Americana',TRUE),
('Isabella Alves','isabella@email.com',NULL,'Rondonia',TRUE),
('Keynan Santos','keynan@email.com','1999999998','Santos',TRUE),
('Larissa Ramires','larissa@email.com','1999999998','Limeira',TRUE),
('Leonardo Dia','leonardo@email.com','1999999999','Valinhos',TRUE),
('Luana Lima','luana@email.com','1999999910','Limeira',TRUE),
('Luccas manfredi','luccas@email.com','1999999910','Limeira',TRUE),
('Livia Stein','livia@email.com','1999999991','Campinas',TRUE),
('Dandara Dias','dandara@gmail.com','1999999993','Limeira',TRUE);
INSERT INTO categoria (nome) VALUES
('cafés'),('bebidas Geladas'),('Bebidas Quentes'),('Salgados'),('Sobremesas'),('Combo');

INSERT INTO categoria (nome) VALUES
('Doces');

SET @CATEGORIA = LAST_INSERT_ID();

SELECT @CATEGORIA;

-- ATUALIZANDO OU MODIFICANDO DADOS NO BD
-- LEMBRAR DE SEMPRE EXECUTAR O SELECT PARA ATUALIZAR (UPDATE)
-- E NUNCA JAMAIS NEVER FAÇA UM UPDATE SEM WHERE
-- EX 1: MODIFICANDO VALORES INDIVIDUAIS


UPDATE Cliente
SET telefone = '1988880001'
WHERE id_cliente = 8 


-- EX 2: MODIFICANDO VARIOS VALORES 
-- CONSULTAR DADOS NO BD
UPDATE Cliente
SET telefone = '19999999901',
    CIDADE='Piracicaba'
    WHERE id_cliente = 8;



---APAGAR DADOS DA TABELA NO BD
DELETE FROM cliente
WHERE id_cleinte = 8;


SELECT * FROM cliente;

SELECT * FROM;

CONSUTAR DADOS NO BD;

SELECT * FROM cliente;
WHERE id_cliente = 9;

SELECT * from categoria;


EXEMPLOS 
-- O ROLLBACK É PARA VOCÊ MODIFICAR OS NUMEROS DA TABELA 

START TRANSACTION;

UPDATE produto
SET preco = preco * 2.80
WHERE id_categoria = 1;
--  DESFAZER O QUE FIZEMOS ERRADO OU VOLTA UMA TRANSAÇÃO 

ROLLBACK;
-- VALIDA O PROCEDIMENTO DE TRANSAÇÃO


COMMIT;

START TRANSACTION;

UPDATE cliente SET cidade = 'Santos' WHERE id_cliente = 121;
SELECT * FROM cliente WHERE id_cliente = 121;

COMMIT;

ROLLBACK;

SELECT * from categoria;
SET @categoria_especial = (SELECT id_categoria FROM categoria WHERE nome = 'Especiais da Casa');

INSERT INTO produto (nome,preco,ativo,id_categoria) VALUES
('Cupcake',8.00,TRUE,14),
('Mousse de Chocolate', 25.00, TRUE, 14),
('Fondue', 15.00, TRUE, 14);

-- UTILIZAR O SET ANTES DA TAREFA AJUDA A ARMAZENAR O VALOR DA DEFINIÇÃO ATRIBUIDA E PODE SER REUTILIZADA DEPOIS.
INSERT INTO produto (nome,preco,ativo,id_categoria) VALUES
('Sorvete Fit',8.00,TRUE,@categoria_especial);




