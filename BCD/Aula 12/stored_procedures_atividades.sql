
USE smartcoffee_procedures_isabella01;

-- AULA 13 - ATIVIDADE STORED PROCEDURES
-- Aluno: Isabella Alves do Carmo Cleto
-- Turma: DEVIS

-- 1. listar_clientes_ativos()

CREATE PROCEDURE LISTAR_CLIENTE()
BEGIN
    SELECT ID_CLIENTE AS CODIGO, NOME, EMAIL, TELEFONE
    FROM CLIENTE
    WHERE ATIVO = TRUE
    ORDER BY NOME;
END

DELIMITER ;

CALL LISTAR_CLIENTE();



-- 2. buscar_produto_por_nome(IN p_busca VARCHAR(100))
DELIMITER $$

DROP PROCEDURE IF EXISTS BUSCAR_PRODUTOS_POR_NOME$$

CREATE PROCEDURE BUSCAR_PRODUTOS_POR_NOME(IN P_BUSCA VARCHAR(100))
BEGIN
    SELECT ID_PRODUTO AS CODIGO, NOME, PRECO
    FROM PRODUTO
    WHERE NOME LIKE P_BUSCA
    AND ATIVO = TRUE
    ORDER BY NOME;
END$$

DELIMITER ;
CALL BUSCAR_PRODUTOS_POR_NOME('%Cappuccino%');


-- 3. produtos_por_categoria(IN p_id_categoria INT)

DELIMITER $$

CREATE PROCEDURE BUSCAR_PRODUTOS_CATEGORIA(IN P_ID_CATEGORIA INT)
BEGIN
    SELECT ID_PRODUTO AS CÓDIGO, NOME, PRECO
    FROM PRODUTO
    WHERE ID_CATEGORIA = P_ID_CATEGORIA
    AND ATIVO = TRUE
    ORDER BY NOME;
END

DELIMITER ;

CALL BUSCAR_PRODUTOS_CATEGORIA(1);



-- 4. total_clientes(OUT p_total INT)

DELIMITER $$

CREATE PROCEDURE TOTAL_CLIENTE( OUT P_TOTAL INT )
BEGIN
    SELECT COUNT(*)
    INTO P_TOTAL
    FROM CLIENTE
    WHERE ATIVO = TRUE;
END

DELIMITER ;

-- 5. consultar_estoque(IN p_id_produto INT) usando variável local

DELIMITER $$

DROP PROCEDURE IF EXISTS CONSULTAR_ESTOQUE$$

CREATE PROCEDURE CONSULTAR_ESTOQUE( IN P_ID_PRODUTO INT )
BEGIN
    DECLARE V_QUANTIDADE INT;
    SELECT QUANTIDADE
    INTO V_QUANTIDADE
    FROM ESTOQUE

    WHERE ID_PRODUTO = P_ID_PRODUTO;

    SELECT V_QUANTIDADE AS QUANTIDADE_ESTOQUE;
END$$
DELIMITER ;
CALL CONSULTAR_ESTOQUE(2);

-- 6. classificar estoque: 0 SEM ESTOQUE / <=5 BAIXO / >5 NORMAL

DELIMITER $$

CREATE PROCEDURE CLASSIFICAR_ESTOQUE ( IN P_ID_PRODUTO INT )
BEGIN
    DECLARE V_QUANTIDADE INT;

    SELECT QUANTIDADE
    INTO V_QUANTIDADE
    FROM ESTOQUE
    WHERE ID_PRODUTO = P_ID_PRODUTO;

    IF V_QUANTIDADE = 0 THEN
        SELECT 'SEM ESTOQUE' AS SITUAÇÃO;
    ELSEIF V_QUANTIDADE <= 5 THEN
        SELECT 'ESTOQUE BAIXO' AS SITUAÇÃO;
    ELSE
    SELECT 'ESTOQUE NORMAL' AS SITUAÇÃO;
    END IF;
    END $$

    DELIMITER;
    CALL CLASSIFICAR_ESTOQUE(10000);

-- 7. cadastrar_cliente(...) com três parâmetros IN

    DELIMITER $$

    CREATE PROCEDURE CADASTRAR_CLIENTE (
        IN P_NOME VARCHAR (100),
        IN P_EMAIL VARCHAR (120),
        IN P_TELEFONE VARCHAR (20)
    )

    BEGIN
        INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE, ATIVO)
        VALUES (P_NOME, P_EMAIL, P_TELEFONE, TRUE);
    END

    DELIMITER ;

    CALL CADASTRAR_CLIENTE('JULIANA ALVES', 'JULIANA@EMAIL.COM', '129920975754');
    CALL CADASTRAR_CLIENTE('RICARDINHO DUQUE', 'RICARDO@EMAIL.COM', '168789075754');
    CALL CADASTRAR_CLIENTE('PABLO JUNINHO', 'PABLO@EMAIL.COM', '129921225754');


-- 8. alterar_preco(...) impedindo valor <= 0

DELIMITER $$
CREATE PROCEDURE ATUALIZAR_PRECO_PRODUTO (
    IN P_ID_PRODUTO INT,
    IN P_NOVO_PRECO DECIMAL(12,3)
)
BEGIN
    IF P_NOVO_PRECO <= 0 THEN
        UPDATE PRODUTO
        SET PRECO = P_NOVO_PRECO
        WHERE ID_PRODUTO = P_ID_PRODUTO;

        SELECT 'PREÇO ATUALIZADO' AS MENSAGEM;
    ELSE
        SELECT 'PREÇO INVÁLIDO' AS MENSAGEM;
    END IF;
END $$

CALL ATUALIZAR_PRECO_PRODUTO(2,1);

SELECT * FROM PRODUTO;

-- 9. criar_pedido(IN p_id_cliente INT, OUT p_id_pedido INT)

DELIMITER $$

DROP PROCEDURE IF EXISTS REGISTAR_PEDIDO$$

CREATE PROCEDURE REGISTAR_PEDIDO (
    IN P_ID_CLIENTE INT,
    OUT P_ID_PEDIDO INT 
)
BEGIN
    START TRANSACTION;
    INSERT INTO PEDIDO (
        ID_CLIENTE,
        DATA_PEDIDO,
        STATUS_PEDIDO
    )

    VALUES(
        P_ID_CLIENTE, NOW(), 'ABERTO'
    );

    SET P_ID_PEDIDO = LAST_INSERT_ID();
    COMMIT;
END$$

DELIMITER ;

CALL REGISTAR_PEDIDO(3, @PEDIDO);
SELECT @PEDIDO AS ID_PEDIDO_CRIADO;

-- 10. devolver ID com LAST_INSERT_ID()
CALL REGISTAR_PEDIDO(3, @PEDIDO);
SELECT @PEDIDO AS ID_PEDIDO_CRIADO;
SELECT LAST_INSERT_ID() AS ID_DEVOLVIDO;

-- 11. adicionar_item_pedido(...) buscando o preço atual

delimiter $$

create procedure adicionar_item_pedido(
    in p_id_pedido int,
    in p_id_produto int,
    in p_quantidade int
)
begin
    declare v_preco decimal(10,2);
    if p_quantidade <= 0 THEN
        select 'QUANTIDADE INVALIDA' as mensagem;
    ELSE
        SELECT preco
        into v_preco
        from produto
        where id_produto = p_id_produto
            and ativo = true;
        
        insert into item_pedido(
            id_pedido, id_produto, quantidade, preco_unitario
        )
        values (
            p_id_pedido, p_id_produto, p_quantidade, v_preco
        );
        select 'ITEM ADICIONADO' as mensagem;
    end if;
end$$
DELIMITER;
call adicionar_item_pedido(1,1,1);
SELECT * from pedido;


-- 12. Faça uma chamada inválida e explique o resultado.


call adicionar_item_pedido(1,2,4);


-- R: PORQUE O ITEM QUE ADICIONEI NAO EXISTE NA MINHA TABELA;

-- 13. Use SHOW CREATE PROCEDURE.

show create PROCEDURE REGISTAR_PEDIDO;

-- 14. Remova uma procedure com DROP PROCEDURE IF EXISTS e recrie-a.

drop procedure if exists REGISTAR_PEDIDO;

-- DESAFIO FINAL:
-- Crie uma procedure de negócio com:
-- - pelo menos 2 parâmetros;
-- - variável local;
-- - IF;
-- - pelo menos uma alteração no banco.

DELIMITER $$
CREATE PROCEDURE adicionar_pontos_cliente(
    IN p_id_cliente INT,
    IN p_pontos INT
)
BEGIN
    DECLARE v_pontos INT;

    IF p_pontos > 0 THEN
        SET v_pontos = p_pontos;
        UPDATE cliente
        SET pontos_fidelidade = pontos_fidelidade + v_pontos
        WHERE id_cliente = p_id_cliente;
    ELSE
        SELECT 'PONTOS INVALIDOS' AS mensagem;
    END IF;
END $$
DELIMITER ;

CALL adicionar_pontos_cliente(2,3);

SELECT * from cliente;

