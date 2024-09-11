-- Desabilita a verificação de chaves estrangeiras durante a criação das tabelas, será habilitado novamente no final do script
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

IF OBJECT_ID('tb_cupom_compra') IS NOT NULL
    BEGIN
        DROP TABLE tb_cupom_compra;
    END;
GO

IF OBJECT_ID('tb_promocao_produto') IS NOT NULL
    BEGIN
        DROP TABLE tb_promocao_produto;
    END;
GO

IF OBJECT_ID('tb_produto_categoria') IS NOT NULL
    BEGIN
        DROP TABLE tb_produto_categoria;
    END;
GO

IF OBJECT_ID('tb_lista_desejos_produto') IS NOT NULL
    BEGIN
        DROP TABLE tb_lista_desejos_produto;
    END;
GO

IF OBJECT_ID('tb_carrinho_produto') IS NOT NULL
    BEGIN
        DROP TABLE tb_carrinho_produto;
    END;
GO

IF OBJECT_ID('tb_avaliacao') IS NOT NULL
    BEGIN
        DROP TABLE tb_avaliacao;
    END;
GO

IF OBJECT_ID('tb_cupom') IS NOT NULL
    BEGIN
        DROP TABLE tb_cupom;
    END;
GO

IF OBJECT_ID('tb_promocao') IS NOT NULL
    BEGIN
        DROP TABLE tb_promocao;
    END;
GO

IF OBJECT_ID('tb_lista_desejos') IS NOT NULL
    BEGIN
        DROP TABLE tb_lista_desejos;
    END;
GO

IF OBJECT_ID('tb_carrinho') IS NOT NULL
    BEGIN
        DROP TABLE tb_carrinho;
    END;
GO

IF OBJECT_ID('tb_entrega') IS NOT NULL
    BEGIN
        DROP TABLE tb_entrega;
    END;
GO

IF OBJECT_ID('tb_categoria') IS NOT NULL
    BEGIN
        DROP TABLE tb_categoria;
    END;
GO

IF OBJECT_ID('tb_estoque') IS NOT NULL
    BEGIN
        DROP TABLE tb_estoque;
    END;
GO

IF OBJECT_ID('tb_compra_produto') IS NOT NULL
    BEGIN
        DROP TABLE tb_compra_produto;
    END;
GO

IF OBJECT_ID('tb_compra') IS NOT NULL
    BEGIN
        DROP TABLE tb_compra;
    END;
GO

IF OBJECT_ID('tb_pix') IS NOT NULL
    BEGIN
        DROP TABLE tb_pix;
    END;
GO

IF OBJECT_ID('tb_cartao') IS NOT NULL
    BEGIN
        DROP TABLE tb_cartao;
    END;
GO

IF OBJECT_ID('tb_forma_de_pagamento') IS NOT NULL
    BEGIN
        DROP TABLE tb_forma_de_pagamento;
    END;
GO

IF OBJECT_ID('log_produto_preco_historico') IS NOT NULL
    BEGIN
        DROP TABLE log_produto_preco_historico;
    END;
GO

IF OBJECT_ID('log_produto_inativos') IS NOT NULL
    BEGIN
        DROP TABLE log_produto_inativos;
    END;
GO

IF OBJECT_ID('tb_produto') IS NOT NULL
    BEGIN
        DROP TABLE tb_produto;
    END;
GO

IF OBJECT_ID('tb_endereco') IS NOT NULL
    BEGIN
        DROP TABLE tb_endereco;
    END;
GO

IF OBJECT_ID('tb_usuario') IS NOT NULL
    BEGIN
        DROP TABLE tb_usuario;
    END;
GO

IF OBJECT_ID('tb_transportadora') IS NOT NULL
    BEGIN
        DROP TABLE tb_transportadora;
    END;
GO

IF OBJECT_ID('tb_administrador') IS NOT NULL
    BEGIN
        DROP TABLE tb_administrador;
    END;
GO

-- Exclui o banco de dados
DROP SCHEMA IF EXISTS db_papelaria_livraria;
GO

-- Cria o banco de dados se ele não existir
IF NOT EXISTS (SELECT name
               FROM sys.databases
               WHERE name = N'db_papelaria_livraria')
    BEGIN
        CREATE DATABASE db_papelaria_livraria;
    END;
GO

-- Usa o banco de dados
USE db_papelaria_livraria;
GO

-- Tabela para armazenar os Administradores
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_administrador]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_administrador
        (
            id                   BIGINT IDENTITY (1,1),
            nome                 VARCHAR(100) NOT NULL,
            email                VARCHAR(100) NOT NULL,
            senha                VARCHAR(100),
            email_de_recuperacao VARCHAR(100) NULL,

            CONSTRAINT UQ_tb_administrador_email UNIQUE (email),

            CONSTRAINT PK_tb_administrador PRIMARY KEY (id)
        );
    END;
GO

-- Tabela para armazenar as Transportadoras
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_transportadora]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_transportadora
        (
            id                 BIGINT IDENTITY (1,1),
            nome               VARCHAR(100)   NOT NULL,
            cnpj               VARCHAR(20)    NOT NULL,
            inscricao_estadual VARCHAR(100)   NOT NULL,
            telefone           VARCHAR(20)    NOT NULL,
            email              VARCHAR(100)   NOT NULL,
            preco_km           DECIMAL(10, 2) NULL,
            endereco           VARCHAR(100)   NULL,

            CONSTRAINT UQ_tb_transportadora_cnpj UNIQUE (cnpj),
            CONSTRAINT UQ_tb_transportadora_inscricao_estadual UNIQUE (inscricao_estadual),
            CONSTRAINT UQ_tb_transportadora_email UNIQUE (email),

            CONSTRAINT PK_tb_transportadora PRIMARY KEY (id)
        );
    END;
GO

-- Tabela para armazenar os Usuários
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_usuario]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_usuario
        (
            id                   BIGINT IDENTITY (1,1),
            nome                 VARCHAR(100),
            cpf                  VARCHAR(20),
            telefone             VARCHAR(20),
            email                VARCHAR(100),
            senha                VARCHAR(100),
            email_de_recuperacao VARCHAR(100) NULL,
            saldo                DECIMAL(10, 2) DEFAULT 0,

            CONSTRAINT UQ_tb_usuario_cpf UNIQUE (cpf),
            CONSTRAINT UQ_tb_usuario_email UNIQUE (email),

            CONSTRAINT PK_tb_usuario PRIMARY KEY (id)
        );
    END;
GO

-- Tabela para armazenar as formas de pagamento
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_forma_de_pagamento]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_forma_de_pagamento
        (
            id         BIGINT IDENTITY (1,1),
            id_usuario BIGINT NOT NULL,

            CONSTRAINT PK_tb_forma_de_pagamento PRIMARY KEY (id),
            CONSTRAINT FK_tb_forma_de_pagamento_tb_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
        );
    END;
GO

-- Tabela para armazenar detalhes específicos do PIX
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_pix]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_pix
        (
            id_forma_pgto BIGINT       NOT NULL,
            chave         VARCHAR(100) NOT NULL,

            CONSTRAINT PK_tb_pix PRIMARY KEY (id_forma_pgto),
            CONSTRAINT FK_tb_pix_tb_forma_de_pagamento FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
        );
    END;
GO

-- Tabela para armazenar detalhes específicos do Cartão de Crédito
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_cartao]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_cartao
        (
            id_forma_pgto    BIGINT                                           NOT NULL,
            numero           VARCHAR(20)                                      NOT NULL,
            validade         DATE                                             NOT NULL,
            codigo_seguranca VARCHAR(10)                                      NOT NULL,
            nome_dono        VARCHAR(100)                                     NOT NULL,
            tipo             VARCHAR(6) CHECK (tipo IN ('DEBITO', 'CREDITO')) NOT NULL,

            CONSTRAINT PK_tb_cartao PRIMARY KEY (id_forma_pgto),
            CONSTRAINT FK_tb_cartao_tb_forma_de_pagamento FOREIGN KEY (id_forma_pgto) REFERENCES tb_forma_de_pagamento (id)
        );
    END;
GO

-- Tabela para armazenar os Endereços dos Usuários
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_endereco]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_endereco
        (
            id           BIGINT IDENTITY (1,1),
            id_usuario   BIGINT      NOT NULL,
            rua          VARCHAR(100),
            numero       VARCHAR(8),
            bairro       VARCHAR(100),
            cidade       VARCHAR(100),
            estado       VARCHAR(100),
            cep          VARCHAR(20),
            complemento  VARCHAR(50) NULL,
            is_principal BIT DEFAULT 0,

            CONSTRAINT PK_tb_endereco PRIMARY KEY (id),

            CONSTRAINT FK_tb_endereco_tb_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
        );
    END;
GO

-- Tabela para armazenar os Produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_produto]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_produto
        (
            id         BIGINT IDENTITY (1,1),
            nome       VARCHAR(50)    NOT NULL,
            preco      DECIMAL(10, 2) NOT NULL,
            descricao  varchar(max)   NULL,
            is_ativo   BIT                                     DEFAULT 1,
            created_at DATETIME2 GENERATED ALWAYS AS ROW START DEFAULT SYSUTCDATETIME(),
            updated_at DATETIME2 GENERATED ALWAYS AS ROW END   DEFAULT SYSUTCDATETIME(),

            PERIOD FOR SYSTEM_TIME (created_at, updated_at),

            CONSTRAINT PK_tb_produto PRIMARY KEY (id)
        );
    END;
GO

-- Tabela para registrar o histórico de preços dos produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[log_produto_preco_historico]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE log_produto_preco_historico
        (
            id             BIGINT IDENTITY (1,1),
            id_produto     BIGINT         NOT NULL,
            preco_anterior DECIMAL(10, 2) NOT NULL,
            preco_novo     DECIMAL(10, 2) NOT NULL,
            data_alteracao DATETIME2 DEFAULT SYSUTCDATETIME(),

            CONSTRAINT PK_log_produto_preco_historico PRIMARY KEY (id),
            CONSTRAINT FK_log_produto_preco_historico_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
        );
    END;
GO

-- Tabela para armazenar os produtos excluídos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[log_produto_inativos]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE log_produto_inativos
        (
            id              BIGINT IDENTITY (1,1),
            id_produto      BIGINT         NOT NULL,
            nome            VARCHAR(255)   NOT NULL,
            preco           DECIMAL(10, 2) NOT NULL,
            data_inativacao DATETIME       NOT NULL,
            data_reativacao DATETIME,

            CONSTRAINT PK_log_produto_inativos PRIMARY KEY (id)
        );
    END;
GO

-- Tabela para armazenar o Estoque dos Produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_estoque]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_estoque
        (
            id          BIGINT IDENTITY (1,1),
            id_produto  BIGINT      NOT NULL,
            quantidade  INT         NOT NULL,
            localizacao VARCHAR(70) NULL,
            created_at  DATETIME2 DEFAULT SYSUTCDATETIME(),
            updated_at  DATETIME2 DEFAULT SYSUTCDATETIME(),

            CONSTRAINT PK_tb_estoque PRIMARY KEY (id),
            CONSTRAINT FK_tb_estoque_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
        );
    END;
GO

-- Tabela para armazenar as Categorias
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_categoria]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_categoria
        (
            id   BIGINT IDENTITY (1,1),
            nome VARCHAR(50) NOT NULL,

            CONSTRAINT PK_tb_categoria PRIMARY KEY (id)
        );
    END;
GO

-- Tabela de associação N:N entre Produtos e Categorias
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_produto_categoria]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_produto_categoria
        (
            id_produto   BIGINT NOT NULL,
            id_categoria BIGINT NOT NULL,

            CONSTRAINT FK_tb_produto_categoria_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
            CONSTRAINT FK_tb_produto_categoria_tb_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)
        );
    END;
GO

-- Tabela para armazenar as Avaliações dos Produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_lista_desejos]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_lista_desejos
        (
            id         BIGINT IDENTITY (1,1),
            id_usuario BIGINT NOT NULL,

            CONSTRAINT PK_tb_lista_desejos PRIMARY KEY (id),
            CONSTRAINT FK_tb_lista_desejos_tb_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
        );
    END;
GO

-- Tabela de associação N:N entre Listas de Desejos e Produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_lista_desejos_produto]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_lista_desejos_produto
        (
            id_produto       BIGINT NOT NULL,
            id_lista_desejos BIGINT NOT NULL,

            CONSTRAINT FK_tb_lista_desejos_produto_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
            CONSTRAINT FK_tb_lista_desejos_produto_tb_lista_desejos FOREIGN KEY (id_lista_desejos) REFERENCES tb_lista_desejos (id)
        );
    END;
GO

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_carrinho]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_carrinho
        (
            id         BIGINT IDENTITY (1,1),
            id_usuario BIGINT NOT NULL,

            CONSTRAINT PK_tb_carrinho PRIMARY KEY (id),

            CONSTRAINT FK_tb_carrinho_tb_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id)
        );
    END;
GO

-- Tabela de associação N:N entre Carrinhos e Produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_carrinho_produto]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_carrinho_produto
        (
            id_produto  BIGINT NOT NULL,
            id_carrinho BIGINT NOT NULL,
            quantidade  INT    NOT NULL,

            CONSTRAINT FK_tb_carrinho_produto_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
            CONSTRAINT FK_tb_carrinho_produto_tb_carrinho FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id)
        );
    END;
GO

-- Tabela para armazenar as Compras
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_compra]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_compra
        (
            id             BIGINT IDENTITY (1,1),
            id_usuario     BIGINT   NOT NULL,
            id_endereco    BIGINT   NOT NULL,
            data_realizada DATETIME NOT NULL,
            preco_total    DECIMAL(10, 2) DEFAULT 0,
            created_at     DATETIME2      DEFAULT SYSUTCDATETIME(),
            updated_at     DATETIME2      DEFAULT SYSUTCDATETIME(),

            CONSTRAINT PK_tb_compra PRIMARY KEY (id),

            CONSTRAINT FK_tb_compra_tb_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id),
            CONSTRAINT FK_tb_compra_tb_endereco FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
        );
    END;
GO

-- tabela para armazenar os produtos comprados em cada compra, além de suas opcionais avaliações
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_compra_produto]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_compra_produto
        (
            id         BIGINT IDENTITY (1,1),
            id_compra  BIGINT         NOT NULL,
            id_produto BIGINT         NOT NULL,
            quantidade BIGINT         NOT NULL,
            preco_unit DECIMAL(10, 2) NOT NULL,

            CONSTRAINT UQ_tb_compra_produto UNIQUE (id_compra, id_produto),
            CONSTRAINT PK_tb_compra_produto PRIMARY KEY (id),

            CONSTRAINT FK_tb_compra_produto_tb_compra FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
            CONSTRAINT FK_tb_compra_produto_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
        );
    END;
GO

-- Tabela para armazenar as avaliações dos produtos comprados
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_avaliacao]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_avaliacao
        (
            id                BIGINT IDENTITY (1,1),
            id_compra_produto BIGINT                                                                                                             NOT NULL,

            avaliacao         VARCHAR(10) COLLATE Latin1_General_100_CI_AS_SC_UTF8 CHECK (avaliacao IN (N'⭐', N'⭐⭐', N'⭐⭐⭐', N'⭐⭐⭐⭐', N'⭐⭐⭐⭐⭐')) NULL, -- Avaliação com emojis de estrelas (opcional)
            comentario        VARCHAR(MAX) COLLATE Latin1_General_100_CI_AS_SC_UTF8                                                              NULL, -- Comentário (opcional),
            created_at        DATETIME2 DEFAULT SYSUTCDATETIME(),
            updated_at        DATETIME2 DEFAULT SYSUTCDATETIME(),

            CONSTRAINT PK_tb_avaliacao PRIMARY KEY (id),
            CONSTRAINT FK_tb_avaliacao_tb_compra_produto FOREIGN KEY (id_compra_produto) REFERENCES tb_compra_produto (id)
        );
    END;
GO
-- Tabela de rastreamento de compras, com relação 1:1 com tb_compras
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_entrega]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_entrega
        (
            id                BIGINT IDENTITY (1,1),
            id_compra         BIGINT                                                                                       NOT NULL,
            id_transportadora BIGINT                                                                                       NOT NULL,
            codigo_rastreio   VARCHAR(100)                                                                                 NULL,
            data_envio        DATETIME                                                                                     NULL,
            data_recebimento  DATETIME                                                                                     NULL,
            status_entrega    VARCHAR(12) CHECK (status_entrega IN ('ENVIADO', 'EM_TRANSITO', 'ENTREGUE', 'NAO_ENTREGUE')) NULL,
            created_at        DATETIME2 DEFAULT SYSUTCDATETIME(),
            updated_at        DATETIME2 DEFAULT SYSUTCDATETIME(),

            CONSTRAINT PK_tb_entrega PRIMARY KEY (id),
            CONSTRAINT UQ_tb_entrega_id_compra UNIQUE (id_compra), -- Garante que cada compra tenha apenas uma entrega

            CONSTRAINT FK_tb_entrega_tb_compra FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
            CONSTRAINT FK_tb_entrega_tb_transportadora FOREIGN KEY (id_transportadora) REFERENCES tb_transportadora (id)
        );
    END;
GO

-- Definição: uma promoção é um desconto aplicado a UM ou MAIS PRODUTOS
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_promocao]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_promocao
        (
            id          BIGINT IDENTITY (1,1),
            nome        VARCHAR(100)   NULL,
            desconto    DECIMAL(10, 2) NOT NULL, -- Desconto da promoção
            data_inicio DATETIME       NOT NULL,
            data_fim    DATETIME       NOT NULL,

            CONSTRAINT PK_tb_promocao PRIMARY KEY (id)
        );
    END;
GO

-- A promoção pode estar em vários produtos
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_promocao_produto]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_promocao_produto
        (
            id_produto  BIGINT NOT NULL,
            id_promocao BIGINT NOT NULL,

            CONSTRAINT PK_tb_promocao_produto PRIMARY KEY (id_produto, id_promocao), -- Garante que um produto participe de uma promoção apenas uma vez

            CONSTRAINT FK_tb_promocao_produto_tb_produto FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
            CONSTRAINT FK_tb_promocao_produto_tb_promocao FOREIGN KEY (id_promocao) REFERENCES tb_promocao (id)
        );
    END;
GO

-- Definição: um cupom é um desconto aplicado a uma COMPRA
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_cupom]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_cupom
        (
            id          BIGINT IDENTITY (1,1),
            nome        VARCHAR(100)   NULL,
            desconto    DECIMAL(10, 2) NOT NULL,
            data_inicio DATETIME       NOT NULL,
            data_fim    DATETIME       NOT NULL,

            CONSTRAINT PK_tb_cupom PRIMARY KEY (id)
        );
    END;
GO

-- Um cupom pode ser aplicado a várias compras e uma compra pode ter vários cupons
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[dbo].[tb_cupom_compra]')
                 AND type in (N'U'))
    BEGIN
        CREATE TABLE tb_cupom_compra
        (
            id_compra BIGINT NOT NULL,
            id_cupom  BIGINT NOT NULL,

            CONSTRAINT FK_tb_cupom_compra_tb_compra FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
            CONSTRAINT FK_tb_cupom_compra_tb_cupom FOREIGN KEY (id_cupom) REFERENCES tb_cupom (id)
        );
    END;
GO

-- Habilita a verificação de chaves estrangeiras novamente
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';
GO
