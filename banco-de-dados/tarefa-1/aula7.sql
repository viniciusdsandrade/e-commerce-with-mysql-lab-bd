DROP DATABASE IF EXISTS tb_tarefa_1;
CREATE DATABASE IF NOT EXISTS tb_tarefa_1;
USE tb_tarefa_1;

DROP TRIGGER IF EXISTS calcular_preco_venda_before_insert;

CREATE TABLE tb_produtos
(
    ID                  BIGINT UNSIGNED AUTO_INCREMENT,
    Nome                VARCHAR(50)    NOT NULL,
    Categoria           VARCHAR(30)    NOT NULL,
    Preco               DECIMAL(10, 2) NOT NULL,
    QuantidadeEmEstoque INT UNSIGNED DEFAULT 0,

    PRIMARY KEY (ID)
);

CREATE TABLE tb_vendas
(
    ID         INT UNSIGNED AUTO_INCREMENT,
    ProdutoID  BIGINT UNSIGNED,
    DataVenda  DATE         NOT NULL,
    Quantidade INT UNSIGNED NOT NULL,
    PrecoVenda DECIMAL(10, 2),

    PRIMARY KEY (ID),

    FOREIGN KEY (ProdutoID) REFERENCES tb_produtos (ID)
);

DELIMITER //

CREATE TRIGGER calcular_preco_venda_before_insert
    BEFORE INSERT
    ON tb_vendas
    FOR EACH ROW
BEGIN
    SET NEW.PrecoVenda = (SELECT Preco FROM tb_produtos WHERE ID = NEW.ProdutoID) * NEW.Quantidade;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER atualizar_estoque_apos_insercao
AFTER INSERT ON tb_vendas
FOR EACH ROW
BEGIN
    UPDATE tb_produtos
    SET QuantidadeEmEstoque = QuantidadeEmEstoque - NEW.Quantidade
    WHERE ID = NEW.ProdutoID;
END; //

DELIMITER ;

INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Notebook', 'Eletrônicos', 2999.99, 10);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Mouse', 'Acessórios', 49.99, 150);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Teclado', 'Acessórios', 89.99, 75);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Monitor', 'Eletrônicos', 599.99, 20);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Cadeira Gamer', 'Mobiliário', 799.99, 5);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'HD Externo', 'Armazenamento', 349.99, 30);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ('Webcam', 'Eletrônicos', 129.99, 60);
INSERT INTO tb_produtos (Nome, Categoria, Preco, QuantidadeEmEstoque) VALUES ( 'Fone de Ouvido', 'Acessórios', 89.99, 100);

INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (1, '2024-09-01', 2);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (2, '2024-09-02', 5);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (3, '2024-09-03', 3);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (4, '2024-09-04', 1);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (5, '2024-09-05', 1);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (6, '2024-09-06', 4);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (7, '2024-09-07', 2);
INSERT INTO tb_vendas (ProdutoID, DataVenda, Quantidade) VALUES (8, '2024-09-08', 6);

SELECT * FROM tb_produtos;
SELECT * FROM tb_vendas;

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
SELECT v.ID,
       p.Nome AS 'Produto',
       v.PrecoVenda AS 'R$'
FROM tb_vendas AS v
         JOIN tb_produtos p ON v.ProdutoID = p.ID;

-- 2 - Liste todos os produtos ordenados por preço em ordem crescente.
SELECT p.Nome AS 'Produto',
       p.Preco AS 'R$'
FROM tb_produtos AS p
ORDER BY Preco;

-- 3 - Mostre todos os produtos da categoria 'Eletrônicos', ordenados por nome em ordem decrescente.
SELECT *
FROM tb_produtos
WHERE Categoria = 'Eletrônicos'
ORDER BY Nome DESC;

-- 4 - Encontre o preço mais baixo e o preço mais alto entre todos os produtos.
SELECT Nome AS 'Produto',
       Preco AS 'R$'
FROM tb_produtos AS p
WHERE Preco = (SELECT MIN(Preco)
               FROM tb_produtos)
UNION
SELECT Nome AS 'Produto',
       Preco AS 'R$'
FROM tb_produtos
WHERE Preco = (SELECT MAX(Preco)
               FROM tb_produtos);

-- 5 - Mostre a média de preços dos produtos na categoria 'Acessórios'.
SELECT AVG(Preco) AS 'Média de Preço'
FROM tb_produtos
WHERE Categoria = 'Acessórios';

-- 6 - Liste o produto mais caro de cada categoria.
SELECT p.Categoria AS Categoria,
       p.Nome AS Produto,
       p.Preco AS 'R$'
FROM tb_produtos p
WHERE p.Preco = (SELECT MAX(Preco)
                 FROM tb_produtos
                 WHERE Categoria = p.Categoria);

-- 7 - Mostrar o número total de produtos em estoque que têm um preço menor que 100.
SELECT COUNT(*) AS 'Total de Produtos'
FROM tb_produtos
WHERE Preco < 100;

-- 8 - Encontre o nome e o preço do produto com a menor quantidade em estoque e ordenar o resultado pelo preço.
SELECT Nome AS Produto,
       Preco AS 'R$'
FROM tb_produtos
WHERE QuantidadeEmEstoque = (SELECT MIN(QuantidadeEmEstoque)
                             FROM tb_produtos)
ORDER BY Preco;
