DROP DATABASE IF EXISTS db_papelaria_livraria;
CREATE DATABASE IF NOT EXISTS db_papelaria_livraria;
USE db_papelaria_livraria;

-- Tabela de Papéis (Roles)
CREATE TABLE IF NOT EXISTS tb_funcao
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    nome       VARCHAR(100) NOT NULL, -- Ex: 'ADMINISTRADOR', 'GERENTE', 'SUPORTE'
    descricao  TEXT         NULL,     -- Descrição opcional do papel
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE (nome),                    -- Cada papel tem um nome único
    PRIMARY KEY (id)
);

-- Tabela de Permissões (Permissions)
CREATE TABLE IF NOT EXISTS tb_permissao
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,

    -- O campo nome agora é um ENUM com todas as permissões
    nome       ENUM (
        'BANIR_USUARIO',
        'CONVERSAR_COM_USUARIO',
        'VISUALIZAR_CATEGORIAS',
        'CRIAR_CATEGORIAS',
        'EDITAR_CATEGORIAS',
        'REMOVER_CATEGORIAS',
        'VISUALIZAR_PRODUTOS',
        'CRIAR_PRODUTOS',
        'EDITAR_PRODUTOS',
        'REMOVER_PRODUTOS',
        'VISUALIZAR_ESTOQUES',
        'CRIAR_ESTOQUES',
        'EDITAR_ESTOQUES',
        'REMOVER_ESTOQUES',
        'VISUALIZAR_PROMOCOES',
        'CRIAR_PROMOCOES',
        'EDITAR_PROMOCOES',
        'REMOVER_PROMOCOES',
        'CRIAR_TRANSPORTADORA',
        'EDITAR_TRANSPORTADORA',
        'REMOVER_TRANSPORTADORA',
        'VISUALIZAR_AVALIACOES',
        'REMOVER_AVALIACOES',
        'VISUALIZAR_CUPONS',
        'CRIAR_CUPONS',
        'EDITAR_CUPONS',
        'REMOVER_CUPONS'
        )           NOT NULL, -- Lista de permissões

    descricao  TEXT NULL,     -- Descrição opcional da permissão
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

-- Tabela de Associação entre Papéis e Permissões
CREATE TABLE IF NOT EXISTS tb_permissao_funcao
(
    id_role      BIGINT UNSIGNED NOT NULL, -- Referência para a tabela de roles
    id_permissao BIGINT UNSIGNED NOT NULL, -- Referência para a tabela de permissões
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_role, id_permissao),   -- Chave composta para garantir unicidade
    FOREIGN KEY (id_role) REFERENCES tb_funcao (id) ON DELETE CASCADE,
    FOREIGN KEY (id_permissao) REFERENCES tb_permissao (id) ON DELETE CASCADE
);

-- Tabela base para armazenar os campos comuns entre Funcionários e Usuários
CREATE TABLE IF NOT EXISTS tb_pessoa
(
    id              BIGINT UNSIGNED AUTO_INCREMENT,
    nome            VARCHAR(100) NOT NULL, -- Nome da pessoa
    data_nascimento DATE         NULL,     -- Data de nascimento comum
    cpf             VARCHAR(20)  NOT NULL, -- CPF único para ambas as tabelas
    email           VARCHAR(100) NOT NULL, -- E-mail comum
    senha_hash      VARCHAR(255) NOT NULL, -- Senha comum
    salt            VARCHAR(255) NOT NULL, -- Salt para segurança
    telefone        VARCHAR(20)  NULL,     -- Telefone comum
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE (cpf),                          -- CPF deve ser único
    UNIQUE (email),                        -- E-mail deve ser único
    UNIQUE (salt),                         -- Salt também deve ser único para garantir segurança

    PRIMARY KEY (id)
);

-- Tabela para armazenar os dados específicos de Funcionários, referenciando tb_pessoa
CREATE TABLE IF NOT EXISTS tb_funcionario
(
    id_pessoa         BIGINT UNSIGNED NOT NULL,                              -- FK para tb_pessoa
    email_recuperacao VARCHAR(100)    NULL,                                  -- E-mail de recuperação, específico de funcionários
    id_nivel_acesso   BIGINT UNSIGNED NOT NULL,                              -- Nível de acesso para funcionários

    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id_pessoa),                                                 -- Usa a PK da tabela pessoa como PK
    FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa (id) ON DELETE CASCADE,     -- FK para a tabela pessoa
    FOREIGN KEY (id_nivel_acesso) REFERENCES tb_funcao (id) ON DELETE RESTRICT -- Nível de acesso referenciado na tb_role
);

-- Tabela para armazenar os dados específicos de Usuários, referenciando tb_pessoa
CREATE TABLE IF NOT EXISTS tb_usuario
(
    id_pessoa            BIGINT UNSIGNED NOT NULL,                      -- FK para tb_pessoa
    saldo                DECIMAL(10, 2)           DEFAULT 0,            -- Saldo associado ao usuário
    estado               ENUM (
        'ATIVO',
        'SUSPENSO',
        'BANIDO',
        'AGUARDANDO_VERIFICACAO'
        )                                NOT NULL DEFAULT 'ATIVO',      -- Estado do usuário
    data_final_suspensao DATETIME        NULL,                          -- Data de término de suspensão, se houver

    created_at           TIMESTAMP                DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id_pessoa),                                            -- Usa a PK da tabela pessoa como PK
    FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa (id) ON DELETE CASCADE -- FK para a tabela pessoa
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

-- Tabela de Associação entre Usuários e Papéis
CREATE TABLE IF NOT EXISTS tb_permissao_usuario
(
    id_usuario BIGINT UNSIGNED NOT NULL, -- Referência para a tabela de usuários
    id_role    BIGINT UNSIGNED NOT NULL, -- Referência para a tabela de roles
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_usuario, id_role),   -- Chave composta para garantir unicidade
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa) ON DELETE CASCADE,
    FOREIGN KEY (id_role) REFERENCES tb_funcao (id) ON DELETE CASCADE
);

-- Atualizando a tabela de funcionários (sem necessidade de duplicação de dados)
CREATE TABLE IF NOT EXISTS tb_chamado
(
    id               BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario       BIGINT UNSIGNED                                         NOT NULL,   -- FK para a tabela de usuários
    id_funcionario   BIGINT UNSIGNED                                         NOT NULL,   -- FK para a tabela de funcionários
    status           ENUM ('ABERTO', 'EM_ANDAMENTO', 'RESOLVIDO', 'FECHADO') NOT NULL DEFAULT 'ABERTO',
    data_criacao     TIMESTAMP                                                        DEFAULT CURRENT_TIMESTAMP,
    data_finalizacao TIMESTAMP                                               NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa) ON DELETE CASCADE,        -- Relaciona o usuário
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario (id_pessoa) ON DELETE CASCADE -- Relaciona o funcionário
);
-- Tabela para registrar mensagens em chamados
CREATE TABLE IF NOT EXISTS tb_mensagens_chamado
(
    id             BIGINT UNSIGNED AUTO_INCREMENT,
    id_chamado     BIGINT UNSIGNED NOT NULL,                                      -- Relaciona à tabela de chamado
    id_usuario     BIGINT UNSIGNED NOT NULL,                                      -- Usuário que está enviando a mensagem
    id_funcionario BIGINT UNSIGNED NOT NULL,                                      -- Funcionário que está enviando a mensagem
    mensagem       TEXT            NOT NULL,                                      -- A mensagem trocada
    data_envio     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                           -- Data e hora em que a mensagem foi enviada
    PRIMARY KEY (id),

    -- Chaves estrangeiras
    FOREIGN KEY (id_chamado) REFERENCES tb_chamado (id) ON DELETE CASCADE,        -- Relaciona à tabela de chamado
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa) ON DELETE CASCADE,        -- Usuário relacionado à mensagem
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionario (id_pessoa) ON DELETE CASCADE -- Funcionário relacionado à mensagem
);

-- Tabela para armazenar log de acessos
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

    FOREIGN KEY (usuario_id) REFERENCES tb_usuario (id_pessoa) ON DELETE CASCADE
);

-- Tabela para armazenar formas de pagamento
CREATE TABLE IF NOT EXISTS tb_forma_de_pagamento
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
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

-- Tabela para armazenar endereços dos usuários
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

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
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
CREATE TABLE IF NOT EXISTS tb_lista_desejo
(
    id         BIGINT UNSIGNED AUTO_INCREMENT,
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
);

-- Tabela de associação N:N entre Listas de Desejos e Produtos
CREATE TABLE IF NOT EXISTS tb_lista_desejo_produto
(
    id_produto       BIGINT UNSIGNED NOT NULL,
    id_lista_desejo BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_lista_desejo) REFERENCES tb_lista_desejo (id)
);

-- Tabela para armazenar os Carrinhos de Compras de cada Usuário
CREATE TABLE IF NOT EXISTS tb_carrinho
(
    id_usuario BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_usuario),

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa)
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

    FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_pessoa),
    FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id)
);

-- Tabela para armazenar os produtos comprados em cada compra, além de suas opcionais avaliações
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

-- Tabela de Promoções
CREATE TABLE IF NOT EXISTS tb_promocao
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL, -- Desconto da promoção
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de associação N:N entre Promoções e Produtos
CREATE TABLE IF NOT EXISTS tb_promocao_produto
(
    id_produto  BIGINT UNSIGNED NOT NULL,
    id_promocao BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (id_produto, id_promocao), -- Garante que um produto participe de uma promoção apenas uma vez

    FOREIGN KEY (id_produto) REFERENCES tb_produto (id),
    FOREIGN KEY (id_promocao) REFERENCES tb_promocao (id)
);

-- Tabela de Cupons
CREATE TABLE IF NOT EXISTS tb_cupom
(
    id          BIGINT UNSIGNED AUTO_INCREMENT,
    nome        VARCHAR(100)   NULL,
    desconto    DECIMAL(10, 2) NOT NULL,
    data_inicio DATETIME       NOT NULL,
    data_fim    DATETIME       NOT NULL,

    PRIMARY KEY (id)
);

-- Tabela de associação N:N entre Cupons e Compras
CREATE TABLE IF NOT EXISTS tb_cupom_compra
(
    id_compra BIGINT UNSIGNED NOT NULL,
    id_cupom  BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (id_compra) REFERENCES tb_compra (id),
    FOREIGN KEY (id_cupom) REFERENCES tb_cupom (id)
);
