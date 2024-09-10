USE db_papelaria_livraria;

DROP PROCEDURE IF EXISTS sp_alterar_status_produto;
DROP FUNCTION IF EXISTS fun_gerar_row_num;
DROP FUNCTION IF EXISTS fun_verificar_produto_ativo;
DROP FUNCTION IF EXISTS fun_desativar_produto;
DROP FUNCTION IF EXISTS fun_ativar_produto;
DROP TRIGGER IF EXISTS tr_log_produto_inativado_after_update;
DROP TRIGGER IF EXISTS tr_log_produto_preco_historico_before_update;
DROP TRIGGER IF EXISTS tr_calcular_preco_unitario_before_insert;
DROP TRIGGER IF EXISTS tr_atualizar_preco_compra_after_insert;
DROP TRIGGER IF EXISTS tr_atualizar_estoque_after_insert;
DROP VIEW IF EXISTS vw_stored_procedures;
DROP VIEW IF EXISTS vw_views;
DROP VIEW IF EXISTS vw_functions;
DROP VIEW IF EXISTS vw_triggers;
DROP VIEW IF EXISTS vw_todos_os_recursos;

-- Função para verificar se um produto está ativo
DELIMITER //
CREATE FUNCTION IF NOT EXISTS fun_verificar_produto_ativo(id_produto BIGINT UNSIGNED)
    RETURNS BOOLEAN
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE is_ativo BOOLEAN;

    SELECT is_ativo INTO is_ativo FROM tb_produto WHERE id = id_produto;

    RETURN is_ativo;
END //
DELIMITER ;

-- Função para desativar um produto
DELIMITER //
CREATE FUNCTION IF NOT EXISTS fun_desativar_produto(id_produto BIGINT UNSIGNED)
    RETURNS BOOLEAN
    DETERMINISTIC
    MODIFIES SQL DATA
BEGIN
    -- Verificar se o produto existe e está ativo
    IF fun_verificar_produto_ativo(id_produto) THEN
        -- Atualizar o campo is_ativo para false
        UPDATE tb_produto SET is_ativo = FALSE WHERE id = id_produto;
        RETURN TRUE;
    ELSE
        -- Retornar false se o produto não existe ou já está inativo
        RETURN FALSE;
    END IF;
END //
DELIMITER ;

-- Função para ativar um produto
DELIMITER //
CREATE FUNCTION IF NOT EXISTS fun_ativar_produto(id_produto BIGINT UNSIGNED)
    RETURNS BOOLEAN
    DETERMINISTIC
    MODIFIES SQL DATA
BEGIN
    -- Verificar se o produto existe e está inativo
    IF NOT fun_verificar_produto_ativo(id_produto) THEN
        -- Atualizar o campo is_ativo para true
        UPDATE tb_produto SET is_ativo = TRUE WHERE id = id_produto;
        RETURN TRUE;
    ELSE
        -- Retornar false se o produto não existe ou já está ativo
        RETURN FALSE;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_alterar_status_produto(
    IN id_produto BIGINT UNSIGNED,
    IN acao VARCHAR(10) -- 'ativar' ou 'desativar'
)
BEGIN
    DECLARE resultado BOOLEAN;

    -- Verificar se a ação é ativar
    IF acao = 'ativar' THEN
        -- Chamar a função para ativar o produto
        SET resultado = fun_ativar_produto(id_produto);

        -- Verificar o resultado
        IF resultado THEN
            SELECT CONCAT('Produto ', id_produto, ' foi ativado com sucesso.') AS mensagem;
        ELSE
            SELECT CONCAT('Produto ', id_produto, ' já está ativo ou não foi encontrado.') AS mensagem;
        END IF;

        -- Verificar se a ação é desativar
    ELSEIF acao = 'desativar' THEN
        -- Chamar a função para desativar o produto
        SET resultado = fun_desativar_produto(id_produto);

        -- Verificar o resultado
        IF resultado THEN
            SELECT CONCAT('Produto ', id_produto, ' foi desativado com sucesso.') AS mensagem;
        ELSE
            SELECT CONCAT('Produto ', id_produto, ' já está inativo ou não foi encontrado.') AS mensagem;
        END IF;

    ELSE
        -- Se a ação não for nem 'ativar' nem 'desativar'
        SELECT 'Ação inválida. Utilize ''ativar'' ou ''desativar''.' AS mensagem;
    END IF;

END //
DELIMITER ;

-- Trigger para registrar a inativação e reativação de produtos na tabela de log
DELIMITER //
CREATE TRIGGER IF NOT EXISTS tr_log_produto_inativado_after_update
    AFTER UPDATE
    ON tb_produto
    FOR EACH ROW
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível atualizar um produto inativo.';
    END IF;
END //
DELIMITER ;

-- Trigger para registrar a alteração de preço na tabela de histórico
DELIMITER //
CREATE TRIGGER IF NOT EXISTS tr_log_produto_preco_historico_before_update
    BEFORE UPDATE
    ON tb_produto
    FOR EACH ROW
BEGIN
    -- Verificar se o produto está ativo usando a função
    IF fun_verificar_produto_ativo(OLD.id) THEN
        IF OLD.preco != NEW.preco THEN
            INSERT INTO log_produto_preco_historico (id_produto, preco_anterior, preco_novo)
            VALUES (OLD.id, OLD.preco, NEW.preco);
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível atualizar o preço de um produto inativo.';
    END IF;
END //
DELIMITER ;

-- Trigger para calcular o preço unitário da compra e atualizar o estoque
DELIMITER //
CREATE TRIGGER IF NOT EXISTS tr_calcular_preco_unitario_before_insert
    BEFORE INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    DECLARE preco_produto DECIMAL(10, 2);
    DECLARE produto_ativo BOOLEAN;

    -- Obter a quantidade em estoque e o status do produto
    SELECT quantidade, is_ativo
    INTO estoque_atual, produto_ativo
    FROM tb_estoque
             JOIN tb_produto ON tb_estoque.id_produto = tb_produto.id
    WHERE id_produto = NEW.id_produto;

    -- Verificar se o produto está ativo
    IF produto_ativo = TRUE THEN
        -- Obter o preço do produto
        SELECT preco INTO preco_produto FROM tb_produto WHERE id = NEW.id_produto;

        -- Verificar se há estoque suficiente
        IF estoque_atual >= NEW.quantidade THEN
            -- Definir o preço unitário como o preço do produto
            SET NEW.quantidade = preco_produto;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível comprar um produto inativo.';
    END IF;
END;
DELIMITER ;

-- Trigger para atualizar o estoque e o preço total da compra
DELIMITER //
CREATE TRIGGER IF NOT EXISTS tr_atualizar_preco_compra_after_insert
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    DECLARE produto_ativo BOOLEAN;

    -- Obter o status do produto antes da atualização do preço da compra
    SELECT is_ativo INTO produto_ativo FROM tb_produto WHERE id = NEW.id_produto;

    -- Verificar se o produto está ativo usando a variável
    IF produto_ativo = TRUE THEN
        -- Atualizar o preço total da compra na tabela tb_compra
        UPDATE tb_compra
        SET preco_total = preco_total + (NEW.quantidade * (SELECT preco FROM tb_produto WHERE id = NEW.id_produto))
        WHERE id = NEW.id_compra;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível atualizar o preço da compra com um produto inativo.';
    END IF;
END;
DELIMITER ;

-- Trigger para atualizar o preço total da compraX
DELIMITER //
CREATE TRIGGER IF NOT EXISTS tr_atualizar_preco_compra_after_insert
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    -- Verificar se o produto está ativo
    IF fun_verificar_produto_ativo(NEW.id_produto) THEN
        -- Atualizar o preço total da compra na tabela tb_compra
        UPDATE tb_compra
        SET preco_total = preco_total + (NEW.quantidade * (SELECT preco FROM tb_produto WHERE id = NEW.id_produto))
        WHERE id = NEW.id_compra;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível atualizar o preço da compra com um produto inativo.';
    END IF;
END;
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_atualizar_estoque_after_insert
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    DECLARE produto_ativo BOOLEAN;

    -- Obter o status do produto antes da atualização do estoque
    SELECT is_ativo INTO produto_ativo FROM tb_produto WHERE id = NEW.id_produto;

    -- Verificar se o produto está ativo usando a variável
    IF produto_ativo = TRUE THEN
        -- Atualizar o estoque na tabela tb_estoque
        UPDATE tb_estoque
        SET quantidade = quantidade - NEW.quantidade
        WHERE id_produto = NEW.id_produto;

        -- Verificar se a quantidade em estoque ficou negativa
        IF (SELECT quantidade FROM tb_estoque WHERE id_produto = NEW.id_produto) < 0 THEN
            -- Lançar um erro para cancelar a operação
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível atualizar o estoque de um produto inativo.';
    END IF;
END;
DELIMITER ;

DELIMITER //
CREATE FUNCTION IF NOT EXISTS fun_gerar_row_num()
    RETURNS INTEGER
    READS SQL DATA
BEGIN
    RETURN ROW_NUMBER() OVER (ORDER BY NULL); -- Numeração sequencial sem variáveis
END //
DELIMITER ;

-- View para listar Stored Procedures
CREATE OR REPLACE VIEW vw_stored_procedures AS
SELECT ROW_NUMBER() over (ORDER BY SPECIFIC_NAME) AS row_num, -- Numeração sequencial
       SPECIFIC_NAME                              AS object_name,
       'PROCEDURE'                                AS object_type
FROM information_schema.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_SCHEMA = 'db_papelaria_livraria';

-- View para listar Views
CREATE OR REPLACE VIEW vw_views AS
SELECT ROW_NUMBER() OVER (ORDER BY TABLE_NAME) AS row_num, -- Numeração sequencial
       TABLE_NAME                              AS object_name,
       'VIEW'                                  AS object_type
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'db_papelaria_livraria';

-- View para listar Functions
CREATE OR REPLACE VIEW vw_functions AS
SELECT ROW_NUMBER() OVER (ORDER BY ROUTINE_NAME) AS row_num, -- Numeração sequencial
       ROUTINE_NAME                              AS object_name,
       'FUNCTION'                                AS object_type
FROM information_schema.ROUTINES
WHERE ROUTINE_TYPE = 'FUNCTION'
  AND ROUTINE_SCHEMA = 'db_papelaria_livraria';

-- View para listar Triggers
CREATE OR REPLACE VIEW vw_triggers AS
SELECT ROW_NUMBER() OVER (ORDER BY TRIGGER_NAME) AS row_num, -- Numeração sequencial
       TRIGGER_NAME                              AS object_name,
       'TRIGGER'                                 AS object_type
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'db_papelaria_livraria';

-- View para listar todos os recursos (Stored Procedures, Views, Functions e Triggers)
CREATE OR REPLACE VIEW vw_todos_os_recursos AS
SELECT
    ROW_NUMBER() OVER (ORDER BY object_type, object_name) AS row_num,  -- Numeração sequencial após a união
    object_name,
    object_type
FROM (
    SELECT object_name, object_type FROM vw_stored_procedures
    UNION ALL
    SELECT object_name, object_type FROM vw_views
    UNION ALL
    SELECT object_name, object_type FROM vw_functions
    UNION ALL
    SELECT object_name, object_type FROM vw_triggers
) AS recursos;

SELECT * FROM vw_stored_procedures;
SELECT * FROM vw_views;
SELECT * FROM vw_functions;
SELECT * FROM vw_triggers;
SELECT * FROM vw_todos_os_recursos;