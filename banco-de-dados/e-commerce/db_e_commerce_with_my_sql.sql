/*
    TABELAS DE PRODUTOS E CATEGORIAS
    TABELA DE CLIENTES
    TABELA DE PEDIDOS E ITENS DE PEDIDO
    TABELAS DE CARRINHO DE COMPRA S E LISTA DE DESEJOS
    TABELA DE AVALIÇÕES E COMENTÁRIOS
    TABELA DE PROMOÇÕES E CUPONS
    TABELA DE PAGAMENTOS E TRANSAÇÕES
    TABELA DE LOGÍSTICA E ENVIO
    TABELA ADMINISTRAÇÃO E CONTROLE DE ACESSO
    HISTÓRICO E REGISTROS DE ATIVIDADES - LOGS

    - levantamento de requisitos
    - UML diagrama de classe
    - mínimo 25 tabelas
    - mínimo de 20 registros/tabela
    - mínimo 3 views
    - mínimo 3 procedures
    - mínimo 2 triggers
 */

DROP DATABASE IF EXISTS db_e_commerce_with_my_sql;
CREATE DATABASE IF NOT EXISTS db_e_commerce_with_my_sql;
USE db_e_commerce_with_my_sql;

SHOW TABLES;

CREATE TABLE tb_categoria
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(100) NOT NULL,
    descricao TEXT NULL, -- Campo opcional

    PRIMARY KEY (id)
);

CREATE TABLE tb_produto
(
    id            BIGINT UNSIGNED AUTO_INCREMENT,
    nome          VARCHAR(100)   NOT NULL,
    descricao     TEXT NULL,
    preco         DECIMAL(10, 2) NOT NULL,
    estoque       INT UNSIGNED   NOT NULL,
    id_categoria  BIGINT UNSIGNED NOT NULL,  -- Relacionamento obrigatório com tb_categoria

    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)  -- Chave estrangeira para tb_categoria
);

CREATE TABLE tb_produto_categoria
(
    id_produto   BIGINT UNSIGNED,
    id_categoria BIGINT UNSIGNED,

    PRIMARY KEY (id_produto, id_categoria),

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)
);

CREATE TABLE tb_cliente
(
    id       BIGINT UNSIGNED AUTO_INCREMENT,
    nome     VARCHAR(100) NOT NULL,
    email    VARCHAR(100) NOT NULL UNIQUE,
    senha    VARCHAR(255) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(20),

    PRIMARY KEY (id)
);

CREATE TABLE tb_pedido
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    id_cliente  BIGINT UNSIGNED,
    data_pedido DATETIME                                              NOT NULL,
    status      ENUM ('Pendente', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    total       DECIMAL(10, 2)                                        NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id)
);

CREATE TABLE tb_item_pedido
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_pedido      BIGINT UNSIGNED,
    id_produto     BIGINT UNSIGNED,
    quantidade     INT UNSIGNED   NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

CREATE TABLE tb_carrinho
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_cliente   BIGINT UNSIGNED,
    data_criacao DATETIME NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id)
);

CREATE TABLE tb_item_carrinho
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    id_carrinho BIGINT UNSIGNED,
    id_produto  BIGINT UNSIGNED,
    quantidade  INT UNSIGNED NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

CREATE TABLE tb_lista_desejos
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_cliente   BIGINT UNSIGNED,
    data_criacao DATETIME NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id)
);

CREATE TABLE tb_item_lista_desejos
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_lista_desejos BIGINT UNSIGNED,
    id_produto       BIGINT UNSIGNED,

    PRIMARY KEY (id),

    FOREIGN KEY (id_lista_desejos) REFERENCES tb_lista_desejos (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

CREATE TABLE tb_avaliacao
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto     BIGINT UNSIGNED,
    id_cliente     BIGINT UNSIGNED,
    rating         INT UNSIGNED NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comentario     TEXT,
    data_avaliacao DATETIME     NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id)
);

CREATE TABLE tb_promocao
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)  NOT NULL,
    descricao   TEXT,
    desconto    DECIMAL(5, 2) NOT NULL,
    data_inicio DATETIME      NOT NULL,
    data_fim    DATETIME      NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE tb_cupom
(
    id            BIGINT UNSIGNED AUTO_INCREMENT,
    codigo        VARCHAR(50)   NOT NULL UNIQUE,
    desconto      DECIMAL(5, 2) NOT NULL,
    data_validade DATETIME      NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE tb_pagamento
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_pedido        BIGINT UNSIGNED,
    metodo_pagamento ENUM ('Cartão de Crédito', 'Boleto', 'PayPal', 'Pix') NOT NULL,
    status           ENUM ('Pendente', 'Aprovado', 'Recusado')             NOT NULL,
    data_pagamento   DATETIME,

    PRIMARY KEY (id),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id)
);

CREATE TABLE tb_transacao
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_pagamento     BIGINT UNSIGNED,
    codigo_transacao VARCHAR(100)   NOT NULL UNIQUE,
    data_transacao   DATETIME       NOT NULL,
    valor            DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_pagamento) REFERENCES tb_pagamento (id)
);

CREATE TABLE tb_envio
(
    id              BIGINT UNSIGNED AUTO_INCREMENT,
    id_pedido       BIGINT UNSIGNED,
    metodo_envio    VARCHAR(100)                                         NOT NULL,
    data_envio      DATETIME                                             NOT NULL,
    status          ENUM ('Aguardando Envio', 'Em Trânsito', 'Entregue') NOT NULL,
    tracking_number VARCHAR(100),

    PRIMARY KEY (id),
    FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id)
);

CREATE TABLE tb_usuario_admin
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    nome         VARCHAR(100)                        NOT NULL,
    email        VARCHAR(100)                        NOT NULL UNIQUE,
    senha        VARCHAR(255)                        NOT NULL,
    nivel_acesso ENUM ('Administrador', 'Moderador') NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE tb_log_atividade
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario_admin BIGINT UNSIGNED,
    acao             TEXT     NOT NULL,
    data_hora        DATETIME NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario_admin) REFERENCES tb_usuario_admin (id)
);

DESCRIBE tb_categoria;
DESCRIBE tb_produto;
DESCRIBE tb_produto_categoria;
DESCRIBE tb_cliente;
DESCRIBE tb_pedido;
DESCRIBE tb_item_pedido;
DESCRIBE tb_carrinho;
DESCRIBE tb_item_carrinho;
DESCRIBE tb_lista_desejos;
DESCRIBE tb_item_lista_desejos;
DESCRIBE tb_avaliacao;
DESCRIBE tb_promocao;
DESCRIBE tb_cupom;
DESCRIBE tb_pagamento;
DESCRIBE tb_transacao;
DESCRIBE tb_envio;
DESCRIBE tb_usuario_admin;
DESCRIBE tb_log_atividade;
