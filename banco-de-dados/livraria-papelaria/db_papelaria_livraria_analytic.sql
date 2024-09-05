USE db_papelaria_livraria;

-- 1. Produtos mais vendidos:
SELECT p.nome             AS NomeProduto,
       SUM(cp.quantidade) AS QuantidadeVendida
FROM tb_compra_produto cp
         JOIN tb_produto p ON cp.id_produto = p.id
GROUP BY p.nome
ORDER BY QuantidadeVendida DESC
LIMIT 10;

-- 2. Valor total de vendas por mês:
SELECT DATE_FORMAT(c.data_realizada, '%Y-%m') AS Mes,
       SUM(cfp.valor_pago)                    AS ValorTotalVendas
FROM tb_compra c
         JOIN tb_compra_forma_pgto cfp ON c.id = cfp.id_compra
GROUP BY Mes
ORDER BY Mes;

-- 3. Média de avaliação dos produtos:
SELECT p.nome                 AS NomeProduto,
       AVG(CASE
               WHEN a.avaliacao = '⭐' THEN 1
               WHEN a.avaliacao = '⭐⭐' THEN 2
               WHEN a.avaliacao = '⭐⭐⭐' THEN 3
               WHEN a.avaliacao = '⭐⭐⭐⭐' THEN 4
               WHEN a.avaliacao = '⭐⭐⭐⭐⭐' THEN 5
               ELSE NULL END) AS MediaAvaliacao
FROM tb_produto p
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         LEFT JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
GROUP BY p.nome
ORDER BY MediaAvaliacao DESC;


-- 4. Categoria de produto mais vendida:
SELECT cat.nome           AS NomeCategoria,
       SUM(cp.quantidade) AS QuantidadeVendida
FROM tb_compra_produto cp
         JOIN tb_produto p ON cp.id_produto = p.id
         JOIN tb_produto_categoria pc ON p.id = pc.id_produto
         JOIN tb_categoria cat ON pc.id_categoria = cat.id
GROUP BY cat.nome
ORDER BY QuantidadeVendida DESC;


-- 5. Valor total gasto por forma de pagamento:
SELECT u.nome      AS NomeUsuario,
       COUNT(c.id) AS NumeroCompras
FROM tb_compra c
         JOIN tb_usuario u ON c.id_usuario = u.id
GROUP BY u.nome
ORDER BY NumeroCompras DESC
LIMIT 10;


-- 6. Taxa de conversão de carrinho para compra:
SELECT (COUNT(DISTINCT c.id) / COUNT(DISTINCT car.id)) * 100 AS TaxaConversao
FROM tb_carrinho car
         LEFT JOIN tb_compra c ON car.id_usuario = c.id_usuario
    AND c.data_realizada >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
-- Considerando compras nos últimos 30 dias


-- 7. Cupons mais utilizados:
SELECT cupom.nome AS NomeCupom,
       COUNT(*)   AS QuantidadeUtilizada
FROM tb_cupom cupom
         JOIN tb_cupom_compra cc ON cupom.id = cc.id_cupom
GROUP BY cupom.nome
ORDER BY QuantidadeUtilizada DESC
LIMIT 10;


-- 8. Produtos com mais avaliações positivas:
SELECT p.nome      AS NomeProduto,
       COUNT(a.id) AS NumeroAvaliacoesPositivas
FROM tb_produto p
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
WHERE a.avaliacao IN ('⭐⭐⭐⭐', '⭐⭐⭐⭐⭐')
GROUP BY p.nome
ORDER BY NumeroAvaliacoesPositivas DESC
LIMIT 10;

-- 9. Usuários que desejam produtos que nunca compraram:
SELECT u.nome                         AS NomeUsuario,
       COUNT(DISTINCT ldp.id_produto) AS ProdutosDesejados,
       COUNT(DISTINCT cp.id_produto)  AS ProdutosComprados
FROM tb_usuario u
         JOIN tb_lista_desejos ld ON u.id = ld.id_usuario
         JOIN tb_lista_desejos_produto ldp ON ld.id = ldp.id_lista_desejos
         LEFT JOIN tb_compra_produto cp ON u.id = cp.id_compra AND ldp.id_produto = cp.id_produto
GROUP BY u.nome
HAVING ProdutosDesejados > 0
   AND ProdutosComprados = 0
ORDER BY ProdutosDesejados DESC
LIMIT 10;

-- 18. Avaliação média dos produtos por categoria:
SELECT c.nome                 AS NomeCategoria,
       AVG(CASE
               WHEN a.avaliacao = '⭐' THEN 1
               WHEN a.avaliacao = '⭐⭐' THEN 2
               WHEN a.avaliacao = '⭐⭐⭐' THEN 3
               WHEN a.avaliacao = '⭐⭐⭐⭐' THEN 4
               WHEN a.avaliacao = '⭐⭐⭐⭐⭐' THEN 5
               ELSE NULL END) AS MediaAvaliacao
FROM tb_categoria c
         JOIN tb_produto_categoria pc ON c.id = pc.id_categoria
         JOIN tb_produto p ON pc.id_produto = p.id
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         LEFT JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
GROUP BY c.nome
ORDER BY MediaAvaliacao DESC;

-- 11. Valor total gasto por usuário:
SELECT u.nome                       AS nome_usuario,
       u.telefone                   AS telefone_usuario,
       u.email                      AS email_usuario,
       e.estado                     AS estado_usuario,
       DATE(c.data_realizada)       AS dia_da_compra,
       SUM(p.preco * cp.quantidade) AS valor_total_gasto
FROM tb_compra c
         JOIN
     tb_compra_produto cp ON c.id = cp.id_compra
         JOIN
     tb_produto p ON cp.id_produto = p.id
         JOIN
     tb_usuario u ON c.id_usuario = u.id
         JOIN
     tb_endereco e ON c.id_endereco = e.id
GROUP BY u.nome, u.telefone, u.email, e.estado, DATE(c.data_realizada)
ORDER BY dia_da_compra, nome_usuario;

-- 12. Valor e quantidade de produtos em estoque:
SELECT p.nome                   AS nome_produto,
       p.preco                  AS preco_produto,
       e.quantidade             AS quantidade_estoque,
       (e.quantidade * p.preco) AS valor_total_produto
FROM tb_produto p
         JOIN
     tb_estoque e ON p.id = e.id_produto;