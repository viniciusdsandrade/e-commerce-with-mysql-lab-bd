DROP DATABASE IF EXISTS tb_tarefa_1;
CREATE DATABASE IF NOT EXISTS tb_tarefa_1;
USE tb_tarefa_1;

DROP TRIGGER IF EXISTS calcular_preco_venda_before_insert;

CREATE TABLE tb_produto
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    nome       VARCHAR(50)    NOT NULL,
    categoria  VARCHAR(30)    NOT NULL,
    preco      DECIMAL(10, 2) NOT NULL,
    estoque    INT UNSIGNED DEFAULT 0,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

CREATE TABLE tb_venda
(
    id          INT UNSIGNED AUTO_INCREMENT,
    produto_id  BIGINT UNSIGNED,
    data_venda  DATE         NOT NULL,
    quantidade  INT UNSIGNED NOT NULL,
    preco_venda DECIMAL(10, 2),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (produto_id) REFERENCES tb_produto (id)
);

DELIMITER //

CREATE TRIGGER calcular_preco_venda_before_insert
    BEFORE INSERT
    ON tb_venda
    FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;

    -- Obter a quantidade em estoque do produto
    SELECT estoque
    INTO estoque_atual
    FROM tb_produto
    WHERE id = NEW.produto_id;

    -- Verificar se há estoque suficiente
    IF estoque_atual >= NEW.quantidade THEN
        -- Calcular o PrecoVenda se houver estoque
        SET NEW.preco_venda = (SELECT preco FROM tb_produto WHERE id = NEW.produto_id) * NEW.quantidade;
    ELSE
        -- Lançar um erro caso não haja estoque suficiente, impedindo a inserção
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER atualizar_estoque_apos_insercao
    AFTER INSERT
    ON tb_venda
    FOR EACH ROW
BEGIN
    UPDATE tb_produto
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
END;
//

DELIMITER ;

INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Notebook', 'Eletrônicos', 2999.99, 10);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Mouse', 'Acessórios', 49.99, 150);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Teclado', 'Acessórios', 89.99, 75);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Monitor', 'Eletrônicos', 599.99, 20);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Cadeira Gamer', 'Mobiliário', 799.99, 5);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('HD Externo', 'Armazenamento', 349.99, 30);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Webcam', 'Eletrônicos', 129.99, 60);
INSERT INTO tb_produto (nome, categoria, preco, estoque) VALUES ('Fone de Ouvido', 'Acessórios', 89.99, 100);

INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (1, '2024-09-01', 2);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (2, '2024-09-02', 5);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (3, '2024-09-03', 3);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (4, '2024-09-04', 1);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (5, '2024-09-05', 1);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (6, '2024-09-06', 4);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (7, '2024-09-07', 2);
INSERT INTO tb_venda (produto_id, data_venda, quantidade) VALUES (8, '2024-09-08', 6);

SELECT * FROM tb_produto;
SELECT * FROM tb_venda;


/*
    1 - Liste todas as vendas, incluindo o nome do produto e o preço de venda
    2 - Liste todos os produtos ordenados por preço em ordem crescente.
    3 - Mostre todos os produtos da categoria 'Eletrônicos', ordenados por nome em ordem decrescente.
    4 - Encontre o preço mais baixo e o preço mais alto entre todos os produtos.
    5 - Mostre a média de preços dos produtos na categoria 'Acessórios'.
    6 - Liste o produto mais caro de cada categoria.
    7 - Mostrar o número total de produtos em estoque que têm um preço menor que 100.
    8 - Encontre o nome e o preço do produto com a menor quantidade em estoque e ordenar o resultado pelo preço.
*/

-- 1 - Liste todas as vendas, incluindo o nome do produto e o preço de venda
SELECT p.nome        AS 'Produto',
       v.preco_venda AS 'R$',
       v.data_venda  AS 'Data da Venda'
FROM tb_venda AS v
         JOIN tb_produto AS p ON v.produto_id = p.id
ORDER BY v.data_venda;

-- 2 - Liste todos os produtos ordenados por preço em ordem crescente.
SELECT p.nome  AS 'Produto',
       p.preco AS 'R$'
FROM tb_produto AS p
ORDER BY preco;

-- 3 - Mostre todos os produtos da categoria 'Eletrônicos', ordenados por nome em ordem decrescente.
SELECT p.nome  AS 'Produto da Categoria Eletrônicos',
       p.preco AS 'R$'
FROM tb_produto AS p
WHERE categoria = 'Eletrônicos'
ORDER BY nome DESC;

-- 4 - Encontre o nome e a categoria do produto mais barato e do mais caro.
SELECT categoria AS 'Categoria',
       nome      AS 'Produto',
       preco     AS 'R$'
FROM tb_produto AS p
WHERE preco = (SELECT MIN(preco)
               FROM tb_produto)
UNION
SELECT categoria AS 'Categoria',
       nome      AS "Produto",
       preco     AS 'R$'
FROM tb_produto
WHERE preco = (SELECT MAX(preco)
               FROM tb_produto);

-- 5 - Mostre a média de preços dos produtos na categoria 'Acessórios'.
SELECT ROUND(AVG(preco), 3) AS 'Média de Preço'
FROM tb_produto
WHERE categoria = 'Acessórios';

-- 6 - Liste o produto mais caro de cada categoria e ordenar por preço.
SELECT p.categoria AS "Categoria",
       p.nome      AS "Produto",
       p.preco     AS 'R$'
FROM tb_produto AS p
WHERE p.preco = (SELECT MAX(preco)
                 FROM tb_produto
                 WHERE categoria = p.categoria)
ORDER BY preco;

-- 7 - Mostrar o número total de produtos em estoque que têm um preço menor que 100.
SELECT COUNT(*) AS 'Total de Produtos'
FROM tb_produto
WHERE preco < 100;

-- 8 - Encontre o nome e o preço do produto com a menor quantidade em estoque e ordenar o resultado pelo preço.
SELECT nome    AS "Produto",
       preco   AS 'R$',
       estoque AS "Quantidade em Estoque"
FROM tb_produto
WHERE estoque = (SELECT MIN(estoque)
                 FROM tb_produto)
ORDER BY preco;
