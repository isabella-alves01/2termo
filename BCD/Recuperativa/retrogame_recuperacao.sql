
    create database if not exists retrogame_recuperacao;
    use retrogame_recuperacao;

    -- 2. Crie os campos especificados e garanta obrigatoriedade, e-mail
    -- ,exclusivo e ativo por padrão

    CREATE TABLE CLIENTE (
    ID_USUARIO INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(120) NOT NULL UNIQUE,
    TELEFONE VARCHAR(20),
    ATIVO BOOLEAN DEFAULT TRUE
    );


-- 3. Crie duas tabelas com suas chaves e valores exclusivos. 
-- Esssas tabelas serão referencias por JOGO.

CREATE TABLE CATEGORIA (
    ID_CATEGORIA INT AUTO_INCREMENT PRIMARY KEY,
    NOME_CATEGORIA VARCHAR(100) NOT NULL UNIQUE,
    ANO_CATEGORIA DATE NOT NULL
    
);

CREATE TABLE PLATAFORMA (
    ID_PLATAFORMA INT AUTO_INCREMENT PRIMARY KEY,
    NOME_PLATAFORMA VARCHAR(60) NOT NULL UNIQUE,
    ANO_PLATAFORMA DATE NOT NULL,
);

-- 4. Crie a tabela com pK, código exclusivo,
--  estoque não negativo e FKs para plataformas e categorias 

ALTER TABLE JOGO
CREATE TABLE JOGO (
    ID_JOGO INT AUTO_INCREMENT PRIMARY KEY,
    CODIGO VARCHAR(30) NOT NULL UNIQUE,
    NOME_JOGO VARCHAR(100) NOT NULL,
    ESTOQUE INT NOT NULL DEFAULT 0,
    ID_PLATAFORMA INT NOT NULL,
    ID_CATEGORIA INT NOT NULL,
    CONSTRAINT CHK_JOGO_ESTOQUE CHECK (ESTOQUE >= 0),
    CONSTRAINT FK_JOGO_PLATAFORMA
    FOREIGN KEY (ID_PLATAFORMA) REFERENCES PLATAFORMA (ID_PLATAFORMA),
    CONSTRAINT FK_JOGO_CATEGORIA
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA (ID_CATEGORIA)
);


-- 5.  Tabela LOCACAO Crie PK, FKs obrigatorias , defaults e check do status. preserve 
-- os historicos contra exclusões 

CREATE TABLE LOCACAO (
ID_LOCACAO INT AUTO_INCREMENT PRIMARY KEY,
DATA_EMPRESTIMO DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT CK_STATUS_EMPRESTIMO CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
CONSTRAINT FK_NOME_CLIENTE,
CONSTRAINT FK_NOME_JOGO,
CONSTRAINT FK_CODIGO_JOGO,
)

-- 6. Acrescente desenvolvedora VARCHAR(100) a tabela JOGO usando ALTER TABLE 

-- FEITO!

-- 7. Insira pelo menos 4 clientes. Um deles deve ter telefone NULL

INSERT INTO CLIENTE ( ID_USUARIO, NOME, EMAIL, TELEFONE, ATIVO ) VALUES
('Juliana Medeiros','Juliana@email.com','1999934591',TRUE),
('joao fonseca','joao@email.com','1992399991',TRUE),
('Isabella Alves','isabella@email.com',NULL,TRUE),
('Rafaela','rafaela@email.com','1999999994',TRUE);


-- 8.Inserir plataformas, categorias e jogos 
INSERT INTO PLATAFORMA (ID_PLATAFORMA, NOME_PLATAFORMA, ANO_PLATAFORMA) VALUES
(1,"Steam",2003),
(2,"GOG.com",2018),

INSERT CATEGORIAS (ID_CATEGORIA, NOME_CATEGORIA) VALUES
(1,"Ação"),
(2,"Aventura"),

INSERT INTO JOGO (ID_JOGO, CODIGO, NOME_JOGO, ESTOQUE) VALUES
(1,2310,pou,1000),
(2,2323,jogo das princesas,99),
(3,2344,Fortnite,234),
(4,2336,Forza Horizon,90),
(5,2435,Elden Ring,34),

-- 10. Localize com cliente com SELECT e modifique seu telefone 
-- com update e where

FROM * SELECT CLIENTE;

UPDATE USUARIO 
SET telefone = '19955559444' 
WHERE id_usuario = 2;


-- 11. Acrescente 2 unidades ao estoque de cada jogo lançado a partir  do ano 2000




-- 12.DELETE e protecao do historico




-- 13.SELECT basico 

SELECT titulo, ano_lancamento, quantidade_disponivel 
FROM  JOGOS;


14.Mostre jogos com estoque maior que 2, do maior para o menor estoque.


SELECT * FROM JOGOS 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 15.Pesquise jogos cujo titulo contenha uma palavra escolhida por voce 
