DROP DATABASE IF EXISTS db_papelaria;
CREATE DATABASE IF NOT EXISTS db_papelaria;
USE db_papelaria;

CREATE TABLE IF NOT EXISTS tb_usuarios
(
    id_usuario           INT AUTO_INCREMENT PRIMARY KEY,
    nome                 VARCHAR(100),
    CPF                  VARCHAR(20),
    telefone             VARCHAR(20),
    email                VARCHAR(100),
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100) NULL,
    id_endereco          INT,

    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS tb_enderecos
(
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario  INT,
    endereco    VARCHAR(100),
    numero      VARCHAR(10),
    complemento VARCHAR(100) NULL,
    bairro      VARCHAR(100),
    cidade      VARCHAR(100),
    estado      VARCHAR(100),
    CEP         VARCHAR(20),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id_usuario)
);

CREATE TABLE IF NOT EXISTS tb_produtos
(
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100),
    preco      DECIMAL(10, 2),
    descricao  TEXT

);

CREATE TABLE IF NOT EXISTS tb_categorias
(
    id_categoria INT AUTO_INCREMENT,
    nome         VARCHAR(100),

    PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS tb_produtos_categorias
(
    id_produto   INT,
    id_categoria INT,
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto),
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias (id_categoria)
);

# Uma que associa o carrinho com todos os produtos selecionados

CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id_carrinho INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario  INT,
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id_usuario)
);

CREATE TABLE IF NOT EXISTS tb_carrinho_produtos
(
    id_carrinho INT,
    id_produto  INT,
    quantidade  INT,
    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id_carrinho),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto)
);


# Tabela de log das compras realizadas

CREATE TABLE IF NOT EXISTS tb_compras
(
    id_compra         INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario        INT,
    data_compra       DATETIME,
    id_transportadora INT,

    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios (id_usuario)
);

# Cada compra pode 0 ou n promoções/cupons
# e cada promoção/cupom pode estar associado a 1 ou n produtos(da compra) --> tb_compras_produtos

CREATE TABLE IF NOT EXISTS tb_compras_promocoes
(
    id_compra   INT,
    id_promocao INT,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocoes (id_promocao)
);

CREATE TABLE IF NOT EXISTS tb_promocoes
(
    id_promocao INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(100) NULL,
    desconto    DECIMAL(10, 2),
    data_inicio DATETIME,
    data_fim    DATETIME
);

CREATE TABLE IF NOT EXISTS tb_compras_cupons
(
    id_compra INT,
    id_cupom  INT,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupons (id_cupom)
);

CREATE TABLE IF NOT EXISTS tb_cupons
(
    id_cupom    INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(100),
    desconto    DECIMAL(10, 2),
    data_inicio DATETIME,
    data_fim    DATETIME
);

CREATE TABLE IF NOT EXISTS tb_compras_produtos
(
    id_compra  INT,
    id_produto INT,
    quantidade INT,

    FOREIGN KEY (id_compra) REFERENCES tb_compras (id_compra),
    FOREIGN KEY (id_produto) REFERENCES tb_produtos (id_produto)
);

CREATE TABLE IF NOT EXISTS tb_transportadoras
(
    id_transportadora  INT AUTO_INCREMENT,
    nome               VARCHAR(100),
    preco_por_km       DECIMAL(10, 2),
    CNPJ               VARCHAR(20),
    inscricao_estadual VARCHAR(100),
    telefone           VARCHAR(20),
    email              VARCHAR(100),
    endereco           VARCHAR(100),

    PRIMARY KEY (id_transportadora)
);




