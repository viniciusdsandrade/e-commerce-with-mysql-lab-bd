-- Remove o banco de dados existente, se houver
DROP DATABASE IF EXISTS db_papelaria_livraria;

-- Cria o banco de dados caso não exista
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;

-- Seleciona o banco de dados para uso
USE db_papelaria_livraria;

-- Tabela de Acessos (Roles) com permissões específicas
CREATE TABLE IF NOT EXISTS tb_acesso
(
    id                          BIGINT UNSIGNED AUTO_INCREMENT,
    nome                        VARCHAR(100) NOT NULL, -- Ex: 'ADMINISTRADOR', 'GERENTE', 'SUPORTE'
    pode_banir_usuario          BOOLEAN DEFAULT FALSE,
    pode_conversar_com_usuario  BOOLEAN DEFAULT FALSE,
    pode_visualizar_categorias  BOOLEAN DEFAULT FALSE,
    pode_criar_categorias       BOOLEAN DEFAULT FALSE,
    pode_editar_categorias      BOOLEAN DEFAULT FALSE,
    pode_remover_categorias     BOOLEAN DEFAULT FALSE,
    pode_visualizar_produtos    BOOLEAN DEFAULT FALSE,
    pode_criar_produtos         BOOLEAN DEFAULT FALSE,
    pode_editar_produtos        BOOLEAN DEFAULT FALSE,
    pode_remover_produtos       BOOLEAN DEFAULT FALSE,
    pode_visualizar_estoques    BOOLEAN DEFAULT FALSE,
    pode_criar_estoques         BOOLEAN DEFAULT FALSE,
    pode_editar_estoques        BOOLEAN DEFAULT FALSE,
    pode_remover_estoques       BOOLEAN DEFAULT FALSE,
    pode_visualizar_promocoes   BOOLEAN DEFAULT FALSE,
    pode_criar_promocoes        BOOLEAN DEFAULT FALSE,
    pode_editar_promocoes       BOOLEAN DEFAULT FALSE,
    pode_remover_promocoes      BOOLEAN DEFAULT FALSE,
    pode_criar_transportadora   BOOLEAN DEFAULT FALSE,
    pode_editar_transportadora  BOOLEAN DEFAULT FALSE,
    pode_remover_transportadora BOOLEAN DEFAULT FALSE,
    pode_visualizar_avaliacoes  BOOLEAN DEFAULT FALSE,
    pode_remover_avaliacoes     BOOLEAN DEFAULT FALSE,
    pode_visualizar_cupons      BOOLEAN DEFAULT FALSE,
    pode_criar_cupons           BOOLEAN DEFAULT FALSE,
    pode_editar_cupons          BOOLEAN DEFAULT FALSE,
    pode_remover_cupons         BOOLEAN DEFAULT FALSE,

    UNIQUE (nome),                                     -- Cada papel tem um nome único
    PRIMARY KEY (id)
);

-- Tabela base para armazenar informações comuns de Pessoas (Funcionários e Usuários)
CREATE TABLE IF NOT EXISTS tb_pessoa
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    nome              VARCHAR(100) NOT NULL, -- Nome da pessoa
    data_nascimento   DATE         NULL,     -- Data de nascimento
    cpf               VARCHAR(20)  NOT NULL, -- CPF único
    email             VARCHAR(100) NOT NULL, -- E-mail único
    senha             VARCHAR(255) NOT NULL, -- Senha
    telefone          VARCHAR(20)  NULL,     -- Telefone
    email_recuperacao VARCHAR(100) NULL,     -- E-mail de recuperação

    UNIQUE (cpf),                            -- CPF deve ser único
    UNIQUE (email),                          -- E-mail deve ser único

    PRIMARY KEY (id)
);

-- Tabela para armazenar dados específicos de Funcionários
CREATE TABLE IF NOT EXISTS tb_funcionario
(
    id_pessoa BIGINT UNSIGNED NOT NULL,                -- FK para tb_pessoa
    id_acesso BIGINT UNSIGNED NOT NULL,                -- Nível de acesso

    PRIMARY KEY (id_pessoa),                           -- PK baseada em tb_pessoa
    FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa (id), -- FK para Pessoa
    FOREIGN KEY (id_acesso) REFERENCES tb_acesso (id)  -- FK para Acesso
);

-- Tabela para armazenar dados específicos de Usuários
CREATE TABLE IF NOT EXISTS tb_usuario
(
    id_pessoa            BIGINT UNSIGNED NOT NULL,                 -- FK para tb_pessoa
    saldo                DECIMAL(10, 2)           DEFAULT 0,       -- Saldo do usuário
    estado               ENUM (
        'AGUARDANDO_VERIFICACAO',
        'ATIVO',
        'SUSPENSO',
        'BANIDO'
        )                                NOT NULL DEFAULT 'ATIVO', -- Estado do usuário
    data_final_suspensao DATETIME        NULL,                     -- Fim da suspensão

    PRIMARY KEY (id_pessoa),                                       -- PK baseada em tb_pessoa
    FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa (id)              -- FK para Pessoa
);

-- Tabela para armazenar Transportadoras
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

-- Tabela para armazenar Chamados de Suporte
CREATE TABLE IF NOT EXISTS tb_chamado
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario       BIGINT UNSIGNED                                           NOT NULL, -- FK para Usuário
    id_funcionario   BIGINT UNSIGNED                                           NOT NULL, -- FK para Funcionário
    titulo           VARCHAR(50)                                               NOT NULL,
    descricao        TEXT                                                      NOT NULL,
    estado           ENUM ('ABERTO', 'EM_ANDAMENTO', 'RESOLVIDO', 'CANCELADO') NOT NULL DEFAULT 'ABERTO',
    data_criacao     DATETIME                                                  NOT NULL,
    data_finalizacao DATETIME                                                  NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa),                          -- Relaciona ao Usuário
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario (id_pessoa)                   -- Relaciona ao Funcionário
);

-- Tabela para registrar Mensagens em Chamados
CREATE TABLE IF NOT EXISTS tb_mensagem
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_chamado   BIGINT UNSIGNED NOT NULL,               -- FK para Chamado
    id_remetente BIGINT UNSIGNED NOT NULL,               -- FK para Pessoa
    texto        TEXT            NOT NULL,               -- Conteúdo da mensagem
    data_envio   DATETIME        NOT NULL,               -- Data e hora do envio

    PRIMARY KEY (id),
    FOREIGN KEY (id_chamado) REFERENCES tb_chamado (id), -- Relaciona ao Chamado
    FOREIGN KEY (id_remetente) REFERENCES tb_pessoa (id) -- Relaciona ao Remetente
);

-- Tabela para armazenar Formas de Pagamento dos Usuários
CREATE TABLE IF NOT EXISTS tb_forma_pagamento
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
);

-- Tabela para armazenar detalhes do PIX
CREATE TABLE IF NOT EXISTS tb_pix
(
    id_forma_pagamento BIGINT UNSIGNED NOT NULL,
    chave              VARCHAR(100)    NOT NULL,

    PRIMARY KEY (id_forma_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_forma_pagamento (id)
);

-- Tabela para armazenar detalhes de Cartão de Crédito
CREATE TABLE IF NOT EXISTS tb_cartao
(
    id_forma_pagamento BIGINT UNSIGNED            NOT NULL,
    numero             VARCHAR(20)                NOT NULL,
    validade           DATE                       NOT NULL,
    codigo_seguranca   VARCHAR(10)                NOT NULL,
    nome_dono          VARCHAR(100)               NOT NULL,
    tipo               ENUM ('DEBITO', 'CREDITO') NOT NULL,

    PRIMARY KEY (id_forma_pagamento),
    FOREIGN KEY (id_forma_pagamento) REFERENCES tb_forma_pagamento (id)
);

-- Tabela para armazenar Endereços dos Usuários
CREATE TABLE IF NOT EXISTS tb_endereco
(
    id           BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario   BIGINT UNSIGNED NOT NULL,
    nome         VARCHAR(30)     NULL,
    rua          VARCHAR(100)    NULL,
    numero       VARCHAR(8)      NULL,
    bairro       VARCHAR(100)    NULL,
    cidade       VARCHAR(100)    NULL,
    estado       VARCHAR(100)    NULL,
    cep          VARCHAR(20)     NULL,
    complemento  VARCHAR(50)     NULL,
    is_principal BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
);

-- Tabela para armazenar Produtos
CREATE TABLE IF NOT EXISTS tb_produto
(
    id        BIGINT UNSIGNED AUTO_INCREMENT,
    nome      VARCHAR(50)    NOT NULL,
    preco     DECIMAL(10, 2) NOT NULL,
    descricao TEXT           NULL,
    is_ativo  BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (id)
);

-- Tabela para armazenar Estoque dos Produtos
CREATE TABLE IF NOT EXISTS tb_estoque
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    id_produto  BIGINT UNSIGNED    NOT NULL,
    quantidade  MEDIUMINT UNSIGNED NOT NULL,
    localizacao VARCHAR(70)        NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id)
);

-- Tabela para armazenar Categorias de Produtos
CREATE TABLE IF NOT EXISTS tb_categoria
(
    id   BIGINT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de Associação N:N entre Produtos e Categorias
CREATE TABLE IF NOT EXISTS tb_produto_categoria
(
    id_produto   BIGINT UNSIGNED NOT NULL,
    id_categoria BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)
);

-- Tabela para armazenar Listas de Desejos dos Usuários
CREATE TABLE IF NOT EXISTS tb_lista_desejos
(
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
);

-- Tabela de Associação N:N entre Listas de Desejos e Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejos_produto
(
    id_produto       BIGINT UNSIGNED NOT NULL,
    id_lista_desejos BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_lista_desejos) REFERENCES tb_lista_desejos (id_usuario)
);

-- Tabela para armazenar Carrinhos de Compras dos Usuários
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_usuario),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
);

-- Tabela de Associação N:N entre Carrinhos e Produtos
CREATE TABLE IF NOT EXISTS tb_carrinho_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_carrinho BIGINT UNSIGNED NOT NULL,
    quantidade  INT UNSIGNED    NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho (id_usuario)
);

-- Tabela para armazenar Compras realizadas pelos Usuários
CREATE TABLE IF NOT EXISTS tb_compra
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario     BIGINT UNSIGNED NOT NULL,
    id_endereco    BIGINT UNSIGNED NOT NULL,
    data_realizada DATETIME        NOT NULL,

    PRIMARY KEY (id),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa),
    FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
);

-- Tabela para armazenar Produtos comprados em cada Compra
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

-- Tabela para armazenar Avaliações dos Produtos Comprados
CREATE TABLE IF NOT EXISTS tb_avaliacao
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    id_compra_produto BIGINT UNSIGNED                NOT NULL,

    nota              ENUM (
        '⭐',
        '⭐⭐',
        '⭐⭐⭐',
        '⭐⭐⭐⭐',
        '⭐⭐⭐⭐⭐'
        ) CHARACTER SET utf8mb4
                          COLLATE utf8mb4_unicode_ci NULL, -- Avaliação com emojis de estrelas
    comentario        TEXT                           NULL, -- Comentário opcional

    PRIMARY KEY (id),
    FOREIGN KEY (id_compra_produto) REFERENCES tb_compra_produto (id)
);

-- Tabela de Rastreamento de Entregas das Compras
CREATE TABLE IF NOT EXISTS tb_entrega
(
    id_compra_produto       BIGINT UNSIGNED NOT NULL,
    id_transportadora       BIGINT UNSIGNED NOT NULL,
    codigo_rastreio         VARCHAR(100)    NULL,
    data_postado            DATETIME        NULL,
    data_transito           DATETIME        NULL,
    data_recebido           DATETIME        NULL,
    data_devolucao_transito DATETIME        NULL,
    data_devolucao_recebido DATETIME        NULL,
    estado                  ENUM (
        'AGUARDANDO_PAGAMENTO_COMPRA',
        'EM_PREPARO',
        'POSTADO',
        'EM_TRANSITO',
        'ENTREGUE',
        'NAO_ENTREGUE',
        'D_AGUARDANDO_TRANSPORTADORA',
        'D_EM_TRANSITO',
        'DEVOLVIDO'
        )                                   NULL,
    finalizada              BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (id_compra_produto),
    FOREIGN KEY (id_compra_produto) REFERENCES tb_compra_produto (id),
    FOREIGN KEY (id_transportadora) REFERENCES tb_transportadora (id)
);

-- Tabela para armazenar Promoções
CREATE TABLE IF NOT EXISTS tb_promocao
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100) NULL,
    data_inicio DATETIME     NOT NULL,
    data_fim    DATETIME     NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de Associação N:N entre Promoções e Produtos
CREATE TABLE IF NOT EXISTS tb_promocao_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_promocao BIGINT UNSIGNED NOT NULL,
    desconto    DECIMAL(10, 2)  NOT NULL,  -- Desconto aplicado na promoção

    PRIMARY KEY (id_produto, id_promocao), -- Garante unicidade na associação
    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocao (id)
);

-- Tabela para armazenar Cupons de Desconto
CREATE TABLE IF NOT EXISTS tb_cupom
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de Associação N:N entre Cupons e Compras
CREATE TABLE IF NOT EXISTS tb_cupom_compra
(
    id_compra BIGINT UNSIGNED NOT NULL,
    id_cupom  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupom (id)
);
