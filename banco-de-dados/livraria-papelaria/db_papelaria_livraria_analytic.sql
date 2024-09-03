USE db_papelaria_livraria;

-- Relatório de Vendas por Período
SELECT DATE_FORMAT(data_compra, '%Y-%m-%d') AS data_compra,
       COUNT(c.id)                          AS total_vendas,
       SUM(cp.quantidade)                   AS total_produtos_vendidos,
       SUM(p.preco * cp.quantidade)         AS total_receita,
       AVG(p.preco * cp.quantidade)         AS valor_medio_por_compra
FROM tb_compra AS c
         JOIN
     tb_compra_produto AS cp ON c.id = cp.id_compra
         JOIN
     tb_produto AS p ON cp.id_produto = p.id
WHERE data_compra BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY DATE_FORMAT(data_compra, '%Y-%m-%d')
ORDER BY data_compra DESC;

-- Relatório de Produtos Mais Vendidos
SELECT p.nome                       AS produto,
       SUM(cp.quantidade)           AS quantidade_vendida,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_compra_produto AS cp
         JOIN
     tb_produto AS p ON cp.id_produto = p.id
         JOIN
     tb_compra AS c ON cp.id_compra = c.id
WHERE c.data_compra BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY p.nome
ORDER BY quantidade_vendida DESC, total_receita DESC;

-- Clientes que realizaram somente uma compra
SELECT u.nome, u.email, MAX(c.data_compra) AS ultima_compra
FROM tb_usuario u
         JOIN tb_compra c ON u.id = c.id_usuario
GROUP BY u.nome, u.email
HAVING COUNT(c.id) = 1;

-- Ticket médio por cliente
SELECT u.nome, AVG(p.preco * cp.quantidade) AS ticket_medio
FROM tb_usuario u
         JOIN tb_compra c ON u.id = c.id_usuario
         JOIN tb_compra_produto cp ON c.id = cp.id_compra
         JOIN tb_produto p ON cp.id_produto = p.id
GROUP BY u.nome
ORDER BY ticket_medio DESC;

-- Relatório de Clientes menos Frequentes e que Mais Gastaram
SELECT u.nome                       AS cliente,
       COUNT(c.id)                  AS total_compras,
       SUM(p.preco * cp.quantidade) AS total_gasto
FROM tb_usuario AS u
         JOIN
     tb_compra AS c ON u.id = c.id_usuario
         JOIN
     tb_compra_produto AS cp ON c.id = cp.id_compra
         JOIN
     tb_produto AS p ON cp.id_produto = p.id
GROUP BY u.nome
ORDER BY total_gasto DESC, total_compras;


-- Relatório de Categorias de Produtos Mais Vendidas
SELECT cat.nome                     AS categoria,
       SUM(cp.quantidade)           AS quantidade_vendida,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_produto_categorias AS pc
         JOIN
     tb_categoria AS cat ON pc.id_categoria = cat.id
         JOIN
     tb_produto AS p ON pc.id_produto = p.id
         JOIN
     tb_compra_produto AS cp ON p.id = cp.id_produto
GROUP BY cat.nome
ORDER BY total_receita DESC;

-- Relatório de Vendas por Transportadora
SELECT t.nome                       AS transportadora,
       COUNT(c.id)                  AS total_pedidos,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_transportadora AS t
         JOIN
     tb_compra AS c ON t.id = c.id_transportadora
         JOIN
     tb_compra_produto AS cp ON c.id = cp.id_compra
         JOIN
     tb_produto AS p ON cp.id_produto = p.id
GROUP BY t.nome
ORDER BY total_pedidos DESC, total_receita DESC;

-- Relatório de Avaliação Média dos Produtos
SELECT p.nome                                                 AS produto,
       AVG(CAST(REPLACE(cpa.avaliacao, '⭐', '') AS UNSIGNED)) AS avaliacao_media
FROM tb_compra_produto_avaliacao cpa
         JOIN tb_produto p ON cpa.id_produto = p.id
GROUP BY p.nome
ORDER BY avaliacao_media DESC;

-- Relatório de Avaliações Negativas dos Produtos
SELECT p.nome   AS produto,
       COUNT(*) AS total_avaliacoes_negativas
FROM tb_compra_produto_avaliacao cpa
         JOIN tb_produto p ON cpa.id_produto = p.id
WHERE cpa.avaliacao IN ('⭐', '⭐⭐')
GROUP BY p.nome
ORDER BY total_avaliacoes_negativas DESC;
