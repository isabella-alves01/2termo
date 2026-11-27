

-- ATIVIDADE AMPLIADA - AULAS 14 E 15

-- 1. Function calcular_total_item
DELIMITER $$

CREATE FUNCTION calcular_total_produto
(p_preco DECIMAL(10,2), p_quantidade INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_preco * p_quantidade;
END$$

DELIMITER ;

SELECT nome, preco, calcular_total_produto(preco, 10) AS Total_10_unidades
FROM produto;


-- 2. Function classificar_fidelidade
DELIMITER $$

CREATE FUNCTION classificao_fidelidade
(p_pontos INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_pontos >= 10 THEN
        RETURN 'ARRASOU';
    ELSEIF p_pontos >= 5 THEN
        RETURN 'TA NA MÉDIA';
    ELSE
        RETURN 'QUASE LÁ';
    END IF;
END$$

SELECT nome, pontos_fidelidade, classificao_fidelidade(pontos_fidelidade) AS Nível
FROM cliente;


-- 3. Function calcular_desconto

DROP FUNCTION IF EXISTS calcular_desconto$$
DELIMITER $$

CREATE FUNCTION calcular_desconto
(
    p_valor DECIMAL(10,2),
    p_pontos INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_percentual DECIMAL (5,2);
    IF p_pontos >= 300 THEN
        SET v_percentual = 0.40;
    ELSEIF p_pontos >= 100 THEN
        SET v_percentual = 0.25;
    ELSE
        SET V_percentual = 0;
    END  IF;
    RETURN p_valor * v_percentual;
END $$

DELIMITER ;

SELECT calcular_desconto(200.00, 1200) AS valor_desconto;


-- 4. Function situacao_estoque

DELIMITER $$

CREATE FUNCTION situacao_estoque (
    p_quantidade INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF P_QUANTIDADE = 0 THEN
        RETURN 'SEM ESTOQUE BAIXO';
    ELSEIF p_quantidade <=10 THEN
        RETURN 'ESTOQUE BAIXO';
    ELSE
        RETURN 'ESTOQUE NORMAL';
    END IF;
END$$

DELIMITER;


-- EXEMPLO 1
SELECT ID_PRODUTO, SITUACAO_ESTOQUE(QUANTIDADE) AS SITUAÇÃO_ESTOQUE FROM ESTOQUE;

-- EXEMPLO 2

SELECT E.ID_PRODUTO, P.NOME AS PRODUTO, E.QUANTIDADE, situacao_estoque(E.QUANTIDADE) AS STATUS_ESTOQUE FROM ESTOQUE AS E INNER JOIN PRODUTO AS P
ON E.ID_PRODUTO = P.ID_PRODUTO
ORDER BY ID_PRODUTO;



-- 5. Testar todas as functions em SELECT



SELECT nome, preco, calcular_total_produto(preco, 10) AS Total_10_unidades
FROM produto;

SELECT nome, pontos_fidelidade, classificao_fidelidade(pontos_fidelidade) AS Nível
FROM cliente;

SELECT calcular_desconto(200.00, 1200) AS valor_desconto;


-- EXEMPLO 1
SELECT ID_PRODUTO, SITUACAO_ESTOQUE(QUANTIDADE) AS SITUAÇÃO_ESTOQUE FROM ESTOQUE;

-- EXEMPLO 2

SELECT E.ID_PRODUTO, P.NOME AS PRODUTO, E.QUANTIDADE, situacao_estoque(E.QUANTIDADE) AS STATUS_ESTOQUE FROM ESTOQUE AS E INNER JOIN PRODUTO AS P
ON E.ID_PRODUTO = P.ID_PRODUTO
ORDER BY ID_PRODUTO;



-- 6. Criar auditoria_preco

CREATE TABLE AUDITORIA_PRECOS (
     ID_AUDITORIA INT AUTO_INCREMENT,
     ID_PRODUTO INT NOT NULL,
     PRECO_ANTERIOR DECIMAL(10,2),
     PRECO_NOVO DECIMAL(10,2),
     ALTERADO_EM  DATETIME DEFAULT CURRENT_TIMESTAMP,
     CONSTRAINT PK_ID_AUDITORIA PRIMARY KEY(ID_AUDITORIA),
     CONSTRAINT FK_PRODUTOS FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO)
 );

DELIMITER $$

-- 7. Trigger AFTER UPDATE de preço

CREATE TRIGGER TRIGGER_PRODUTO_PRECO_UPDATE
AFTER UPDATE ON PRODUTO 
FOR EACH ROW
BEGIN
IF OLD.PRECO <> NEW.PRECO THEN
    INSERT INTO AUDITORIA_PRECO (ID_PRODUTO, PRECO_ANTERIOR, PRECO_NOVO)
    VALUES (NEW.ID_PRODUTO, OLD.PRECO, NEW.PRECO);
END IF;
END$$

DELIMITER ;

-- 8. Trigger BEFORE UPDATE impedindo estoque negativo

CREATE TRIGGER TRIGGER_ESTOQUE_BEFORE_UPDATE
BEFORE UPDATE ON ESTOQUE
FOR EACH ROW
BEGIN
    IF NEW.QUANTIDADE < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ESTOQUE NÃO PODE FICAR NEGATIVO';
    END IF;
END $$
DELIMITER ;

-- 9. Criar log_exclusao_produto

DELIMITER$$
CREATE TABLE LOG_EXCLUSAO_PRODUTOS
(
    ID_LOG INT AUTO_INCREMENT,
    ID_PRODUTO INT,
    NOME_PRODUTO VARCHAR(130),
    EXCLUIDO_EM DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_ID_LOG PRIMARY KEY (ID_LOG),
    CONSTRAINT FK_PRODUTO_ID FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO)
);
DELIMITER$$


-- 10. Trigger AFTER DELETE
-- 11. Demonstrar operação bloqueada
-- 12. Demonstrar histórico gerado automaticamente
-- 13. SHOW TRIGGERS
-- 14. SHOW CREATE TRIGGER
-- 15. Explique: Function x Procedure x View x Trigger
-- 16. Cite 3 regras em que CHECK/UNIQUE/FK seriam melhores que Trigger
-- DESAFIO: crie uma automação própria e justifique a escolha do recurso.