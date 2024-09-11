-- Desabilita o modo de confirmação implícita para evitar erros
SET client_min_messages TO WARNING;

-- Remove a stored procedure se ela já existir
DROP PROCEDURE IF EXISTS sp_alterar_status_produto;

-- Remove as funções se elas já existirem
DROP FUNCTION IF EXISTS fun_calcular_desconto_promocao;
DROP FUNCTION IF EXISTS fun_gerar_row_num;
DROP FUNCTION IF EXISTS fun_verificar_produto_ativo;
DROP FUNCTION IF EXISTS fun_desativar_produto;
DROP FUNCTION IF EXISTS fun_ativar_produto;

-- Remove as funções dos triggers com CASCADE para remover os triggers automaticamente
DROP FUNCTION IF EXISTS tr_calcular_preco_unitario_before_insert_func CASCADE;
DROP FUNCTION IF EXISTS tr_atualizar_preco_compra_after_insert_func CASCADE;
DROP FUNCTION IF EXISTS tr_atualizar_estoque_after_insert_func CASCADE;
DROP FUNCTION IF EXISTS tr_log_produto_inativado_after_update_func CASCADE;
DROP FUNCTION IF EXISTS tr_aplicar_cupom_after_insert_func CASCADE;
DROP FUNCTION IF EXISTS tr_log_produto_preco_historico_before_update_func CASCADE;

-- Remove as views se elas já existirem
DROP VIEW IF EXISTS vw_todos_os_recursos;
DROP VIEW IF EXISTS vw_stored_procedures;
DROP VIEW IF EXISTS vw_views;
DROP VIEW IF EXISTS vw_functions;
DROP VIEW IF EXISTS vw_triggers;


SELECT 'Script de exclusão executado com sucesso!';

-- Função para calcular o desconto de uma promoção
CREATE FUNCTION fun_calcular_desconto_promocao(id_produto_param INTEGER)
    RETURNS DECIMAL(10, 2) AS
$$
DECLARE
    desconto_promocao DECIMAL(10, 2);
BEGIN
    SELECT p.desconto
    INTO desconto_promocao
    FROM tb_promocao_produto pp
             JOIN tb_promocao p ON pp.id_promocao = p.id
    WHERE pp.id_produto = id_produto_param
      AND NOW() BETWEEN p.data_inicio AND p.data_fim
    LIMIT 1; -- Garante que apenas um desconto seja retornado

    RETURN COALESCE(desconto_promocao, 0);
END;
$$ LANGUAGE plpgsql;

-- Função para verificar se um produto está ativo
CREATE FUNCTION fun_verificar_produto_ativo(id_produto INTEGER)
    RETURNS BOOLEAN AS
$$
DECLARE
    is_ativo BOOLEAN;
BEGIN
    SELECT is_ativo
    INTO is_ativo
    FROM tb_produto
    WHERE id = id_produto;

    RETURN is_ativo;
END;
$$ LANGUAGE plpgsql;

-- Função para desativar um produto
CREATE FUNCTION fun_desativar_produto(id_produto INTEGER)
    RETURNS BOOLEAN AS
$$
BEGIN
    -- Verificar se o produto existe e está ativo
    IF fun_verificar_produto_ativo(id_produto) THEN
-- Atualizar o campo is_ativo para false
        UPDATE tb_produto
        SET is_ativo = FALSE
        WHERE id = id_produto;
        RETURN TRUE;
    ELSE
        -- Retornar false se o produto não existe ou já está inativo
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Função para ativar um produto
CREATE FUNCTION fun_ativar_produto(id_produto INTEGER)
    RETURNS BOOLEAN AS
$$
BEGIN
    -- Verificar se o produto existe e está inativo
    IF NOT fun_verificar_produto_ativo(id_produto) THEN
-- Atualizar o campo is_ativo para true
        UPDATE tb_produto
        SET is_ativo = TRUE
        WHERE id = id_produto;
        RETURN TRUE;
    ELSE
        -- Retornar false se o produto não existe ou já está ativo
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE sp_alterar_status_produto(
    IN id_produto INTEGER,
    IN acao VARCHAR(10) -- 'ativar' ou 'desativar'
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    resultado BOOLEAN;
BEGIN
    -- Verificar se a ação é ativar
    IF acao = 'ativar' THEN
        -- Chamar a função para ativar o produto
        SELECT fun_ativar_produto(id_produto) INTO resultado;

        -- Verificar o resultado
        IF resultado THEN
            RAISE NOTICE 'Produto % foi ativado com sucesso.', id_produto;
        ELSE
            RAISE NOTICE 'Produto % já está ativo ou não foi encontrado.', id_produto;
        END IF;

        -- Verificar se a ação é desativar
    ELSEIF acao = 'desativar' THEN
        -- Chamar a função para desativar o produto
        SELECT fun_desativar_produto(id_produto) INTO resultado;

        -- Verificar o resultado
        IF resultado THEN
            RAISE NOTICE 'Produto % foi desativado com sucesso.', id_produto;
        ELSE
            RAISE NOTICE 'Produto % já está inativo ou não foi encontrado.', id_produto;
        END IF;

    ELSE
        -- Se a ação não for nem 'ativar', nem 'desativar'
        RAISE NOTICE 'Ação inválida. Utilize ''ativar'' ou ''desativar''.';
    END IF;
END;
$$;

-- Trigger para registrar um produto inativado
CREATE FUNCTION tr_log_produto_inativado_after_update_func()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Verificar se o produto está ativo antes da atualização
    IF fun_verificar_produto_ativo(OLD.id) THEN
        -- Verificar se o campo is_ativo foi atualizado para false
        IF OLD.is_ativo = TRUE AND NEW.is_ativo = FALSE THEN
-- Inserir o produto na tabela log_produto_inativos
            INSERT INTO log_produto_inativos (id_produto, nome, preco, data_inativacao)
            VALUES (OLD.id, OLD.nome, OLD.preco, NOW());
        END IF;

        -- Verificar se o campo is_ativo foi atualizado para true
        IF OLD.is_ativo = FALSE AND NEW.is_ativo = TRUE THEN
            -- Atualizar a data de reativação na tabela log_produto_inativos
            UPDATE log_produto_inativos
            SET data_reativacao = NOW()
            WHERE id_produto = OLD.id;
        END IF;
    ELSE
        RAISE EXCEPTION 'Não é possível atualizar um produto inativo.';
    END IF;

    RETURN NEW; -- Retornar a nova linha para que a atualização continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_log_produto_inativado_after_update
    AFTER UPDATE
    ON tb_produto
    FOR EACH ROW
EXECUTE FUNCTION tr_log_produto_inativado_after_update_func();


-- Trigger para aplicar o desconto de um cupom
CREATE FUNCTION tr_aplicar_cupom_after_insert_func()
    RETURNS TRIGGER AS
$$
DECLARE
    desconto_cupom DECIMAL(10, 2);
BEGIN
    -- Obter o desconto do cupom
    SELECT desconto
    INTO desconto_cupom
    FROM tb_cupom
    WHERE id = NEW.id_cupom;

-- Atualizar o preço total da compra com o desconto do cupom
    UPDATE tb_compra
    SET preco_total = preco_total - desconto_cupom
    WHERE id = NEW.id_compra;

    RETURN NEW; -- Retornar a nova linha para que a inserção continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_aplicar_cupom_after_insert
    AFTER INSERT
    ON tb_cupom_compra
    FOR EACH ROW
EXECUTE FUNCTION tr_aplicar_cupom_after_insert_func();

-- Trigger para registrar o histórico de preços de um produto
CREATE FUNCTION tr_log_produto_preco_historico_before_update_func()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Verificar se o produto está ativo usando a função
    IF fun_verificar_produto_ativo(OLD.id) THEN
        IF OLD.preco != NEW.preco THEN
            INSERT INTO log_produto_preco_historico (id_produto, preco_anterior, preco_novo)
            VALUES (OLD.id, OLD.preco, NEW.preco);
        END IF;
    ELSE
        RAISE EXCEPTION 'Não é possível atualizar o preço de um produto inativo.';
    END IF;

    RETURN NEW; -- Retornar a nova linha para que a atualização continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_log_produto_preco_historico_before_update
    BEFORE UPDATE
    ON tb_produto
    FOR EACH ROW
EXECUTE FUNCTION tr_log_produto_preco_historico_before_update_func();


-- Trigger para calcular o preço unitário de um produto na compra
CREATE FUNCTION tr_calcular_preco_unitario_before_insert_func()
    RETURNS TRIGGER AS
$$
DECLARE
    estoque_atual     INTEGER;
    preco_produto     DECIMAL(10, 2);
    produto_ativo     BOOLEAN;
    desconto_promocao DECIMAL(10, 2);
BEGIN
    -- Obter a quantidade em estoque e o status do produto
    SELECT e.quantidade, p.is_ativo
    INTO estoque_atual, produto_ativo
    FROM tb_estoque e
             JOIN tb_produto p ON e.id_produto = p.id
    WHERE e.id_produto = NEW.id_produto;

-- Verificar se o produto está ativo
    IF produto_ativo = TRUE THEN
        -- Obter o preço do produto
        SELECT preco
        INTO preco_produto
        FROM tb_produto
        WHERE id = NEW.id_produto;

-- Calcular o desconto da promoção (se houver)
        SELECT p.desconto
        INTO desconto_promocao
        FROM tb_promocao_produto pp
                 JOIN tb_promocao p ON pp.id_promocao = p.id
        WHERE pp.id_produto = NEW.id_produto
          AND NOW() BETWEEN p.data_inicio AND p.data_fim
        LIMIT 1;
        -- Garante que apenas um desconto seja aplicado, caso haja mais de uma promoção

-- Verificar se há estoque suficiente
        IF estoque_atual >= NEW.quantidade THEN
            -- Definir o preço unitário como o preço do produto com desconto da promoção (se houver)
            NEW.quantidade := preco_produto * (1 - COALESCE(desconto_promocao, 0) / 100);
        ELSE
            RAISE EXCEPTION 'Estoque insuficiente para o produto.';
        END IF;
    ELSE
        RAISE EXCEPTION 'Não é possível comprar um produto inativo.';
    END IF;

    RETURN NEW; -- Retornar a nova linha para que a inserção continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_calcular_preco_unitario_before_insert
    BEFORE INSERT
    ON tb_compra_produto
    FOR EACH ROW
EXECUTE FUNCTION tr_calcular_preco_unitario_before_insert_func();

-- Trigger para atualizar o preço total da compra
CREATE FUNCTION tr_atualizar_preco_compra_after_insert_func()
    RETURNS TRIGGER AS
$$
DECLARE
    produto_ativo BOOLEAN;
BEGIN
    -- Obter o status do produto antes da atualização do preço da compra
    SELECT is_ativo
    INTO produto_ativo
    FROM tb_produto
    WHERE id = NEW.id_produto;

-- Verificar se o produto está ativo usando a variável
    IF produto_ativo = TRUE THEN
        -- Atualizar o preço total da compra na tabela tb_compra
        UPDATE tb_compra
        SET preco_total = preco_total + (NEW.quantidade * (SELECT preco FROM tb_produto WHERE id = NEW.id_produto))
        WHERE id = NEW.id_compra;
    ELSE
        RAISE EXCEPTION 'Não é possível atualizar o preço da compra com um produto inativo.';
    END IF;

    RETURN NEW; -- Retornar a nova linha para que a inserção continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_atualizar_preco_compra_after_insert
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
EXECUTE FUNCTION tr_atualizar_preco_compra_after_insert_func();

-- Trigger para atualizar o estoque após a compra de um produto
CREATE FUNCTION tr_atualizar_estoque_after_insert_func()
    RETURNS TRIGGER AS
$$
DECLARE
    produto_ativo BOOLEAN;
BEGIN
    -- Obter o status do produto antes da atualização do estoque
    SELECT is_ativo
    INTO produto_ativo
    FROM tb_produto
    WHERE id = NEW.id_produto;

-- Verificar se o produto está ativo usando a variável
    IF produto_ativo = TRUE THEN
        -- Atualizar o estoque na tabela tb_estoque
        UPDATE tb_estoque
        SET quantidade = quantidade - NEW.quantidade
        WHERE id_produto = NEW.id_produto;

-- Verificar se a quantidade em estoque ficou negativa
        IF
            (SELECT quantidade FROM tb_estoque WHERE id_produto = NEW.id_produto)
                < 0 THEN
            -- Lançar um erro para cancelar a operação
            RAISE EXCEPTION 'Estoque insuficiente para o produto.';
        END IF;
    ELSE
        RAISE EXCEPTION 'Não é possível atualizar o estoque de um produto inativo.';
    END IF;

    RETURN NEW; -- Retornar a nova linha para que a inserção continue
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_atualizar_estoque_after_insert
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
EXECUTE FUNCTION tr_atualizar_estoque_after_insert_func();

-- Função para gerar um número de linha sequencial
CREATE FUNCTION fun_gerar_row_num()
    RETURNS INTEGER AS
$$
BEGIN
    RETURN ROW_NUMBER() OVER (ORDER BY NULL); -- Numeração sequencial sem variáveis
END;
$$ LANGUAGE plpgsql;

-- View para listar Stored Procedures
CREATE OR REPLACE VIEW vw_stored_procedures AS
SELECT ROW_NUMBER() OVER (ORDER BY routine_name) AS row_num, -- Numeração sequencial
       routine_name                              AS object_name,
       'PROCEDURE'                               AS object_type
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE'
  AND routine_schema = 'public';

-- View para listar Views
CREATE OR REPLACE VIEW vw_views AS
SELECT ROW_NUMBER() OVER (ORDER BY table_name) AS row_num, -- Numeração sequencial
       table_name                              AS object_name,
       'VIEW'                                  AS object_type
FROM information_schema.views
WHERE table_schema = 'public';

-- View para listar Functions
CREATE OR REPLACE VIEW vw_functions AS
SELECT ROW_NUMBER() OVER (ORDER BY routine_name) AS row_num, -- Numeração sequencial
       routine_name                              AS object_name,
       'FUNCTION'                                AS object_type
FROM information_schema.routines
WHERE routine_type = 'FUNCTION'
  AND routine_schema = 'public';

-- View para listar Triggers
CREATE OR REPLACE VIEW vw_triggers AS
SELECT ROW_NUMBER() OVER (ORDER BY trigger_name) AS row_num, -- Numeração sequencial
       trigger_name                              AS object_name,
       'TRIGGER'                                 AS object_type
FROM information_schema.triggers
WHERE trigger_schema = 'public';

-- View para listar todos os recursos (Stored Procedures, Views, Functions e Triggers)
CREATE OR REPLACE VIEW vw_todos_os_recursos AS
SELECT ROW_NUMBER() OVER (ORDER BY object_type, object_name) AS row_num, -- Numeração sequencial após a união
       object_name,
       object_type
FROM (SELECT object_name, object_type
      FROM vw_stored_procedures
      UNION ALL
      SELECT object_name, object_type
      FROM vw_views
      UNION ALL
      SELECT object_name, object_type
      FROM vw_functions
      UNION ALL
      SELECT object_name, object_type
      FROM vw_triggers) AS recursos;


-- Habilita o modo de confirmação implícita novamente
SET client_min_messages TO NOTICE;

-- Informa que o script foi executado com sucesso
SELECT 'Script executado com sucesso!';