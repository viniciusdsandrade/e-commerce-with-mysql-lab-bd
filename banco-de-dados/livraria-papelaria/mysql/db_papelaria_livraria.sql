DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

-- Tabela para armazenar os Administradores
CREATE TABLE IF NOT EXISTS tb_administrador
(

    id                   BIGINT UNSIGNED AUTO_INCREMENT,
    nome                 VARCHAR(100) NOT NULL,
    email                VARCHAR(100) NOT NULL,
    email_de_recuperacao VARCHAR(100) NULL,
    senha_hash           VARCHAR(255) NOT NULL,
    salt                 VARCHAR(255) NOT NULL, -- Valor aleatório único que é adicionado à senha antes de ser criptografada
    status               ENUM (
        'ativo',
        'inativo',
        'bloqueado'
        )                             NOT NULL DEFAULT 'ativo',
    nivel_acesso         ENUM (
        'administrador',
        'superadministrador'
        )                             NOT NULL DEFAULT 'administrador',
    created_at           TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE (email),
    UNIQUE (salt),

    PRIMARY KEY (id)
);

-- Tabela para armazenar as Transportadoras
CREATE TABLE IF NOT EXISTS tb_transportadora
(
    id                 BIGINT UNSIGNED AUTO_INCREMENT,
    nome               VARCHAR(100)   NOT NULL,
    cnpj               VARCHAR(20)    NOT NULL,
    inscricao_estadual VARCHAR(100)   NOT NULL,
    telefone           VARCHAR(20)    NOT NULL,
    email              VARCHAR(100)   NOT NULL,
    preco_km           DECIMAL(10, 2) NULL,
    endereco           VARCHAR(100)   NULL,

    UNIQUE (cnpj),
    UNIQUE (inscricao_estadual),
    UNIQUE (email),

    PRIMARY KEY (id)
);

-- Tabela para armazenar os Usuários
CREATE TABLE IF NOT EXISTS tb_usuario
(
    id                   BIGINT UNSIGNED AUTO_INCREMENT,
    foto_perfil          VARCHAR(255) NULL,
    nome                 VARCHAR(100) NOT NULL,
    data_nascimento      DATE         NULL,
    cpf                  VARCHAR(20)  NOT NULL,
    email                VARCHAR(100) NOT NULL,
    email_de_recuperacao VARCHAR(100) NULL,
    senha_hash           VARCHAR(255) NOT NULL,
    salt                 VARCHAR(255) NOT NULL, -- Valor aleatório único que é adicionado à senha antes de ser criptografada
    telefone             VARCHAR(20)  NULL,
    saldo                DECIMAL(10, 2)        DEFAULT 0,
    status               ENUM (
        'ativo',
        'inativo',
        'bloqueado'
        )                             NOT NULL DEFAULT 'ativo',
    created_at           TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE (cpf),
    UNIQUE (email),
    UNIQUE (salt),

    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tb_log_acesso
(
    id              BIGINT UNSIGNED AUTO_INCREMENT,
    tipo_usuario    ENUM (
        'administrador',
        'superadministrador',
        'usuario'
        )                           NOT NULL,
    usuario_id      BIGINT UNSIGNED NOT NULL,
    data_hora_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address      VARCHAR(45)     NULL,
    user_agent      VARCHAR(255)    NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (usuario_id) REFERENCES tb_usuario (id) ON DELETE CASCADE,      -- Ajustar se o ID do administrador vier de outra tabela
    FOREIGN KEY (usuario_id) REFERENCES tb_administrador (id) ON DELETE CASCADE -- Ajustar se o ID do administrador vier de outra tabela
);

-- Tabela para armazenar as formas de pagamento
CREATE TABLE IF NOT EXISTS tb_forma_de_pagamento
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela para armazenar detalhes específicos do PIX
CREATE TABLE IF NOT EXISTS tb_pix
(
    id_forma_pgto BIGINT UNSIGNED NOT NULL,
    chave         VARCHAR(100)    NOT NULL,

    PRIMARY KEY (id_forma_pgto),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- Tabela para armazenar detalhes específicos do Cartão de Crédito
CREATE TABLE IF NOT EXISTS tb_cartao
(
    id_forma_pgto    BIGINT UNSIGNED            NOT NULL,
    numero           VARCHAR(20)                NOT NULL,
    validade         DATE                       NOT NULL,
    codigo_seguranca VARCHAR(10)                NOT NULL,
    nome_dono        VARCHAR(100)               NOT NULL,
    tipo             ENUM ('DEBITO', 'CREDITO') NOT NULL,

    PRIMARY KEY (id_forma_pgto),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- Tabela para armazenar os Endereços dos Usuários
CREATE TABLE IF NOT EXISTS tb_endereco
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario   BIGINT UNSIGNED NOT NULL,
    rua          VARCHAR(100)    NULL,
    numero       VARCHAR(8)      NULL,
    bairro       VARCHAR(100)    NULL,
    cidade       VARCHAR(100)    NULL,
    estado       VARCHAR(100)    NULL,
    cep          VARCHAR(20)     NULL,
    complemento  VARCHAR(50)     NULL,
    is_principal BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela para armazenar os Produtos
CREATE TABLE IF NOT EXISTS tb_produto
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    nome       VARCHAR(50)    NOT NULL,
    preco      DECIMAL(10, 2) NOT NULL,
    descricao  TEXT           NULL,
    is_ativo   BOOLEAN   DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

-- Tabela para registrar o histórico de preços dos produtos
CREATE TABLE IF NOT EXISTS log_produto_preco_historico
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto     BIGINT UNSIGNED NOT NULL,
    preco_anterior DECIMAL(10, 2)  NOT NULL,
    preco_novo     DECIMAL(10, 2)  NOT NULL,
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

-- Tabela para armazenar os produtos excluídos
CREATE TABLE log_produto_inativos
(
    id              BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto      BIGINT UNSIGNED NOT NULL,
    nome            VARCHAR(255)    NOT NULL,
    preco           DECIMAL(10, 2)  NOT NULL,
    data_inativacao DATETIME        NOT NULL,
    data_reativacao DATETIME        NULL,

    PRIMARY KEY (id)
);

-- Tabela para armazenar o Estoque dos Produtos
CREATE TABLE IF NOT EXISTS tb_estoque
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto  BIGINT UNSIGNED    NOT NULL,
    quantidade  MEDIUMINT UNSIGNED NOT NULL,
    localizacao VARCHAR(70)        NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

-- Tabela para armazenar as Categorias
CREATE TABLE IF NOT EXISTS tb_categoria
(
    id   BIGINT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de associação N:N entre Produtos e Categorias
CREATE TABLE IF NOT EXISTS tb_produto_categoria
(
    id_produto   BIGINT UNSIGNED NOT NULL,
    id_categoria BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)
);

-- Tabela para armazenar as Avaliações dos Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejos
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela de associação N:N entre Listas de Desejos e Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejos_produto
(
    id_produto       BIGINT UNSIGNED NOT NULL,
    id_lista_desejos BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_lista_desejos) REFERENCES tb_lista_desejos (id)
);

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_usuario),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela de associação N:N entre Carrinhos e Produtos
CREATE TABLE IF NOT EXISTS tb_carrinho_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_carrinho BIGINT UNSIGNED NOT NULL,
    quantidade  INT UNSIGNED    NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id_usuario)
);

-- Tabela para armazenar as Compras
CREATE TABLE IF NOT EXISTS tb_compra
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario     BIGINT UNSIGNED NOT NULL,
    id_endereco    BIGINT UNSIGNED NOT NULL,
    data_realizada DATETIME        NOT NULL,
    preco_total    DECIMAL(10, 2) DEFAULT 0,
    created_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id),
    FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
);

-- tabela para armazenar os produtos comprados em cada compra, além de suas opcionais avaliações
CREATE TABLE IF NOT EXISTS tb_compra_produto
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_compra  BIGINT UNSIGNED    NOT NULL,
    id_produto BIGINT UNSIGNED    NOT NULL,
    quantidade MEDIUMINT UNSIGNED NOT NULL,

    UNIQUE KEY (id_compra, id_produto),
    PRIMARY KEY (id),

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Tabela para armazenar as avaliações dos produtos comprados
CREATE TABLE IF NOT EXISTS tb_avaliacao
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    id_compra_produto BIGINT UNSIGNED                NOT NULL,

    avaliacao         ENUM (
        '⭐',
        '⭐⭐',
        '⭐⭐⭐',
        '⭐⭐⭐⭐',
        '⭐⭐⭐⭐⭐'
        ) CHARACTER SET utf8mb4
                          COLLATE utf8mb4_unicode_ci NULL, -- Avaliação com emojis de estrelas (opcional)
    comentario        TEXT                           NULL, -- Comentário (opcional),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_compra_produto) REFERENCES tb_compra_produto (id)
);

-- Tabela de rastreamento de compras, com relação 1:1 com tb_compras
CREATE TABLE IF NOT EXISTS tb_entrega
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    id_compra         BIGINT UNSIGNED NOT NULL,
    id_transportadora BIGINT UNSIGNED NOT NULL,
    codigo_rastreio   VARCHAR(100)    NULL,
    data_envio        DATETIME        NULL,
    data_recebimento  DATETIME        NULL,
    status_entrega    ENUM (
        'ENVIADO',
        'EM_TRANSITO',
        'ENTREGUE',
        'NAO_ENTREGUE'
        )                             NULL,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uk_id_compra (id_compra), -- Garante que cada compra tenha apenas uma entrega

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_transportadora) REFERENCES tb_transportadora (id)
);

-- Definição: uma promoção é um desconto aplicado a UM ou MAIS PRODUTOS
CREATE TABLE IF NOT EXISTS tb_promocao
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL, -- Desconto da promoção
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- A promoção pode estar em vários produtos
CREATE TABLE IF NOT EXISTS tb_promocao_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_promocao BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_produto, id_promocao), -- Garante que um produto participe de uma promoção apenas uma vez

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocao (id)
);

-- Definição: um cupom é um desconto aplicado a uma COMPRA
CREATE TABLE IF NOT EXISTS tb_cupom
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- Um cupom pode ser aplicado a várias compras e uma compra pode ter vários cupons
CREATE TABLE IF NOT EXISTS tb_cupom_compra
(
    id_compra BIGINT UNSIGNED NOT NULL,
    id_cupom  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupom (id)
);
