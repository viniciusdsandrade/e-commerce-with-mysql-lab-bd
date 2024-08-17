USE db_e_commerce_with_my_sql;

/*
 O relacionamento muitos para muitos é utilizado quando uma entidade pode estar associada a várias instâncias de outra entidade e vice-versa.
    No exemplo abaixo, temos as tabelas tb_produto e tb_categoria, onde um produto pode estar associado a várias categorias e uma categoria pode estar associada a vários produtos.
    Para representar esse relacionamento, criamos uma tabela intermediária chamada tb_produto_categoria, que contém as chaves estrangeiras id_produto e id_categoria, que se referem às tabelas tb_produto e tb_categoria, respectivamente.
    Dessa forma, podemos associar um produto a várias categorias e uma categoria a vários produtos.
 */

INSERT INTO tb_categoria (nome, descricao) VALUES ('Eletrônicos', 'Produtos eletrônicos em geral');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Livros', 'Livros de diversos gêneros');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Roupas', 'Roupas de diversos tipos');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Alimentos', 'Alimentos de diversos tipos');
INSERT INTO tb_categoria (nome, descricao) VALUES ('Móveis', 'Móveis de diversos tipos');

DROP TRIGGER IF EXISTS insere_;

-- Trigger para inserir automaticamente um registro na tabela tb_produto_categoria
-- após a inserção de um novo produto na tabela tb_produto.
-- O registro inserido na tabela tb_produto_categoria contém o ID do produto recém-inserido
-- e o ID da categoria associada ao produto.
DELIMITER //

CREATE TRIGGER insere_produto_categoria
    AFTER INSERT
    ON tb_produto
    FOR EACH ROW
BEGIN
    INSERT INTO tb_produto_categoria (id_produto, id_categoria)
    VALUES (NEW.id, NEW.id_categoria);
END; //
DELIMITER ;

INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Smartphone', 'Smartphone de última geração', 1999.99, 100, 1);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Notebook', 'Notebook de última geração', 2999.99, 50, 1);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Tablet', 'Tablet de última geração', 999.99, 150, 1);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Kindle', 'Leitor digital de livros', 299.99, 200, 1);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Livro', 'Livro de romance', 29.99, 500, 2);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Camiseta', 'Camiseta branca', 19.99, 1000, 3);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Calça', 'Calça jeans', 49.99, 500, 3);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Arroz', 'Arroz integral', 9.99, 1000, 4);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Feijão', 'Feijão carioca', 7.99, 1000, 4);
INSERT INTO tb_produto (nome, descricao, preco, estoque, id_categoria) VALUES ('Sofá', 'Sofá de 3 lugares', 999.99, 50, 5);

SELECT * FROM tb_categoria;
SELECT * FROM tb_produto;
SELECT * FROM tb_produto_categoria;

# Caso queira associar um produto a mais de uma categoria, basta inserir um novo registro na tabela tb_produto_categoria com o ID do produto e o ID da categoria desejada.
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (3, 2);


SELECT p.nome AS produto, c.nome AS categoria
FROM tb_produto p
         JOIN tb_produto_categoria pc ON p.id = pc.id_produto
         JOIN tb_categoria c ON pc.id_categoria = c.id;
