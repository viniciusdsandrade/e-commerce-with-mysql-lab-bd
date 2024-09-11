USE db_papelaria_livraria;

-- 1. Nome do produto e quantidade vendida (últimos 30 dias):
SELECT p.nome             AS NomeProduto,
       SUM(cp.quantidade) AS QuantidadeVendida
FROM tb_compra_produto cp
         JOIN tb_produto p ON cp.id_produto = p.id
GROUP BY p.nome
ORDER BY QuantidadeVendida DESC
LIMIT 10;

-- 2. Média de avaliação dos produtos comprados (de 1 a 5 estrelas):
SELECT p.nome   AS NomeProduto,
       AVG(CASE
               WHEN a.avaliacao = '⭐' THEN 1
               WHEN a.avaliacao = '⭐⭐' THEN 2
               WHEN a.avaliacao = '⭐⭐⭐' THEN 3
               WHEN a.avaliacao = '⭐⭐⭐⭐' THEN 4
               WHEN a.avaliacao = '⭐⭐⭐⭐⭐' THEN 5
           END) AS MediaAvaliacao
FROM tb_produto p
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         LEFT JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
GROUP BY p.nome
ORDER BY MediaAvaliacao DESC;


-- 3. Nome da categoria e quantidade de produtos vendidos:
SELECT cat.nome           AS NomeCategoria,
       SUM(cp.quantidade) AS QuantidadeVendida
FROM tb_compra_produto cp
         JOIN tb_produto p ON cp.id_produto = p.id
         JOIN tb_produto_categoria pc ON p.id = pc.id_produto
         JOIN tb_categoria cat ON pc.id_categoria = cat.id
GROUP BY cat.nome
ORDER BY QuantidadeVendida DESC;


-- 4. Quantidade de compras por usuário:
SELECT u.nome      AS NomeUsuario,
       COUNT(c.id) AS NumeroCompras
FROM tb_compra c
         JOIN tb_usuario u ON c.id_usuario = u.id
GROUP BY u.nome
ORDER BY NumeroCompras DESC
LIMIT 10;


-- 5. Taxa de conversão de carrinho para compra (últimos 30 dias):
SELECT (COUNT(DISTINCT c.id) / COUNT(DISTINCT car.id)) * 100 AS TaxaConversao
FROM tb_carrinho car
         LEFT JOIN tb_compra c ON car.id_usuario = c.id_usuario
    AND c.data_realizada >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);


-- 6. Nome do cupom e quantidade de vezes utilizado:
SELECT cupom.nome AS NomeCupom,
       COUNT(*)   AS QuantidadeUtilizada
FROM tb_cupom cupom
         JOIN tb_cupom_compra cc ON cupom.id = cc.id_cupom
GROUP BY cupom.nome
ORDER BY QuantidadeUtilizada DESC
LIMIT 10;


-- 7. Produto e número de avaliações positivas (⭐⭐⭐⭐ ou ⭐⭐⭐⭐⭐):
SELECT p.nome      AS NomeProduto,
       COUNT(a.id) AS NumeroAvaliacoesPositivas
FROM tb_produto p
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
WHERE a.avaliacao IN ('⭐⭐⭐⭐', '⭐⭐⭐⭐⭐')
GROUP BY p.nome
ORDER BY NumeroAvaliacoesPositivas DESC
LIMIT 10;

-- 8. Nome, Produtos desejados e Produtos comprados de usuários que não compraram nada:
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

-- 9. Avaliação média dos produtos por categoria:
SELECT c.nome   AS NomeCategoria,
       AVG(CASE
               WHEN a.avaliacao = '⭐' THEN 1
               WHEN a.avaliacao = '⭐⭐' THEN 2
               WHEN a.avaliacao = '⭐⭐⭐' THEN 3
               WHEN a.avaliacao = '⭐⭐⭐⭐' THEN 4
               WHEN a.avaliacao = '⭐⭐⭐⭐⭐' THEN 5
           END) AS MediaAvaliacao
FROM tb_categoria c
         JOIN tb_produto_categoria pc ON c.id = pc.id_categoria
         JOIN tb_produto p ON pc.id_produto = p.id
         JOIN tb_compra_produto cp ON p.id = cp.id_produto
         LEFT JOIN tb_avaliacao a ON cp.id = a.id_compra_produto
GROUP BY c.nome
ORDER BY MediaAvaliacao DESC;

-- 10. Nome, telefone, e-mail, estado, dia da compra e valor total gasto de cada usuário:
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

-- 11. Nome, preço, quantidade e valor total de cada produto em estoque:
SELECT p.nome                   AS nome_produto,
       p.preco                  AS preco_produto,
       e.quantidade             AS quantidade_estoque,
       (e.quantidade * p.preco) AS valor_total_produto
FROM tb_produto p
         JOIN
     tb_estoque e ON p.id = e.id_produto;