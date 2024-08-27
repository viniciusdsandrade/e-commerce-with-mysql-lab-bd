DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

CREATE TABLE IF NOT EXISTS tb_enderecos
(
    id_endereco BIGINT UNSIGNED AUTO_INCREMENT,
    endereco    VARCHAR(100),
    numero      VARCHAR(10),
    complemento VARCHAR(100) NULL,
    bairro      VARCHAR(100),
    cidade      VARCHAR(100),
    estado      VARCHAR(100),
    CEP         VARCHAR(20),

    PRIMARY KEY (id_endereco)
);

CREATE TABLE IF NOT EXISTS tb_usuarios
(
    id_usuario           BIGINT UNSIGNED AUTO_INCREMENT,
    nome                 VARCHAR(100),
    CPF                  VARCHAR(20),
    telefone             VARCHAR(20),
    email                VARCHAR(100),
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100)    NULL,
    id_endereco          BIGINT UNSIGNED NULL, -- Pode ser NULL, pois o usuário pode não ter um endereço cadastrado

    UNIQUE (CPF),
    UNIQUE (email),

    PRIMARY KEY (id_usuario),

    FOREIGN KEY (id_endereco) REFERENCES tb_enderecos (id_endereco)
);

CREATE TABLE IF NOT EXISTS tb_produtos
(
    id_produto BIGINT UNSIGNED AUTO_INCREMENT,
    nome       VARCHAR(100)   NOT NULL,
    preco      DECIMAL(10, 2) NOT NULL,
    descricao  TEXT           NULL, -- Pode ser NULL, pois o produto pode não ter descrição

    PRIMARY KEY (id_produto)
);

CREATE TABLE IF NOT EXISTS tb_categorias
(
    id_categoria BIGINT UNSIGNED AUTO_INCREMENT,
    nome         VARCHAR(100) NOT NULL,

    PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS tb_produtos_categorias
(
    id_produto   BIGINT UNSIGNED NOT NULL,
    id_categoria BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto),
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias (id_categoria)
);

CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id_carrinho BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario  BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_carrinho),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id_usuario)
);

CREATE TABLE IF NOT EXISTS tb_carrinho_produtos
(
    id_carrinho BIGINT UNSIGNED NOT NULL,
    id_produto  BIGINT UNSIGNED NOT NULL,
    quantidade  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id_carrinho),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto)
);

CREATE TABLE IF NOT EXISTS tb_compras
(
    id_compra         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario        BIGINT UNSIGNED NOT NULL,
    data_compra       DATETIME        NOT NULL,
    id_transportadora BIGINT UNSIGNED NULL, -- Pode ser NULL, pois a compra pode não ter uma transportadora

    PRIMARY KEY (id_compra),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id_usuario)
);

CREATE TABLE IF NOT EXISTS tb_promocoes
(
    id_promocao BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id_promocao)
);

CREATE TABLE IF NOT EXISTS tb_compras_promocoes
(
    id_compra   BIGINT UNSIGNED NOT NULL,
    id_promocao BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocoes (id_promocao)
);


CREATE TABLE IF NOT EXISTS tb_cupons
(
    id_cupom    BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id_cupom)
);

CREATE TABLE IF NOT EXISTS tb_compras_cupons
(
    id_compra BIGINT UNSIGNED NOT NULL,
    id_cupom  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupons (id_cupom)
);

CREATE TABLE IF NOT EXISTS tb_compras_produtos
(
    id_compra  BIGINT UNSIGNED NOT NULL,
    id_produto BIGINT UNSIGNED NOT NULL,
    quantidade BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto)
);

CREATE TABLE IF NOT EXISTS tb_transportadoras
(
    id_transportadora  BIGINT UNSIGNED AUTO_INCREMENT,
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

    PRIMARY KEY (id_transportadora)
);
