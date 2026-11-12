-- Active: 1794488659279@@127.0.0.1@3308@retrogame_recuperacao

-- 1. Criar e selecionar o banco
CREATE DATABASE retrogame_recuperacao;
USE retrogame_recuperacao;
DROP TABLE PLATAFORMA;
-- 2.
CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE
);

-- 3.
CREATE TABLE PLATAFORMA (
    id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE CATEGORIA (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(80) NOT NULL UNIQUE
);

-- 4.
CREATE TABLE JOGO (
    id_jogo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    ano_lancamento INT NOT NULL,
    quantidade_disponivel INT DEFAULT 0 CHECK (quantidade_disponivel >= 0),
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT FK_jogo_plataforma FOREIGN KEY (id_plataforma) REFERENCES PLATAFORMA(id_plataforma),
    CONSTRAINT FK_jogo_categoria FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

-- 5.
CREATE TABLE LOCACAO (
    id_locacao INT PRIMARY KEY AUTO_INCREMENT,
    data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE,
    status_locacao VARCHAR(20) DEFAULT 'ABERTA' CHECK (status_locacao IN ('ABERTA', 'DEVOLVIDA', 'ATRASADA')),
    id_cliente INT NOT NULL,
    id_jogo INT NOT NULL,
    CONSTRAINT FK_locacao_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE RESTRICT,
    CONSTRAINT FK_locacao_jogo FOREIGN KEY (id_jogo) REFERENCES JOGO(id_jogo) ON DELETE RESTRICT
);

-- 6.
ALTER TABLE JOGO ADD COLUMN desenvolvedora VARCHAR(100);


-- 7.
INSERT INTO CLIENTE (nome, email, telefone, ativo) VALUES
('Juliana Santos', 'juliana@email.com', '19991235678', TRUE),
('Antonio Ferreira', 'antonio@email.com', NULL, TRUE),
('Eliane Pimentel', 'Eliane@email.com', '19987629021', TRUE),
('Caroline Virginia', 'Caroline@email.com', '16789887766', TRUE);

-- 8.

INSERT INTO PLATAFORMA (nome) VALUES
('Nintendo'), 
('PlayStation'),
('Xbox');

INSERT INTO CATEGORIA (descricao) VALUES 
('RPG'), 
('Simulação');

INSERT INTO JOGO (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria, desenvolvedora) VALUES
('GTA V', 'jogo1', 2013, 5, 2, 1, 'Rockstar Games'),
('Mario', 'jogo2', 1990, 4, 1, 1, 'Nintendo'),
('FIFA 19', 'jogo3', 2018, 3, 3, 2, 'EA Sports'),
('The Sims 1', 'jogo4', 2000, 2, 1, 2, 'Maxis'),
('Mortal Kombat', 'jogo5', 1992, 6, 3, 1, 'Midway'),
('The Last of Us', 'jogo6', 2013, 4, 2, 1, 'Naughty Dog');

-- 9.
INSERT INTO LOCACAO (data_retirada, data_prevista, data_devolucao, status_locacao, id_cliente, id_jogo) VALUES
(CURRENT_TIMESTAMP, '2026-11-5', NULL, 'ABERTA', 1, 1),
(CURRENT_TIMESTAMP, '2026-11-10', NULL, 'ABERTA', 2, 2),
(CURRENT_TIMESTAMP, '2026-11-25', NULL, 'ABERTA', 3, 6);

UPDATE JOGO
SET quantidade_disponivel = quantidade_disponivel - 1
WHERE id_jogo IN (1, 2, 6);

-- 10.
SELECT id_cliente, nome, telefone FROM CLIENTE WHERE id_cliente = 2;

UPDATE CLIENTE
SET telefone = '19988881111'
WHERE id_cliente = 2;

-- 11.
UPDATE JOGO
SET quantidade_disponivel = quantidade_disponivel + 2
WHERE ano_lancamento >= 2000;

-- 12.
INSERT INTO CLIENTE (nome, email, telefone) VALUES ('Cliente Ana', 'ana@email.com', '11900067900');
DELETE FROM CLIENTE WHERE email = 'ana@email.com';

-- 13.
SELECT titulo, ano_lancamento, quantidade_disponivel FROM JOGO;

-- 14.
SELECT titulo, quantidade_disponivel FROM JOGO WHERE quantidade_disponivel > 2 ORDER BY quantidade_disponivel DESC;

-- 15.
SELECT * FROM JOGO WHERE titulo LIKE '%mario%';

-- 16.
SELECT titulo, ano_lancamento FROM JOGO WHERE ano_lancamento BETWEEN 1990 AND 2005;

-- 17.
SELECT 
    COUNT(*) AS total_jogos,
    SUM(quantidade_disponivel) AS total_estoque,
    AVG(quantidade_disponivel) AS media_estoque,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM JOGO;

-- 18.
SELECT 
    l.id_locacao,
    c.nome AS cliente,
    j.titulo AS jogo,
    l.data_retirada,
    l.status_locacao
FROM LOCACAO l
INNER JOIN CLIENTE c ON l.id_cliente = c.id_cliente
INNER JOIN JOGO j ON l.id_jogo = j.id_jogo;

-- 19.
SELECT 
    l.id_locacao,
    c.nome AS cliente,
    j.titulo AS jogo,
    l.data_retirada,
    l.status_locacao
FROM LOCACAO l
INNER JOIN CLIENTE c ON l.id_cliente = c.id_cliente
INNER JOIN JOGO j ON l.id_jogo = j.id_jogo
WHERE l.status_locacao = 'ABERTA';

-- 20.
SELECT 
    c.nome AS cliente,
    COUNT(l.id_locacao) AS quantidade_locacoes
FROM CLIENTE c
INNER JOIN LOCACAO l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY quantidade_locacoes DESC;

-- 21.
SELECT 
    c.nome AS cliente,
    COUNT(l.id_locacao) AS quantidade_locacoes
FROM CLIENTE c
LEFT JOIN LOCACAO l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome;




-- 22.
START TRANSACTION;
    INSERT INTO LOCACAO (data_prevista, status_locacao, id_cliente, id_jogo) VALUES ('2026-11-30', 'ABERTA', 4, 3);
    
    UPDATE JOGO
    SET quantidade_disponivel = quantidade_disponivel - 1
    WHERE id_jogo = 3 AND quantidade_disponivel > 0;
    
    SELECT * FROM LOCACAO WHERE id_cliente = 4;
    SELECT id_jogo, titulo, quantidade_disponivel FROM JOGO WHERE id_jogo = 3;
COMMIT;

-- 23.
START TRANSACTION;
    SELECT id_jogo, titulo, quantidade_disponivel FROM JOGO WHERE id_jogo = 4;
    
    UPDATE JOGO
    SET quantidade_disponivel = 50
    WHERE id_jogo = 4;
    
    SELECT id_jogo, titulo, quantidade_disponivel FROM JOGO WHERE id_jogo = 4;
ROLLBACK;
SELECT id_jogo, titulo, quantidade_disponivel FROM JOGO WHERE id_jogo = 4;

-- 24.
START TRANSACTION;
    UPDATE JOGO
    SET quantidade_disponivel = quantidade_disponivel + 1
    WHERE id_jogo = 1;
    
    SAVEPOINT sp_primeiro_jogo;
    
    UPDATE JOGO
    SET quantidade_disponivel = quantidade_disponivel + 1
    WHERE id_jogo = 5;
    
    ROLLBACK TO SAVEPOINT sp_primeiro_jogo;
COMMIT;
SELECT id_jogo, titulo, quantidade_disponivel FROM JOGO WHERE id_jogo IN (1, 5);


