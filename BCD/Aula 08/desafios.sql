-- ============================================================
-- AULA 08 - ATIVIDADE PRÁTICA DE DML
-- Nome: Isabella Alves do Carmo Cleto
-- Turma: DEVIS 1/26 Data: 02/10/2026
-- Base: smartcoffee_dml
-- ============================================================
USE SMARTCOFFEE_DML_ISABELLA1;
-- IMPORTANTE:
-- Para toda questão de UPDATE ou DELETE, escreva primeiro um SELECT
-- com o mesmo WHERE para validar os registros afetados.

-- PARTE A - INSERT

-- 1. Cadastre dois novos clientes com dados diferentes.

INSERT INTO cliente(nome,email,telefone,cidade,ativo) VALUES
('Joana Pessoa','joana@gmail.com',99999999999998,'Limeira',TRUE),
('Gustavo Lima','gustavo@gmail.com',909088358332,'Limeira',TRUE);


-- 2. Cadastre a categoria 'Especiais da Casa'.

INSERT INTO categoria (nome) VALUES
('Especial da casa');


-- 3. Localize o id da categoria criada e cadastre três produtos nela.

SET @categoria_especial = (SELECT id_categoria FROM categoria WHERE nome = 'Especiais da Casa');


INSERT INTO categoria (id_categoria, nome) VALUES 
(14, 'Lanches'),
(15, 'Bolos e Doces'),
(16, 'Sobremesas Especial');

SELECT* from categoria;
INSERT INTO categoria(nome,id_categoria)  VALUES
('Sorvete',17);

-- 4. Cadastre um terceiro cliente sem telefone.

INSERT INTO cliente(nome, email, telefone,cidade,ativo) VALUES
('Jodmilson Silva','jodmilsonsilva3@gmail.com',NULL,'Americana',TRUE);

SELECT* from cliente;


-- 5. Crie um novo pedido para um dos clientes cadastrados.

INSERT INTO pedido (data_pedido,status_pedido, valor_total,id_cliente) VALUES
(NOW(),'ABERTO',12.00,1);

SET @pedido_compra = LAST_INSERT_ID();

SELECT * from pedido

-- 6. Use LAST_INSERT_ID() para guardar o id do pedido em @pedido_atividade
--    e insira pelo menos dois itens nesse pedido.

INSERT INTO pedido (data_pedido,status_pedido, valor_total,id_cliente) VALUES
(NOW(),'ABERTO',20.00,2),
(NOW(),'FINALIZADO',23.00,3);

SET @pedido_atividade = LAST_INSERT_ID();


-- PARTE B - UPDATE

-- 7. Corrija o telefone de um dos clientes criados.
-- SELECT de validação:
-- UPDATE:
-- SELECT final:

UPDATE Cliente
SET telefone = '1988880001'
WHERE id_cliente = 1

SELECT * FROM cliente


-- 8. Altere cidade e telefone de outro cliente em um único UPDATE.

UPDATE Cliente
SET telefone = '19932098457',
CIDADE='Piracicaba'
WHERE id_cliente = 3;

-- 9. Aumente em 8% o preço dos produtos da categoria 'Especiais da Casa'.

UPDATE preco
SET preco = preco * 0.08,
WHERE id_categoria = 12;

-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
-- do maior para o menor valor.

SELECT id_pedido, valor_total
FROM pedido
WHERE status_pedido = 'Finalizado' and valor_total >= 20.00
ORDER BY valor_total DESC;

-- PARTE C - CÁLCULOS E AGRUPAMENTOS
-- 11. Informe quantos produtos estão cadastrados.
SELECT COUNT() AS total_produto
FROM produto;

-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT ROUND(MIN(preco),2) AS Preços_Baixos,
ROUND(MAX(preco),2) AS Preco_Alto,
ROUND(AVG(preco),2) AS Média_preco
FROM produto;

-- 13. Informe quantos clientes existem em cada cidade.
SELECT cidade, COUNT() AS QTDE_CLIENTES
FROM cliente
GROUP BY cidade;

-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
SELECT cidade, COUNT() AS QTDE_CLIENTES
FROM cliente
GROUP BY cidade
HAVING COUNT() >=2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
SELECT SUM(valor_total) AS FATURAMENTO
FROM pedido
WHERE status_pedido = 'Finalizado'


-- PARTE D - RELACIONAMENTOS

-- 16. Liste cada pedido exibindo id, data, nome do cliente, status e valor total.

SELECT P. ID_PEDIDO, P.DATA_PEDIDO, C.NOME AS CLIENTE, P.VALOR_TOTAL, P.STATUS_PEDIDO
FROM PEDIDO AS P
INNER JOIN CLIENTE AS C
ON C.ID_CLIENTE = P.ID_CLIENTE


-- 17. Liste cada produto acompanhado do nome de sua categoria.

SELECT PR.NOME AS PRODUTO, CA.NOME AS CATEGORIA
FROM PRODUTO AS PR 
INNER JOIN CATEGORIA AS CA
ON CA.ID_CATEGORIA = PR.ID_CATEGORIA
ORDER BY CA.NOME, PR.NOME;



-- 18. Gere um relatório dos itens vendidos: pedido, produto, quantidade,
--     preço unitário e subtotal.


SELECT C.NOME AS CLIENTE, COUNT(P.ID_PEDIDO) AS QTDE_PEDIDOS, SUM(P.VALOR_TOTAL) AS VALOR_COMPRADO
FROM CLIENTE AS C
INNER JOIN PEDIDO AS P
ON P.ID_CLIENTE = C.ID_CLIENTE
WHERE P.STATUS_PEDIDO = 'ABERTO'
GROUP BY C.ID_CLIENTE, C.NOME
ORDER BY VALOR_COMPRADO DESC;


-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.

SELECT c.*
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente;


-- 20. Liste apenas os clientes que nunca fizeram pedidos.

SELECT c.*
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;



-- PARTE E - DESAFIO GERENCIAL

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto
--     cada cliente gastou. Ordene do maior gasto para o menor.


SELECT
    c.nome AS Nome_Cliente,
    COUNT(p.id_pedido) AS Quantidade_Pedidos,
    SUM(p.valor_total) AS Total_Gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY c.id_cliente, c.nome
ORDER BY Total_Gasto DESC;


-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.

SELECT
    c.nome AS Categoria,
    COUNT(p.id_produto) AS Quantidade_Produtos,
    AVG(p.preco) AS Preco_Medio
FROM categoria c
JOIN produto p ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nome;


-- 23. Descubra quais produtos possuem preço superior ao preço médio geral.

SELECT nome, preco
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto);



-- 24. Classifique os produtos como Econômico, Intermediário ou Premium.
--     Defina e informe suas faixas de preço.

SELECT
    nome,
    preco,
    CASE
        WHEN preco <= 10.00 THEN 'Economico'
        WHEN preco <= 25.00 THEN 'Intermediario'
        ELSE 'Premium'
    END AS Classificacao
FROM produto;

-- 25. CONSULTA AUTORAL
-- Pergunta de negócio:

-- Por que essa informação é útil?

-- Foi útil porque permite organizar os produtos por categoria, facilitando a consulta dos preços e a organização do cardápio da cafeteria.
--
-- Consulta:
SELECT
    p.nome AS Produto,
    p.preco AS Preco,
    c.nome AS Categoria
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
ORDER BY c.nome, p.nome;