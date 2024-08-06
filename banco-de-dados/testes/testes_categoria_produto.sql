USE db_e_commerce_with_my_sql;

INSERT INTO tb_categoria (nome, descricao) VALUES ('Eletrônicos', 'Produtos eletrônicos em geral');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Livros', 'Livros de diversos gêneros');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Roupas', 'Roupas de diversos tipos');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Alimentos', 'Alimentos de diversos tipos');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Móveis', 'Móveis de diversos tipos');

INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Smartphone', 'Smartphone de última geração', 1999.99, 100);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Notebook', 'Notebook de última geração', 2999.99, 50);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Tablet', 'Tablet de última geração', 999.99, 150);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Kindle', 'Leitor digital de livros', 299.99, 200);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Livro', 'Livro de romance', 29.99, 500);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Camiseta', 'Camiseta branca', 19.99, 1000);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Calça', 'Calça jeans', 49.99, 500);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Arroz', 'Arroz integral', 9.99, 1000);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Feijão', 'Feijão carioca', 7.99, 1000);
INSERT INTO tb_produto (nome, descricao, preco, estoque) VALUES ('Sofá', 'Sofá de 3 lugares', 999.99, 50);

INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (1, 1); # Smartphone, Eletrônicos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (2, 1); # Notebook, Eletrônicos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (3, 1); # Tablet, Eletrônicos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (4, 1); # Kindle, Eletrônicos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (5, 2); # Livro, Livros
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (6, 3); # Camiseta, Roupas
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (7, 3); # Calça, Roupas
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (8, 4); # Arroz, Alimentos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (9, 4); # Feijão, Alimentos
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (10, 5); # Sofá, Móveis

SELECT * FROM tb_categoria;
SELECT * FROM tb_produto;
SELECT * FROM tb_produto_categoria;

# Consulta que associar o nome do produto e o nome da categoria
SELECT
    p.id AS produto_id,
    p.nome AS produto_nome,
    c.id AS categoria_id,
    c.nome AS categoria_nome
FROM
    tb_produto p
JOIN
    tb_produto_categoria pc ON p.id = pc.id_produto
JOIN
    tb_categoria c ON c.id = pc.id_categoria
ORDER BY
    p.nome;

# Consulta que calcula a quantidade de produtos em estoque por categoria
SELECT
    c.nome AS categoria_nome,
    SUM(p.estoque) AS total_estoque
FROM
    tb_categoria c
JOIN
    tb_produto_categoria pc ON c.id = pc.id_categoria
JOIN
    tb_produto p ON p.id = pc.id_produto
GROUP BY
    c.id
ORDER BY
    total_estoque DESC;


# Consulta para contar o número de produtos em cada categoria:
SELECT
    c.nome AS categoria_nome,
    COUNT(pc.id_produto) AS total_produtos
FROM
    tb_categoria c
LEFT JOIN
    tb_produto_categoria pc ON c.id = pc.id_categoria
GROUP BY
    c.id
ORDER BY
    total_produtos ASC;

# Consulta para calcular a média de preço dos produtos por categoria:
SELECT
    c.nome AS categoria_nome,
    ROUND(AVG(p.preco), 2) AS media_preco
FROM
    tb_categoria c
JOIN
    tb_produto_categoria pc ON c.id = pc.id_categoria
JOIN
    tb_produto p ON p.id = pc.id_produto
GROUP BY
    c.id
ORDER BY
    media_preco DESC;



# Consulta para listar as categorias que não possuem produtos associados:
SELECT
    c.id AS categoria_id,
    c.nome AS categoria_nome
FROM
    tb_categoria c
LEFT JOIN
    tb_produto_categoria pc ON c.id = pc.id_categoria
WHERE
    pc.id_categoria IS NULL;