-- Desabilita o modo de confirmação implícita para evitar erros
SET client_min_messages TO WARNING;

-- Remove o banco de dados se ele já existir
DROP DATABASE IF EXISTS db_papelaria_livraria;

-- Cria o banco de dados se ele não existir
CREATE DATABASE db_papelaria_livraria;

DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON tb_produto;
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON tb_estoque;
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON tb_compra;
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON tb_avaliacao;
DROP TRIGGER IF EXISTS trigger_atualizar_updated_at ON tb_entrega;


-- Usa o banco de dados
\c db_papelaria_livraria;

-- Tabela para armazenar os Administradores
CREATE TABLE IF NOT EXISTS tb_administrador
(
    id                   SERIAL,
    nome                 VARCHAR(100)        NOT NULL,
    email                VARCHAR(100) UNIQUE NOT NULL,
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100),

    PRIMARY KEY (id)
);

-- Tabela para armazenar as Transportadoras
CREATE TABLE IF NOT EXISTS tb_transportadora
(
    id                 SERIAL PRIMARY KEY,
    nome               VARCHAR(100)        NOT NULL,
    cnpj               VARCHAR(20) UNIQUE  NOT NULL,
    inscricao_estadual VARCHAR(100) UNIQUE NOT NULL,
    telefone           VARCHAR(20)         NOT NULL,
    email              VARCHAR(100) UNIQUE NOT NULL,
    preco_km           DECIMAL(10, 2),
    endereco           VARCHAR(100)
);

-- Tabela para armazenar os Usuários
CREATE TABLE IF NOT EXISTS tb_usuario
(
    id                   SERIAL PRIMARY KEY,
    nome                 VARCHAR(100),
    cpf                  VARCHAR(20) UNIQUE,
    telefone             VARCHAR(20),
    email                VARCHAR(100) UNIQUE,
    senha                VARCHAR(100),
    email_de_recuperacao VARCHAR(100),
    saldo                DECIMAL(10, 2) DEFAULT 0
);

-- Tabela para armazenar as formas de pagamento
CREATE TABLE IF NOT EXISTS tb_forma_de_pagamento
(
    id         SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES tb_usuario (id) NOT NULL
);

-- Tabela para armazenar detalhes específicos do PIX
CREATE TABLE IF NOT EXISTS tb_pix
(
    id_forma_pgto INTEGER PRIMARY KEY REFERENCES tb_forma_de_pagamento (id) NOT NULL,
    chave         VARCHAR(100)                                              NOT NULL
);

-- Tabela para armazenar detalhes específicos do Cartão de Crédito
CREATE TABLE IF NOT EXISTS tb_cartao
(
    id_forma_pgto    INTEGER PRIMARY KEY REFERENCES tb_forma_de_pagamento (id) NOT NULL,
    numero           VARCHAR(20)                                               NOT NULL,
    validade         DATE                                                      NOT NULL,
    codigo_seguranca VARCHAR(10)                                               NOT NULL,
    nome_dono        VARCHAR(100)                                              NOT NULL,
    tipo             VARCHAR(10) CHECK (tipo IN ('DEBITO', 'CREDITO'))         NOT NULL
);

-- Tabela para armazenar os Endereços dos Usuários
CREATE TABLE IF NOT EXISTS tb_endereco
(
    id           SERIAL PRIMARY KEY,
    id_usuario   INTEGER REFERENCES tb_usuario (id) NOT NULL,
    rua          VARCHAR(100),
    numero       VARCHAR(8),
    bairro       VARCHAR(100),
    cidade       VARCHAR(100),
    estado       VARCHAR(100),
    cep          VARCHAR(20),
    complemento  VARCHAR(50),
    is_principal BOOLEAN DEFAULT FALSE
);

-- Tabela para armazenar os Produtos
CREATE TABLE IF NOT EXISTS tb_produto
(
    id         SERIAL PRIMARY KEY,
    nome       VARCHAR(50)    NOT NULL,
    preco      DECIMAL(10, 2) NOT NULL,
    descricao  TEXT,
    is_ativo   BOOLEAN   DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Função para atualizar o campo updated_at
CREATE OR REPLACE FUNCTION atualiza_timestamp()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger para atualizar o campo updated_at automaticamente
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE
    ON tb_produto
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_timestamp();


-- Tabela para registrar o histórico de preços dos produtos
CREATE TABLE IF NOT EXISTS log_produto_preco_historico
(
    id             SERIAL PRIMARY KEY,
    id_produto     INTEGER REFERENCES tb_produto (id) NOT NULL,
    preco_anterior DECIMAL(10, 2)                     NOT NULL,
    preco_novo     DECIMAL(10, 2)                     NOT NULL,
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar os produtos excluídos
CREATE TABLE IF NOT EXISTS log_produto_inativos
(
    id              SERIAL PRIMARY KEY,
    id_produto      INTEGER        NOT NULL,
    nome            VARCHAR(255)   NOT NULL,
    preco           DECIMAL(10, 2) NOT NULL,
    data_inativacao TIMESTAMP      NOT NULL,
    data_reativacao TIMESTAMP
);

-- Tabela para armazenar o Estoque dos Produtos
CREATE TABLE IF NOT EXISTS tb_estoque
(
    id          SERIAL PRIMARY KEY,
    id_produto  INTEGER REFERENCES tb_produto (id) NOT NULL,
    quantidade  INTEGER CHECK (quantidade >= 0)    NOT NULL,
    localizacao VARCHAR(70),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para atualizar o campo updated_at automaticamente
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE
    ON tb_estoque
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_timestamp();

-- Tabela para armazenar as Categorias
CREATE TABLE IF NOT EXISTS tb_categoria
(
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de associação N:N entre Produtos e Categorias
CREATE TABLE IF NOT EXISTS tb_produto_categoria
(
    id_produto   INTEGER REFERENCES tb_produto (id)   NOT NULL,
    id_categoria INTEGER REFERENCES tb_categoria (id) NOT NULL,
    PRIMARY KEY (id_produto, id_categoria)
);

-- Tabela para armazenar as Avaliações dos Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejos
(
    id         SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES tb_usuario (id) NOT NULL
);

-- Tabela de associação N:N entre Listas de Desejos e Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejos_produto
(
    id_produto       INTEGER REFERENCES tb_produto (id)       NOT NULL,
    id_lista_desejos INTEGER REFERENCES tb_lista_desejos (id) NOT NULL,
    PRIMARY KEY (id_produto, id_lista_desejos)
);

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id         SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES tb_usuario (id) NOT NULL
);

-- Tabela de associação N:N entre Carrinhos e Produtos
CREATE TABLE IF NOT EXISTS tb_carrinho_produto
(
    id_produto  INTEGER REFERENCES tb_produto (id)  NOT NULL,
    id_carrinho INTEGER REFERENCES tb_carrinho (id) NOT NULL,
    quantidade  INTEGER CHECK (quantidade > 0)      NOT NULL,
    PRIMARY KEY (id_produto, id_carrinho)
);

-- Tabela para armazenar as Compras
CREATE TABLE IF NOT EXISTS tb_compra
(
    id             SERIAL PRIMARY KEY,
    id_usuario     INTEGER REFERENCES tb_usuario (id)  NOT NULL,
    id_endereco    INTEGER REFERENCES tb_endereco (id) NOT NULL,
    data_realizada TIMESTAMP                           NOT NULL,
    preco_total    DECIMAL(10, 2) DEFAULT 0,
    created_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para atualizar o campo updated_at automaticamente
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE
    ON tb_compra
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_timestamp();


-- tabela para armazenar os produtos comprados em cada compra, além de suas opcionais avaliações
CREATE TABLE IF NOT EXISTS tb_compra_produto
(
    id         SERIAL PRIMARY KEY,
    id_compra  INTEGER REFERENCES tb_compra (id)  NOT NULL,
    id_produto INTEGER REFERENCES tb_produto (id) NOT NULL,
    quantidade INTEGER CHECK (quantidade > 0)     NOT NULL,
    UNIQUE (id_compra, id_produto)
);

-- Tabela para armazenar as avaliações dos produtos comprados
CREATE TABLE IF NOT EXISTS tb_avaliacao
(
    id                SERIAL PRIMARY KEY,
    id_compra_produto INTEGER REFERENCES tb_compra_produto (id) NOT NULL,
    avaliacao         VARCHAR(10) CHECK (avaliacao IN ('⭐', '⭐⭐', '⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐⭐⭐')),
    comentario        TEXT,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para atualizar o campo updated_at automaticamente
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE
    ON tb_avaliacao
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_timestamp();

-- Tabela de rastreamento de compras, com relação 1:1 com tb_compras
CREATE TABLE IF NOT EXISTS tb_entrega
(
    id                SERIAL PRIMARY KEY,
    id_compra         INTEGER REFERENCES tb_compra (id) UNIQUE  NOT NULL,
    id_transportadora INTEGER REFERENCES tb_transportadora (id) NOT NULL,
    codigo_rastreio   VARCHAR(100),
    data_envio        TIMESTAMP,
    data_recebimento  TIMESTAMP,
    status_entrega    VARCHAR(20) CHECK (status_entrega IN ('ENVIADO', 'EM_TRANSITO', 'ENTREGUE', 'NAO_ENTREGUE')),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para atualizar o campo updated_at automaticamente
CREATE TRIGGER trigger_atualizar_updated_at
    BEFORE UPDATE
    ON tb_entrega
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_timestamp();


-- Definição: uma promoção é um desconto aplicado a UM ou MAIS PRODUTOS
CREATE TABLE IF NOT EXISTS tb_promocao
(
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100),
    desconto    DECIMAL(10, 2) CHECK (desconto >= 0 AND desconto <= 100) NOT NULL, -- Desconto da promoção
    data_inicio TIMESTAMP                                                NOT NULL,
    data_fim    TIMESTAMP                                                NOT NULL
);

-- A promoção pode estar em vários produtos
CREATE TABLE IF NOT EXISTS tb_promocao_produto
(
    id_produto  INTEGER REFERENCES tb_produto (id)  NOT NULL,
    id_promocao INTEGER REFERENCES tb_promocao (id) NOT NULL,
    PRIMARY KEY (id_produto, id_promocao) -- Garante que um produto participe de uma promoção apenas uma vez
);

-- Definição: um cupom é um desconto aplicado a uma COMPRA
CREATE TABLE IF NOT EXISTS tb_cupom
(
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100),
    desconto    DECIMAL(10, 2) CHECK (desconto >= 0 AND desconto <= 100) NOT NULL,
    data_inicio TIMESTAMP                                                NOT NULL,
    data_fim    TIMESTAMP                                                NOT NULL
);

-- Um cupom pode ser aplicado a várias compras e uma compra pode ter vários cupons
CREATE TABLE IF NOT EXISTS tb_cupom_compra
(
    id_compra INTEGER REFERENCES tb_compra (id) NOT NULL,
    id_cupom  INTEGER REFERENCES tb_cupom (id)  NOT NULL,
    PRIMARY KEY (id_compra, id_cupom)
);

-- Habilita o modo de confirmação implícita novamente
SET client_min_messages TO NOTICE;

-- Informa que o script foi executado com sucesso
SELECT 'Script executado com sucesso!';
