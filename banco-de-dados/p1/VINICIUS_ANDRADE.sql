# Exercício 1
# Qual a importância de se criar um banco de dados utilizando utf8mb4_unicode_ci ?

# Resposta:
# Usar utf8mb4_unicode_ci em um banco de dados é importante porque garante que você consiga armazenar todos os tipos de caracteres, incluindo emojis e símbolos especiais que não cabem na codificação utf8 comum.
# Além disso, ele lida melhor com diferentes idiomas, organizando corretamente as palavras de acordo com as regras de ordenação Unicode e sem se importar com maiúsculas ou minúsculas.
# Isso é especialmente útil em sistemas globais, onde você precisa garantir que tudo seja armazenado e comparado de forma correta, independente da língua ou dos símbolos usados.

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Exercício 2
# Crie uma tabela para armazenar informações de alunos. Inicialmente, a tabela deve conter as seguintes colunas:
# • id (inteiro, chave primária, auto_increment)
# • nome (texto, até 100 caracteres)
# 1. Escreva o comando SQL para criar a tabela alunos com essas especificações.
# Após a criação da tabela, foi solicitado que uma nova coluna chamada data_nascimento do tipo DATE fosse adicionada
# 2. Escreva o comando SQL para adicionar a coluna data_nascimento após a criação da tabela.
# 3. Explique brevemente o que cada comando faz.

# Resposta:
DROP DATABASE IF EXISTS db_escola;
CREATE DATABASE IF NOT EXISTS db_escola CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_escola;

CREATE TABLE IF NOT EXISTS tb_alunos
(
    id   INT AUTO_INCREMENT,
    nome VARCHAR(100),

    PRIMARY KEY (id)
);

ALTER TABLE tb_alunos
    ADD COLUMN data_nascimento DATE;

# O comando DROP DATABASE IF EXISTS db_escola; exclui o banco de dados db_escola, caso ele exista.
# O comando CREATE DATABASE IF NOT EXISTS db_escola CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; cria o banco de dados db_escola, caso ele não exista, com o conjunto de caracteres utf8mb4_unicode_ci.
# O comando USE db_escola; seleciona o banco de dados db_escola.
# O comando CREATE TABLE IF NOT EXISTS tb_alunos cria a tabela tb_alunos, caso ela não exista, com as colunas id e nome.
# O comando ALTER TABLE tb_alunos ADD COLUMN data_nascimento DATE; adiciona a coluna data_nascimento do tipo DATE à tabela tb_alunos.

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Exercício 3
# Seu gerente pediu um relatório com os produtos que:
#  contém maior estoque em seu depósito, e sua média de vendas no anual,
#  este relatório deve exibir o nome do produto, código do produto, quantidade em estoque e a média de vendas.
# a - Que comando SQL deveria ser utilizado para criar esta lista?
# b - Crie a tabela e um SQL que mostre a utilização deste comando.

# Resposta:

DROP DATABASE IF EXISTS db_estoque;
CREATE DATABASE IF NOT EXISTS db_estoque;
USE db_estoque;

-- Criação da tabela de produtos
CREATE TABLE IF NOT EXISTS tb_produtos
(
    id      INT AUTO_INCREMENT,
    nome    VARCHAR(100) NOT NULL,
    codigo  VARCHAR(10)  NOT NULL,
    estoque INT          NOT NULL,
    vendas  INT          NOT NULL, -- Considerando que esse é o total anual de vendas

    PRIMARY KEY (id)
);

-- Inserção de produtos na tabela
INSERT INTO tb_produtos (nome, codigo, estoque, vendas)
VALUES ('Produto A', 'A001', 100, 50),
       ('Produto B', 'B002', 200, 100),
       ('Produto C', 'C003', 300, 150),
       ('Produto D', 'D004', 400, 200);

-- Seleção dos produtos ordenados por maior estoque
-- Como a "média de vendas anual" não está detalhada, vamos assumir que já seja o valor de vendas inserido
SELECT nome, codigo, estoque, vendas AS media_vendas
FROM tb_produtos
ORDER BY estoque DESC;


-- Seleção dos produtos ordenados por maior estoque
-- Como a "média de vendas anual" não está detalhada, vamos assumir que já seja o valor de 'vendas' inserido
SELECT nome, codigo, estoque, vendas AS media_vendas
FROM tb_produtos
ORDER BY estoque DESC;

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Exercício 4
# Você foi contratado para um novo emprego como DBA, sua primeira tarefa será analisar todas as rotinas criadas pela equipe anterior,
# ao iniciar seu trabalho detectou-se a utilização excessiva do comando (SELECT *) para gerar os relatórios criados pela equipe.
# A - Qual seria sua avaliação sobre estes relatórios?
# B - O que deve ser feito?

# Resposta:

# A - Avaliação: Usar SELECT * em relatórios não é uma boa prática. Isso faz com que o banco de dados traga todas as colunas da tabela, mesmo aquelas que podem não ser necessárias para o relatório.
# Isso pode deixar as consultas mais lentas, especialmente se as tabelas forem grandes, e pode aumentar o consumo de recursos, tanto do banco quanto da rede, sem nenhum benefício claro.
# Além disso, usar SELECT * torna o código menos claro e mais difícil de manter, já que não sabemos exatamente quais colunas estão sendo usadas.

# B - Ação: Em vez de usar SELECT *, o ideal é selecionar apenas as colunas que realmente são necessárias para o relatório. Para isso, uma auditoria inicial das consultas deve ser feita,
# identificando quais colunas são realmente utilizadas nos relatórios e ajustando as consultas para selecionar apenas esses campos. Isso otimiza o desempenho das consultas e melhora a clareza do código.
# Além disso, revisar e refatorar essas consultas para incluir apenas os dados relevantes podem trazer benefícios de performance e facilitar a manutenção futura.

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Exercício 5
# Você está desenvolvendo um sistema para armazenar as reações dos usuários a uma pesquisa de satisfação. Cada usuário pode reagir com diferentes tipos de emojis. A tabela deve registrar as seguintes informações:
# • id (inteiro, chave primária, auto_incremento)
# • usuario_id (inteiro, identificando o usuário que fez a reação)
# • pesquisa_id (inteiro, identificando a pesquisa à qual a reação pertence)
# • tipo_reacao (varchar, podendo ser um dos seguintes valores: '😀', '😐', '😢')
# • data_reacao (TIMESTAMP, registrando a data e hora da reação, com o valor padrão sendo a data e hora atual)
# 1. Escreva o comando SQL para criar a tabela reações.
# 2. Inclua duas linhas a tabela
# 3. Explique brevemente o que cada parte do comando faz.

DROP DATABASE IF EXISTS db_pet_shop;
CREATE DATABASE IF NOT EXISTS db_pet_shop;
USE db_pet_shop;

-- Criação da tabela reações
CREATE TABLE IF NOT EXISTS reacoes
(
    id          INT AUTO_INCREMENT,
    usuario_id  INT NOT NULL,
    pesquisa_id INT NOT NULL,
    tipo_reacao VARCHAR(4) CHECK (tipo_reacao IN ('😀', '😐', '😢')),
    data_reacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Inserção de duas linhas na tabela reações
INSERT INTO reacoes (usuario_id, pesquisa_id, tipo_reacao)
VALUES (3, 1, '😢'),
       (1, 2, '😀');


# O comando DROP DATABASE IF EXISTS db_pet_shop; exclui o banco de dados db_pet_shop, caso ele exista.
# O comando CREATE DATABASE IF NOT EXISTS db_pet_shop; cria o banco de dados db_pet_shop, caso ele não exista.
# O comando USE db_pet_shop; seleciona o banco de dados db_pet_shop.
# O comando CREATE TABLE IF NOT EXISTS reacoes cria a tabela reacoes, caso ela não exista, com as colunas id, usuario_id, pesquisa_id, tipo_reacao e data_reacao.
# A coluna id é a chave primária da tabela, com auto_incremento.
# A coluna usuario_id armazena o identificador do usuário que fez a reação.
# A coluna pesquisa_id armazena o identificador da pesquisa à qual a reação pertence.
# A coluna tipo_reacao armazena o tipo de reação do usuário, sendo restrita aos valores '😀', '😐' e '😢'.
# A coluna data_reacao armazena a data e hora da reação, com o valor padrão sendo a data e hora atual.
# O comando INSERT INTO reacoes (usuario_id, pesquisa_id, tipo_reacao) insere duas linhas na tabela reacoes com os valores especificados para as colunas usuario_id, pesquisa_id e tipo_reacao.

# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Exercício 6
# Crie uma tabela que contenha o campo status que receba apenas os valores 'Pendente', 'Em Progresso' ou 'Concluída'. Qualquer outro valor seja considerado inválido pelo MySQL.
# a) A tabela criada deve conter os campos id, título, descrição, status, data criação.
# b) Adicione um campo prioridade onde so possa receber os valores predefinidos de 'Baixa', 'Média' e 'Alta'.
# c) Insira 3 linhas a esta tabela.

DROP DATABASE IF EXISTS db_tarefas;
CREATE DATABASE IF NOT EXISTS db_tarefas;
USE db_tarefas;

-- Criação da tabela tarefas
CREATE TABLE IF NOT EXISTS tarefas
(
    id           INT AUTO_INCREMENT,
    titulo       VARCHAR(100) NOT NULL,
    descricao    TEXT,
    status       VARCHAR(20) CHECK (status IN ('Pendente', 'Em Progresso', 'Concluída')),
    prioridade   VARCHAR(10) CHECK (prioridade IN ('Baixa', 'Média', 'Alta')),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Inserção de três linhas na tabela tarefas
INSERT INTO tarefas (titulo, descricao, status, prioridade)
VALUES ('Tarefa 1', 'Descrição da Tarefa 1', 'Pendente', 'Baixa'),
       ('Tarefa 2', 'Descrição da Tarefa 2', 'Em Progresso', 'Média'),
       ('Tarefa 3', 'Descrição da Tarefa 3', 'Concluída', 'Alta');

# O comando DROP DATABASE IF EXISTS db_tarefas; exclui o banco de dados db_tarefas, caso ele exista.
# O comando CREATE DATABASE IF NOT EXISTS db_tarefas; cria o banco de dados db_tarefas, caso ele não exista.
# O comando USE db_tarefas; seleciona o banco de dados db_tarefas.
# O comando CREATE TABLE IF NOT EXISTS tarefas cria a tabela tarefas, caso ela não exista, com as colunas id, titulo, descricao, status, prioridade e data_criacao.
# A coluna id é a chave primária da tabela, com auto_incremento.
# A coluna titulo armazena o título da tarefa.
# A coluna descricao armazena a descrição da tarefa.
# A coluna status armazena o status da tarefa, sendo restrita aos valores 'Pendente', 'Em Progresso' e 'Concluída'.
# A coluna prioridade armazena a prioridade da tarefa, sendo restrita aos valores 'Baixa', 'Média' e 'Alta'.
# A coluna data_criacao armazena a data e hora de criação da tarefa, com o valor padrão sendo a data e hora atual.
# O comando INSERT INTO tarefas (titulo, descricao, status, prioridade) insere três linhas na tabela tarefas com os valores especificados para as colunas titulo, descricao, status e prioridade.
