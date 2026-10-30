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



 =============================================================================
-- ESCOLA SENAI - ATIVIDADE PRÁTICA: BIBLIOTECA CONECTA
-- Banco de Dados Relacional: DDL, DML, DQL e TCL
-- =============================================================================

-- =============================================================================
-- FASE 1 — DDL: CRIAÇÃO E ESTRUTURA (25 pontos)
-- =============================================================================

-- 1. Criação do banco e seleção
CREATE DATABASE IF NOT EXISTS biblioteca_som2;
USE biblioteca_som2;

-- 2. Tabela USUARIO (RN01, RN02, RN03)
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);

-- 3. Tabela LIVRO (RN04, RN05, RN06)
CREATE TABLE LIVRO (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0)
);

-- 4. Tabela EMPRESTIMO (RN07, RN08, RN09, RN10, RN11, RN12, RN16, RN17)
CREATE TABLE EMPRESTIMO (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE RESTRICT,
    CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro) ON DELETE RESTRICT
);

-- 5. ALTER TABLE: Adicionando coluna editora
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100) NULL;


-- =============================================================================
-- FASE 2 — DML: MANIPULAÇÃO DE DADOS (25 pontos)
-- =============================================================================

-- 6. INSERT de usuários (4 cadastros, sendo um com telefone NULL)
INSERT INTO USUARIO (nome, email, telefone) VALUES
('Ana Silva', 'ana.silva@email.com', '19991112222'),
('Carlos Eduardo', 'carlos.eduardo@email.com', NULL),
('Mariana Costa', 'mariana.costa@email.com', '19988887777'),
('Roberto Souza', 'roberto.souza@email.com', '19977776666');

-- 7. INSERT de livros (6 cadastros)
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicacao, quantidade_disponivel, editora) VALUES
('Dom Casmurro', 'Machado de Assis', '9788535902777', 1899, 3, 'Companhia das Letras'),
('O Alquimista', 'Paulo Coelho', '9788575427583', 1988, 5, 'Sextante'),
('Algoritmos Teoria e Prática', 'Thomas Cormen', '9788535236996', 2012, 1, 'Elsevier'),
('Clean Code', 'Robert C. Martin', '9788576082675', 2009, 2, 'Alta Books'),
('O Imprevisível', 'Lucas Lima', '9788500002021', 2021, 4, 'Intrínseca'),
('Banco de Dados Moderno', 'Fernando Reis', '9788500002022', 2023, 0, 'Novatec');

-- 8. INSERT de empréstimos (3 empréstimos ABERTOS)
INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES
('2026-11-15', 1, 1),
('2026-11-20', 2, 3),
('2026-11-25', 3, 4);

-- 9. UPDATE: Localizar usuário e alterar seu telefone
SELECT * FROM USUARIO WHERE id_usuario = 2;

UPDATE USUARIO 
SET telefone = '19955554444' 
WHERE id_usuario = 2;

-- 10. Atualização em lote (+2 exemplares para livros publicados a partir de 2020)
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_publicacao >= 2020;

-- 11. DELETE e teste de integridade
-- 11a. Criar e excluir usuário sem empréstimos (Sucesso esperado)
INSERT INTO USUARIO (nome, email, telefone) VALUES ('Usuário Teste', 'teste@email.com', '19900000000');
DELETE FROM USUARIO WHERE email = 'teste@email.com';

-- 11b. Tentativa de exclusão de usuário COM empréstimo (Falha esperada por RESTRICT / FK)
-- DELETE FROM USUARIO WHERE id_usuario = 1; 
/*
   EXPLICAÇÃO:
   A instrução acima falha e gera o erro SQL Error 1451 (Cannot delete or update a parent row: a foreign key constraint fails).
   Isso ocorre porque definimos a chave estrangeira (FK) com a cláusula ON DELETE RESTRICT.
   Como o usuário com id_usuario = 1 possui registros vinculados na tabela EMPRESTIMO, 
   o MySQL bloqueia a exclusão para garantir a integridade referencial do banco de dados (RN16).
*/


-- =============================================================================
-- FASE 3 — DQL: CONSULTAS E ANÁLISE (30 pontos)
-- =============================================================================

-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;

-- 13. WHERE + ORDER BY
SELECT * 
FROM LIVRO 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 14. LIKE
SELECT * 
FROM LIVRO 
WHERE titulo LIKE '%Dados%';

-- 15. BETWEEN
SELECT * 
FROM LIVRO 
WHERE ano_publicacao BETWEEN 2015 AND 2025;

-- 16. Funções agregadas
SELECT 
    COUNT(*) AS total_livros,
    SUM(quantidade_disponivel) AS total_exemplares,
    AVG(quantidade_disponivel) AS media_exemplares,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN
SELECT 
    E.id_emprestimo,
    U.nome AS usuario,
    L.titulo AS livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro;

-- 18. JOIN + WHERE (Empréstimos ABERTOS)
SELECT 
    E.id_emprestimo,
    U.nome AS usuario,
    L.titulo AS livro,
    E.data_prevista,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro
WHERE E.status_emprestimo = 'ABERTO';

-- 19. GROUP BY
SELECT 
    U.nome AS usuario,
    COUNT(E.id_emprestimo) AS quantidade_emprestimos
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
GROUP BY U.id_usuario, U.nome
ORDER BY quantidade_emprestimos DESC;

-- 20. LEFT JOIN (Todos os usuários, com ou sem empréstimos)
SELECT 
    U.nome AS usuario,
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome;


-- =============================================================================
-- FASE 4 — TCL: TRANSAÇÕES E INTEGRIDADE (20 pontos)
-- =============================================================================

-- 21. Transação de empréstimo (Novo empréstimo + redução de estoque)
START TRANSACTION;

INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) 
VALUES ('2026-11-30', 4, 2);

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel - 1 
WHERE id_livro = 2;

-- Conferência dentro da transação
SELECT * FROM EMPRESTIMO WHERE id_usuario = 4 AND id_livro = 2;
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 2;

COMMIT;


-- 22. ROLLBACK (Alterar e reverter)
START TRANSACTION;

UPDATE LIVRO 
SET quantidade_disponivel = 99 
WHERE id_livro = 1;

-- Conferência (valor alterado temporariamente)
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;

ROLLBACK;

-- Comprovação do retorno do valor original
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;


-- 23. SAVEPOINT
START TRANSACTION;

-- Primeira alteração
UPDATE LIVRO SET quantidade_disponivel = 10 WHERE id_livro = 1;

SAVEPOINT ponto_1;

-- Segunda alteração
UPDATE LIVRO SET quantidade_disponivel = 20 WHERE id_livro = 2;

-- Desfaz apenas a segunda alteração
ROLLBACK TO SAVEPOINT ponto_1;

-- Confirma a primeira alteração
COMMIT;

-- Comprovação: Livro 1 alterado para 10, Livro 2 permanece inalterado
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro IN (1, 2);


-- 24. Transação de devolução
START TRANSACTION;

UPDATE EMPRESTIMO 
SET status_emprestimo = 'DEVOLVIDO', 
    data_devolucao = CURDATE() 
WHERE id_emprestimo = 1 AND status_emprestimo = 'ABERTO';

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 1 
WHERE id_livro = (SELECT id_livro FROM EMPRESTIMO WHERE id_emprestimo = 1);

COMMIT;


-- =============================================================================
-- ESCOLA SENAI - ATIVIDADE PRÁTICA: BIBLIOTECA CONECTA
-- Banco de Dados Relacional: DDL, DML, DQL e TCL
-- =============================================================================

-- =============================================================================
-- FASE 1 — DDL: CRIAÇÃO E ESTRUTURA (25 pontos)
-- =============================================================================

-- 1. Criação do banco e seleção
CREATE DATABASE IF NOT EXISTS biblioteca_som2;
USE biblioteca_som2;

-- 2. Tabela USUARIO (RN01, RN02, RN03)
CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);

-- 3. Tabela LIVRO (RN04, RN05, RN06)
CREATE TABLE LIVRO (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0)
);

-- 4. Tabela EMPRESTIMO (RN07, RN08, RN09, RN10, RN11, RN12, RN16, RN17)
CREATE TABLE EMPRESTIMO (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE RESTRICT,
    CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro) ON DELETE RESTRICT
);

-- 5. ALTER TABLE: Adicionando coluna editora
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100) NULL;


-- =============================================================================
-- FASE 2 — DML: MANIPULAÇÃO DE DADOS (25 pontos)
-- =============================================================================

-- 6. INSERT de usuários (4 cadastros, sendo um com telefone NULL)
INSERT INTO USUARIO (nome, email, telefone) VALUES
('Ana Silva', 'ana.silva@email.com', '19991112222'),
('Carlos Eduardo', 'carlos.eduardo@email.com', NULL),
('Mariana Costa', 'mariana.costa@email.com', '19988887777'),
('Roberto Souza', 'roberto.souza@email.com', '19977776666');

-- 7. INSERT de livros (6 cadastros)
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicacao, quantidade_disponivel, editora) VALUES
('Dom Casmurro', 'Machado de Assis', '9788535902777', 1899, 3, 'Companhia das Letras'),
('O Alquimista', 'Paulo Coelho', '9788575427583', 1988, 5, 'Sextante'),
('Algoritmos Teoria e Prática', 'Thomas Cormen', '9788535236996', 2012, 1, 'Elsevier'),
('Clean Code', 'Robert C. Martin', '9788576082675', 2009, 2, 'Alta Books'),
('O Imprevisível', 'Lucas Lima', '9788500002021', 2021, 4, 'Intrínseca'),
('Banco de Dados Moderno', 'Fernando Reis', '9788500002022', 2023, 0, 'Novatec');

-- 8. INSERT de empréstimos (3 empréstimos ABERTOS)
INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES
('2026-11-15', 1, 1),
('2026-11-20', 2, 3),
('2026-11-25', 3, 4);

-- 9. UPDATE: Localizar usuário e alterar seu telefone
SELECT * FROM USUARIO WHERE id_usuario = 2;

UPDATE USUARIO 
SET telefone = '19955554444' 
WHERE id_usuario = 2;

-- 10. Atualização em lote (+2 exemplares para livros publicados a partir de 2020)
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_publicacao >= 2020;

-- 11. DELETE e teste de integridade
-- 11a. Criar e excluir usuário sem empréstimos (Sucesso esperado)
INSERT INTO USUARIO (nome, email, telefone) VALUES ('Usuário Teste', 'teste@email.com', '19900000000');
DELETE FROM USUARIO WHERE email = 'teste@email.com';

-- 11b. Tentativa de exclusão de usuário COM empréstimo (Falha esperada por RESTRICT / FK)
-- DELETE FROM USUARIO WHERE id_usuario = 1; 
/*
   EXPLICAÇÃO:
   A instrução acima falha e gera o erro SQL Error 1451 (Cannot delete or update a parent row: a foreign key constraint fails).
   Isso ocorre porque definimos a chave estrangeira (FK) com a cláusula ON DELETE RESTRICT.
   Como o usuário com id_usuario = 1 possui registros vinculados na tabela EMPRESTIMO, 
   o MySQL bloqueia a exclusão para garantir a integridade referencial do banco de dados (RN16).
*/


-- =============================================================================
-- FASE 3 — DQL: CONSULTAS E ANÁLISE (30 pontos)
-- =============================================================================

-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;

-- 13. WHERE + ORDER BY
SELECT * 
FROM LIVRO 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 14. LIKE
SELECT * 
FROM LIVRO 
WHERE titulo LIKE '%Dados%';

-- 15. BETWEEN
SELECT * 
FROM LIVRO 
WHERE ano_publicacao BETWEEN 2015 AND 2025;

-- 16. Funções agregadas
SELECT 
    COUNT(*) AS total_livros,
    SUM(quantidade_disponivel) AS total_exemplares,
    AVG(quantidade_disponivel) AS media_exemplares,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN
SELECT 
    E.id_emprestimo,
    U.nome AS usuario,
    L.titulo AS livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro;

-- 18. JOIN + WHERE (Empréstimos ABERTOS)
SELECT 
    E.id_emprestimo,
    U.nome AS usuario,
    L.titulo AS livro,
    E.data_prevista,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro
WHERE E.status_emprestimo = 'ABERTO';

-- 19. GROUP BY
SELECT 
    U.nome AS usuario,
    COUNT(E.id_emprestimo) AS quantidade_emprestimos
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
GROUP BY U.id_usuario, U.nome
ORDER BY quantidade_emprestimos DESC;

-- 20. LEFT JOIN (Todos os usuários, com ou sem empréstimos)
SELECT 
    U.nome AS usuario,
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome;


-- =============================================================================
-- FASE 4 — TCL: TRANSAÇÕES E INTEGRIDADE (20 pontos)
-- =============================================================================

-- 21. Transação de empréstimo (Novo empréstimo + redução de estoque)
START TRANSACTION;

INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) 
VALUES ('2026-11-30', 4, 2);

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel - 1 
WHERE id_livro = 2;

-- Conferência dentro da transação
SELECT * FROM EMPRESTIMO WHERE id_usuario = 4 AND id_livro = 2;
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 2;

COMMIT;


-- 22. ROLLBACK (Alterar e reverter)
START TRANSACTION;

UPDATE LIVRO 
SET quantidade_disponivel = 99 
WHERE id_livro = 1;

-- Conferência (valor alterado temporariamente)
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;

ROLLBACK;

-- Comprovação do retorno do valor original
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;


-- 23. SAVEPOINT
START TRANSACTION;

-- Primeira alteração
UPDATE LIVRO SET quantidade_disponivel = 10 WHERE id_livro = 1;

SAVEPOINT ponto_1;

-- Segunda alteração
UPDATE LIVRO SET quantidade_disponivel = 20 WHERE id_livro = 2;

-- Desfaz apenas a segunda alteração
ROLLBACK TO SAVEPOINT ponto_1;

-- Confirma a primeira alteração
COMMIT;

-- Comprovação: Livro 1 alterado para 10, Livro 2 permanece inalterado
SELECT id_livro, titulo, quantidade_disponivel FROM LIVRO WHERE id_livro IN (1, 2);


-- 24. Transação de devolução
START TRANSACTION;

UPDATE EMPRESTIMO 
SET status_emprestimo = 'DEVOLVIDO', 
    data_devolucao = CURDATE() 
WHERE id_emprestimo = 1 AND status_emprestimo = 'ABERTO';

UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 1 
WHERE id_livro = (SELECT id_livro FROM EMPRESTIMO WHERE id_emprestimo = 1);

COMMIT;


-- =============================================================================
-- DESAFIO FINAL DE INTEGRIDADE (Análise Técnica)
-- =============================================================================

/*
1. Cadastrar dois usuários com o mesmo e-mail.
   - Mecanismo: Constraint (`UNIQUE`)
   - Justificativa: A restrição de unicidade a nível de banco garante que valores duplicados na coluna `email` sejam rejeitados diretamente pelo SGBD.

2. Cadastrar dois livros com o mesmo ISBN.
   - Mecanismo: Constraint (`UNIQUE`)
   - Justificativa: Assim como o e-mail, o ISBN é um identificador único universal de uma obra, exigindo a constraint `UNIQUE` na definição da coluna.

3. Permitir quantidade disponível negativa.
   - Mecanismo: Constraint (`CHECK`)
   - Justificativa: A constraint de checagem (`CHECK (quantidade_disponivel >= 0)`) valida o valor numérico antes de realizar a gravação, impedindo que estoques fiquem negativos.

4. Criar empréstimo para usuário inexistente.
   - Mecanismo: Integridade Referencial (`FOREIGN KEY`)
   - Justificativa: A chave estrangeira mapeia `EMPRESTIMO.id_usuario` com `USUARIO.id_usuario`, garantindo que um registro filho só seja criado se existir um pai válido.

5. Excluir livro com histórico de empréstimos.
   - Mecanismo: Integridade Referencial (`FOREIGN KEY` com `ON DELETE RESTRICT`)
   - Justificativa: A ação referencial `RESTRICT` impede que a tabela pai (LIVRO) tenha linhas deletadas enquanto existirem registros associados na tabela filha (EMPRESTIMO).

6. Gravar empréstimo e falhar na redução do estoque.
   - Mecanismo: Transação (`TCL` com `START TRANSACTION`, `COMMIT` e `ROLLBACK`)
   - Justificativa: As transações garantem a propriedade ACID da Atomicidade. Ou ambas as operações (INSERT e UPDATE) funcionam juntas, ou qualquer falha aciona um ROLLBACK total.

7. Emprestar livro cuja quantidade disponível seja zero.
   - Mecanismo: Regra da Aplicação (ou Procedure / Trigger)
   - Justificativa: Embora uma `CHECK` impeça o estoque de ficar negativo, a validação lógica de verificar se há estoque disponível *antes* de tentar iniciar a transação de empréstimo deve ser realizada pela camada de regra de negócio da aplicação backend.
*/









