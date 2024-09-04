DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

-- Tabela para armazenar as Transportadoras
CREATE TABLE IF NOT EXISTS tb_transportadora
(
    id                 BIGINT UNSIGNED AUTO_INCREMENT,
    nome               VARCHAR(100)   NOT NULL,
    preco_por_km       DECIMAL(10, 2) NULL,
    cnpj               VARCHAR(20)    NOT NULL,
    inscricao_estadual VARCHAR(100)   NOT NULL,
    telefone           VARCHAR(20)    NOT NULL,
    email              VARCHAR(100)   NOT NULL,
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
    nome                 VARCHAR(100),
    cpf                  VARCHAR(20),
    telefone             VARCHAR(20),
    email                VARCHAR(100),
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100) NULL,

    UNIQUE (cpf),
    UNIQUE (email),

    PRIMARY KEY (id)
);

-- Tabela para armazenar as formas de pagamento
CREATE TABLE IF NOT EXISTS tb_forma_de_pagamento
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,
    tipo       ENUM (
        'PIX',
        'CARTAO_CREDITO',
        'BOLETO',
        'TRANSFERENCIA',
        'CARTAO_DEBITO',
        'DINHEIRO'
        )                      NOT NULL,

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
CREATE TABLE IF NOT EXISTS tb_cartao_credito
(
    id_forma_pgto    BIGINT UNSIGNED NOT NULL,
    numero           VARCHAR(20)     NOT NULL,
    validade         DATE            NOT NULL,
    codigo_seguranca VARCHAR(10)     NOT NULL,
    nome_dono        VARCHAR(100)    NOT NULL,

    PRIMARY KEY (id_forma_pgto),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- Tabela para armazenar detalhes específicos do Boleto
CREATE TABLE IF NOT EXISTS tb_boleto
(
    id_forma_pgto BIGINT UNSIGNED NOT NULL,
    codigo_barras VARCHAR(50)     NOT NULL,

    PRIMARY KEY (id_forma_pgto),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- Tabela para armazenar detalhes específicos da Transferência
CREATE TABLE IF NOT EXISTS tb_transferencia
(
    id_forma_pgto   BIGINT UNSIGNED NOT NULL,
    dados_bancarios VARCHAR(255)    NOT NULL,

    PRIMARY KEY (id_forma_pgto),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- Tabela para armazenar os Endereços dos Usuários
CREATE TABLE IF NOT EXISTS tb_endereco
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario   BIGINT UNSIGNED NOT NULL,
    rua          VARCHAR(100),
    numero       VARCHAR(8),
    bairro       VARCHAR(100),
    cidade       VARCHAR(100),
    estado       VARCHAR(100),
    cep          VARCHAR(20),
    complemento  VARCHAR(50)     NULL,
    is_principal BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela para armazenar os Produtos
CREATE TABLE IF NOT EXISTS tb_produto
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(50)    NOT NULL,
    preco     DECIMAL(10, 2) NOT NULL,
    descricao TEXT           NULL, -- Pode ser NULL, pois o produto pode não ter descrição

    PRIMARY KEY (id)
);

-- Tabela para armazenar o Estoque dos Produtos
CREATE TABLE IF NOT EXISTS tb_estoque
(
    id                      BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto              BIGINT UNSIGNED NOT NULL,
    quantidade              INT UNSIGNED    NOT NULL,
    localizacao             VARCHAR(70)     NULL, -- Ex: "Prateleira A", "Depósito 1", etc.
    data_ultima_atualizacao DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

-- Tabela para armazenar as Categorias
CREATE TABLE IF NOT EXISTS tb_categoria
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(50) NOT NULL,
    descricao TEXT        NULL, -- Pode ser NULL, pois a categoria pode não ter descrição

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

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
);

-- Tabela de associação N:N entre Carrinhos e Produtos
CREATE TABLE IF NOT EXISTS tb_carrinho_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_carrinho BIGINT UNSIGNED NOT NULL,
    quantidade  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinhos (id)
);

-- Tabela para armazenar as Compras
CREATE TABLE IF NOT EXISTS tb_compra
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario  BIGINT UNSIGNED NOT NULL,
    id_endereco BIGINT UNSIGNED NOT NULL,
    data_compra DATETIME        NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id),
    FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
);

-- Tabela de associação 1:N entre Compras e Formas de Pagamento
CREATE TABLE IF NOT EXISTS tb_compra_forma_pgto
(
    id_compra       BIGINT UNSIGNED NOT NULL,
    id_forma_pgto   BIGINT UNSIGNED NOT NULL,
    valor_pago      DECIMAL(10, 2)  NOT NULL,
    data_pagamento  DATETIME        NULL,
    data_confirmado DATETIME        NULL,

    PRIMARY KEY (id_compra, id_forma_pgto),

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
);

-- tabela para armazenar os produtos comprados em cada compra, além de suas opcionais avaliações
CREATE TABLE IF NOT EXISTS tb_compra_produto
(
    id_compra      BIGINT UNSIGNED                NOT NULL,
    id_produto     BIGINT UNSIGNED                NOT NULL,
    quantidade     BIGINT UNSIGNED                NOT NULL,
    avaliacao      ENUM (
        '⭐',
        '⭐⭐',
        '⭐⭐⭐',
        '⭐⭐⭐⭐',
        '⭐⭐⭐⭐⭐')
                       CHARACTER SET utf8mb4
                       COLLATE utf8mb4_unicode_ci NULL, -- Avaliação com emojis de estrelas (opcional)
    comentario     TEXT                           NULL, -- Comentário (opcional)
    data_avaliacao DATETIME                       NULL, -- Data da avaliação (opcional)

    UNIQUE KEY (id_compra, id_produto),
    PRIMARY KEY (id_compra, id_produto),

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Tabela de rastreamento de compras, com relação 1:1 com tb_compras
CREATE TABLE IF NOT EXISTS tb_compra_rastreamento
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    id_compra         BIGINT UNSIGNED NOT NULL,
    id_transportadora BIGINT UNSIGNED NOT NULL,
    status_entrega    ENUM (
        'ENVIADO',
        'EM_TRANSITO',
        'ENTREGUE',
        'NAO_ENTREGUE')               NULL,
    codigo_rastreio   VARCHAR(100)    NULL,
    data_envio        DATETIME        NULL,
    data_recebimento  DATETIME        NULL,

    PRIMARY KEY (id),
    UNIQUE KEY uk_id_compra (id_compra), -- Garante que cada compra tenha apenas um rastreamento

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_transportadora) REFERENCES tb_transportadora (id)
);

-- Definição: uma promoção é um desconto aplicado a UM PRODUTO específico
CREATE TABLE IF NOT EXISTS tb_promocao
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- A promoção pode estar em vários produtos, porém a promoção é aplicada individualmente a cada produto
CREATE TABLE IF NOT EXISTS tb_promocao_produto
(
    id_produto     BIGINT UNSIGNED NOT NULL,
    id_promocao    BIGINT UNSIGNED NOT NULL,
    data_aplicacao DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_produto, id_promocao), -- Garante que um produto tenha apenas uma promoção

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
