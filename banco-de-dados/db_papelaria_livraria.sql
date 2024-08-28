DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

SHOW TABLES;

CREATE TABLE IF NOT EXISTS tb_transportadoras
(
    id                 BIGINT UNSIGNED AUTO_INCREMENT,
    nome               VARCHAR(100)   NOT NULL,
    preco_por_km       DECIMAL(10, 2) NULL,
    CNPJ               VARCHAR(20)    NOT NULL,
    inscricao_estadual VARCHAR(100)   NOT NULL,
    telefone           VARCHAR(20)    NOT NULL,
    email              VARCHAR(100)   NOT NULL,
    endereco           VARCHAR(100)   NULL,

    UNIQUE (CNPJ),
    UNIQUE (inscricao_estadual),
    UNIQUE (email),

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_usuarios
(
    id                   BIGINT UNSIGNED AUTO_INCREMENT,
    nome                 VARCHAR(100),
    CPF                  VARCHAR(20),
    telefone             VARCHAR(20),
    email                VARCHAR(100),
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100) NULL,

    UNIQUE (CPF),
    UNIQUE (email),

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_enderecos
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario   BIGINT UNSIGNED NOT NULL,
    rua          VARCHAR(100),
    numero       VARCHAR(8),
    complemento  VARCHAR(50)     NULL,
    bairro       VARCHAR(100),
    cidade       VARCHAR(100),
    estado       VARCHAR(100),
    CEP          VARCHAR(20),
    is_principal BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

CREATE TABLE IF NOT EXISTS tb_produtos
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(100)   NOT NULL,
    preco     DECIMAL(10, 2) NOT NULL,
    descricao TEXT           NULL, -- Pode ser NULL, pois o produto pode não ter descrição

    PRIMARY KEY (id)
);

-- Associação entre produto e estoque
CREATE TABLE IF NOT EXISTS tb_estoque_produto
(
    id                      BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto              BIGINT UNSIGNED NOT NULL,
    quantidade              INT UNSIGNED    NOT NULL,
    localizacao             VARCHAR(100)    NULL, -- Ex: "Prateleira A", "Depósito 1", etc.
    data_ultima_atualizacao DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
);

CREATE TABLE IF NOT EXISTS tb_categorias
(
    id   BIGINT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_produtos_categorias
(
    id_produto   BIGINT UNSIGNED NOT NULL,
    id_categoria BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias (id)
);

CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

CREATE TABLE IF NOT EXISTS tb_carrinho_produtos
(
    id_carrinho BIGINT UNSIGNED NOT NULL,
    id_produto  BIGINT UNSIGNED NOT NULL,
    quantidade  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
);

CREATE TABLE IF NOT EXISTS tb_compras
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario        BIGINT UNSIGNED NOT NULL,
    data_compra       DATETIME        NOT NULL,
    id_transportadora BIGINT UNSIGNED NOT NULL,
    id_endereco       BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id),
    FOREIGN KEY (id_transportadora) REFERENCES tb_transportadoras (id),
    FOREIGN KEY (id_endereco) REFERENCES tb_enderecos (id)
);

-- quero fazer uma tabela que será responsável por armazenar os avaliação de produtos específicos de uma compra
CREATE TABLE IF NOT EXISTS tb_compra_produto_avaliacao
(
    id_compra      BIGINT UNSIGNED NOT NULL,
    id_produto     BIGINT UNSIGNED NOT NULL,
    avaliacao      ENUM (
        '⭐',
        '⭐⭐',
        '⭐⭐⭐',
        '⭐⭐⭐⭐',
        '⭐⭐⭐⭐⭐') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,-- Avaliação com emojis de estrelas
    comentario     TEXT            NULL,
    data_avaliacao DATETIME        NOT NULL,

    PRIMARY KEY (id_compra, id_produto),

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tb_compras_produtos
(
    id_compra  BIGINT UNSIGNED NOT NULL,
    id_produto BIGINT UNSIGNED NOT NULL,
    quantidade BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
);

-- definição: uma promoção é um desconto aplicado a UM PRODUTO específico
CREATE TABLE IF NOT EXISTS tb_promocoes
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- A promoção pode estar em vários produtos, porém a promoção é aplicada individualmente a cada produto
CREATE TABLE IF NOT EXISTS tb_promocoes_produtos
(
    id_produto     BIGINT UNSIGNED NOT NULL,
    id_promocao    BIGINT UNSIGNED NOT NULL,
    data_aplicacao DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_produto, id_promocao),

    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocoes (id)
);

-- definição: um cupom é um desconto aplicado a uma COMPRA
CREATE TABLE IF NOT EXISTS tb_cupons
(
    id_cupom    BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id_cupom)
);

CREATE TABLE IF NOT EXISTS tb_cupon_compra
(
    id_compra BIGINT UNSIGNED NOT NULL,
    id_cupom  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupons (id_cupom)
);


-- Relatório de Vendas por Período
SELECT DATE_FORMAT(data_compra, '%Y-%m-%d') AS data_compra,
       COUNT(c.id)                          AS total_vendas,
       SUM(cp.quantidade)                   AS total_produtos_vendidos,
       SUM(p.preco * cp.quantidade)         AS total_receita,
       AVG(p.preco * cp.quantidade)         AS valor_medio_por_compra
FROM tb_compras AS c
         JOIN
     tb_compras_produtos AS cp ON c.id = cp.id_compra
         JOIN
     tb_produtos AS p ON cp.id_produto = p.id
WHERE data_compra BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY DATE_FORMAT(data_compra, '%Y-%m-%d')
ORDER BY data_compra DESC;


-- Relatório de Produtos Mais Vendidos
SELECT p.nome                       AS produto,
       SUM(cp.quantidade)           AS quantidade_vendida,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_compras_produtos AS cp
         JOIN
     tb_produtos AS p ON cp.id_produto = p.id
         JOIN
     tb_compras AS c ON cp.id_compra = c.id
WHERE c.data_compra BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY p.nome
ORDER BY quantidade_vendida DESC, total_receita DESC;

-- Clientes que realizaram somente uma compra
SELECT u.nome, u.email, MAX(c.data_compra) AS ultima_compra
FROM tb_usuarios u
         JOIN tb_compras c ON u.id = c.id_usuario
GROUP BY u.nome, u.email
HAVING COUNT(c.id) = 1;

-- Ticket médio por cliente
SELECT u.nome, AVG(p.preco * cp.quantidade) AS ticket_medio
FROM tb_usuarios u
         JOIN tb_compras c ON u.id = c.id_usuario
         JOIN tb_compras_produtos cp ON c.id = cp.id_compra
         JOIN tb_produtos p ON cp.id_produto = p.id
GROUP BY u.nome
ORDER BY ticket_medio DESC;

-- Relatório de Clientes menos Frequentes e que Mais Gastaram
SELECT u.nome                       AS cliente,
       COUNT(c.id)                  AS total_compras,
       SUM(p.preco * cp.quantidade) AS total_gasto
FROM tb_usuarios AS u
         JOIN
     tb_compras AS c ON u.id = c.id_usuario
         JOIN
     tb_compras_produtos AS cp ON c.id = cp.id_compra
         JOIN
     tb_produtos AS p ON cp.id_produto = p.id
GROUP BY u.nome
ORDER BY total_gasto DESC, total_compras;


-- Relatório de Categorias de Produtos Mais Vendidas
SELECT cat.nome                     AS categoria,
       SUM(cp.quantidade)           AS quantidade_vendida,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_produtos_categorias AS pc
         JOIN
     tb_categorias AS cat ON pc.id_categoria = cat.id
         JOIN
     tb_produtos AS p ON pc.id_produto = p.id
         JOIN
     tb_compras_produtos AS cp ON p.id = cp.id_produto
GROUP BY cat.nome
ORDER BY total_receita DESC;


-- Relatório de Vendas por Transportadora
SELECT t.nome                       AS transportadora,
       COUNT(c.id)                  AS total_pedidos,
       SUM(p.preco * cp.quantidade) AS total_receita
FROM tb_transportadoras AS t
         JOIN
     tb_compras AS c ON t.id = c.id_transportadora
         JOIN
     tb_compras_produtos AS cp ON c.id = cp.id_compra
         JOIN
     tb_produtos AS p ON cp.id_produto = p.id
GROUP BY t.nome
ORDER BY total_pedidos DESC, total_receita DESC;

--
SELECT p.nome                                                 AS produto,
       AVG(CAST(REPLACE(cpa.avaliacao, '⭐', '') AS UNSIGNED)) AS avaliacao_media
FROM tb_compra_produto_avaliacao cpa
         JOIN tb_produtos p ON cpa.id_produto = p.id
GROUP BY p.nome
ORDER BY avaliacao_media DESC;

--
SELECT p.nome   AS produto,
       COUNT(*) AS total_avaliacoes_negativas
FROM tb_compra_produto_avaliacao cpa
         JOIN tb_produtos p ON cpa.id_produto = p.id
WHERE cpa.avaliacao IN ('⭐', '⭐⭐')
GROUP BY p.nome
ORDER BY total_avaliacoes_negativas DESC;