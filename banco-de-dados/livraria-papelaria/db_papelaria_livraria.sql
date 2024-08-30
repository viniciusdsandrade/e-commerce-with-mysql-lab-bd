DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

-- Tabela para armazenar as Transportadoras
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

-- Tabela para armazenar os Usuários
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

CREATE TABLE IF NOT EXISTS tb_forma_de_pagamento
(
    id              BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario      BIGINT UNSIGNED NOT NULL,
    forma_pagamento ENUM (
        'CARTAO_CREDITO',
        'CARTAO_DEBITO',
        'PIX',
        'BOLETO',
        'TRANSFERENCIA')            NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

-- Tabela para armazenar os Endereços dos Usuários
CREATE TABLE IF NOT EXISTS tb_enderecos
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario   BIGINT UNSIGNED NOT NULL,
    rua          VARCHAR(100),
    numero       VARCHAR(8),
    bairro       VARCHAR(100),
    cidade       VARCHAR(100),
    estado       VARCHAR(100),
    CEP          VARCHAR(20),
    complemento  VARCHAR(50)     NULL,
    is_principal BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

-- Tabela para armazenar os Produtos
CREATE TABLE IF NOT EXISTS tb_produtos
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(50)    NOT NULL,
    preco     DECIMAL(10, 2) NOT NULL,
    descricao TEXT           NULL, -- Pode ser NULL, pois o produto pode não ter descrição

    PRIMARY KEY (id)
);

-- Tabela para armazenar o Estoque dos Produtos
CREATE TABLE IF NOT EXISTS tb_estoque_produto
(
    id                      BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto              BIGINT UNSIGNED NOT NULL,
    quantidade              INT UNSIGNED    NOT NULL,
    localizacao             VARCHAR(70)     NULL,
    data_ultima_atualizacao DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
);

-- Tabela para armazenar as Categorias
CREATE TABLE IF NOT EXISTS tb_categorias
(
    id   BIGINT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de associação N:N entre Produtos e Categorias
CREATE TABLE IF NOT EXISTS tb_produtos_categorias
(
    id_produto   BIGINT UNSIGNED NOT NULL,
    id_categoria BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias (id)
);

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id)
);

-- Tabela de associação N:N entre Carrinhos e Produtos
CREATE TABLE IF NOT EXISTS tb_carrinho_produtos
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_carrinho BIGINT UNSIGNED NOT NULL,
    quantidade  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id),
    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id)
);

-- Definição: um cupom é um desconto aplicado a uma COMPRA
CREATE TABLE IF NOT EXISTS tb_cupons
(
    id_cupom    BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id_cupom)
);

-- Tabela para armazenar as Compras
CREATE TABLE IF NOT EXISTS tb_compras
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    data_compra       DATETIME        NOT NULL,
    id_usuario        BIGINT UNSIGNED NOT NULL,
    id_endereco       BIGINT UNSIGNED NOT NULL,
    id_transportadora BIGINT UNSIGNED NOT NULL,
    id_cupom          BIGINT UNSIGNED NULL,
    forma_pagamento   ENUM (
        'CARTAO_CREDITO',
        'CARTAO_DEBITO',
        'PIX',
        'BOLETO',
        'TRANSFERENCIA')              NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupons (id_cupom),
    FOREIGN KEY (id_endereco) REFERENCES tb_enderecos (id),
    FOREIGN KEY (id_transportadora) REFERENCES tb_transportadoras (id)
);

-- Tabela responsável por armazenar as avaliações de produtos de uma compra
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

-- Tabela de associação N:N entre Compras e Produtos
CREATE TABLE IF NOT EXISTS tb_compras_produtos
(
    id_compra  BIGINT UNSIGNED NOT NULL,
    id_produto BIGINT UNSIGNED NOT NULL,
    quantidade BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id)
);

-- Definição: uma promoção é um desconto aplicado a UM PRODUTO específico
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
