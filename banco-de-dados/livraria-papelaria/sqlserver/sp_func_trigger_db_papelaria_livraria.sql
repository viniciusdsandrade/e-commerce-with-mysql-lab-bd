-- Desabilita a verificação de chaves estrangeiras durante a criação das tabelas, será habilitado novamente no final do script
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Usa o banco de dados
USE db_papelaria_livraria;
GO

-- Exclui a stored procedure se ela existir
IF OBJECT_ID('sp_alterar_status_produto') IS NOT NULL
    BEGIN
        DROP PROCEDURE sp_alterar_status_produto;
    END;
GO

IF OBJECT_ID('sp_desativar_produto') IS NOT NULL
    BEGIN
        DROP PROCEDURE sp_desativar_produto;
    END;
GO

IF OBJECT_ID('sp_ativar_produto') IS NOT NULL
    BEGIN
        DROP PROCEDURE sp_ativar_produto;
    END;
GO

-- Exclui a função se ela existir
IF OBJECT_ID('fun_calcular_desconto_promocao') IS NOT NULL
    BEGIN
        DROP FUNCTION fun_calcular_desconto_promocao;
    END;
GO

-- Exclui a função se ela existir
IF OBJECT_ID('fun_gerar_row_num') IS NOT NULL
    BEGIN
        DROP FUNCTION fun_gerar_row_num;
    END;
GO

-- Exclui a função se ela existir
IF OBJECT_ID('fun_verificar_produto_ativo') IS NOT NULL
    BEGIN
        DROP FUNCTION fun_verificar_produto_ativo;
    END;
GO

-- Exclui a função se ela existir
IF OBJECT_ID('fun_desativar_produto') IS NOT NULL
    BEGIN
        DROP FUNCTION fun_desativar_produto;
    END;
GO

-- Exclui a função se ela existir
IF OBJECT_ID('fun_ativar_produto') IS NOT NULL
    BEGIN
        DROP FUNCTION fun_ativar_produto;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_log_produto_inativado_after_update') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_log_produto_inativado_after_update;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_log_produto_preco_historico_before_update') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_log_produto_preco_historico_before_update;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_calcular_preco_unitario_before_insert') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_calcular_preco_unitario_before_insert;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_atualizar_preco_compra_after_insert') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_atualizar_preco_compra_after_insert;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_atualizar_estoque_after_insert') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_atualizar_estoque_after_insert;
    END;
GO

-- Exclui o gatilho se ele existir
IF OBJECT_ID('tr_aplicar_cupom_after_insert') IS NOT NULL
    BEGIN
        DROP TRIGGER tr_aplicar_cupom_after_insert;
    END;
GO

-- Exclui a view se ela existir
IF OBJECT_ID('vw_stored_procedures') IS NOT NULL
    BEGIN
        DROP VIEW vw_stored_procedures;
    END;
GO

-- Exclui a view se ela existir
IF OBJECT_ID('vw_views') IS NOT NULL
    BEGIN
        DROP VIEW vw_views;
    END;
GO

-- Exclui a view se ela existir
IF OBJECT_ID('vw_functions') IS NOT NULL
    BEGIN
        DROP VIEW vw_functions;
    END;
GO

-- Exclui a view se ela existir
IF OBJECT_ID('vw_triggers') IS NOT NULL
    BEGIN
        DROP VIEW vw_triggers;
    END;
GO

-- Exclui a view se ela existir
IF OBJECT_ID('vw_todos_os_recursos') IS NOT NULL
    BEGIN
        DROP VIEW vw_todos_os_recursos;
    END;
GO


-- Cria a função fun_calcular_desconto_promocao
CREATE FUNCTION fun_calcular_desconto_promocao(@id_produto_param BIGINT)
    RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @desconto_promocao DECIMAL(10, 2);

    SELECT TOP 1 @desconto_promocao = p.desconto
    FROM tb_promocao_produto pp
             JOIN tb_promocao p ON pp.id_promocao = p.id
    WHERE pp.id_produto = @id_produto_param
      AND GETDATE() BETWEEN p.data_inicio AND p.data_fim;

    RETURN ISNULL(@desconto_promocao, 0);
END;
GO

-- Cria a função fun_verificar_produto_ativo
CREATE FUNCTION fun_verificar_produto_ativo(@id_produto BIGINT)
    RETURNS BIT
AS
BEGIN
    DECLARE @is_ativo BIT;

    SELECT @is_ativo = is_ativo
    FROM tb_produto
    WHERE id = @id_produto;

    RETURN ISNULL(@is_ativo, 0); -- Retorna 0 se o produto não for encontrado
END;
GO

-- Stored Procedure para desativar produto
CREATE PROCEDURE sp_desativar_produto(@id_produto BIGINT)
AS
BEGIN
    -- Verificar se o produto existe e está ativo
    IF dbo.fun_verificar_produto_ativo(@id_produto) = 1
        BEGIN
            -- Atualizar o campo is_ativo para false
            UPDATE tb_produto
            SET is_ativo = 0
            WHERE id = @id_produto;
        END
END;
GO

-- Stored Procedure para ativar produto
CREATE PROCEDURE sp_ativar_produto(@id_produto BIGINT)
AS
BEGIN
    -- Verificar se o produto existe e está inativo
    IF dbo.fun_verificar_produto_ativo(@id_produto) = 0
        BEGIN
            -- Atualizar o campo is_ativo para true
            UPDATE tb_produto
            SET is_ativo = 1
            WHERE id = @id_produto;
        END
END;
GO

-- Cria a stored procedure sp_alterar_status_produto
CREATE PROCEDURE sp_alterar_status_produto @id_produto BIGINT,
                                           @acao VARCHAR(10) -- 'ativar' ou 'desativar'
AS
BEGIN
    -- Verificar se a ação é ativar
    IF @acao = 'ativar'
        BEGIN
            -- Chamar a stored procedure para ativar o produto
            EXEC sp_ativar_produto @id_produto;

            -- Verificar se o produto foi ativado (se a stored procedure teve efeito)
            IF dbo.fun_verificar_produto_ativo(@id_produto) = 1
                BEGIN
                    SELECT 'Produto ' + CAST(@id_produto AS VARCHAR) + ' foi ativado com sucesso.' AS mensagem;
                END
            ELSE
                BEGIN
                    SELECT
                        'Produto ' + CAST(@id_produto AS VARCHAR) + ' já está ativo ou não foi encontrado.' AS mensagem;
                END;
        END
        -- Verificar se a ação é desativar
    ELSE
        IF @acao = 'desativar'
            BEGIN
                -- Chamar a stored procedure para desativar o produto
                EXEC sp_desativar_produto @id_produto;

                -- Verificar se o produto foi desativado (se a stored procedure teve efeito)
                IF dbo.fun_verificar_produto_ativo(@id_produto) = 0
                    BEGIN
                        SELECT 'Produto ' + CAST(@id_produto AS VARCHAR) + ' foi desativado com sucesso.' AS mensagem;
                    END
                ELSE
                    BEGIN
                        SELECT 'Produto ' + CAST(@id_produto AS VARCHAR) +
                               ' já está inativo ou não foi encontrado.' AS mensagem;
                    END;
            END
        ELSE
            BEGIN
                -- Se a ação não for nem 'ativar', nem 'desativar'
                SELECT 'Ação inválida. Utilize ''ativar'' ou ''desativar''.' AS mensagem;
            END;
END;
GO

-- Cria o gatilho tr_log_produto_inativado_after_update
CREATE TRIGGER tr_log_produto_inativado_after_update
    ON tb_produto
    AFTER UPDATE
    AS
BEGIN
    -- Verificar se o campo 'is_ativo' foi atualizado
    IF UPDATE(is_ativo)
        BEGIN
            -- Iterar sobre as linhas inseridas na tabela virtual 'inserted'
            DECLARE cur CURSOR FOR SELECT id, nome, preco, is_ativo FROM inserted;
            DECLARE @id_produto BIGINT, @nome VARCHAR(255), @preco DECIMAL(10, 2), @is_ativo_novo BIT;

            OPEN cur;
            FETCH NEXT FROM cur INTO @id_produto, @nome, @preco, @is_ativo_novo;

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    -- Verificar se o produto estava ativo antes da atualização
                    IF dbo.fun_verificar_produto_ativo(@id_produto) = 1
                        BEGIN
                            -- Verificar se o produto foi desativado
                            IF @is_ativo_novo = 0
                                BEGIN
                                    -- Inserir o produto na tabela log_produto_inativos
                                    INSERT INTO log_produto_inativos (id_produto, nome, preco, data_inativacao)
                                    VALUES (@id_produto, @nome, @preco, GETDATE());
                                END
                                -- Verificar se o produto foi reativado
                            ELSE
                                IF @is_ativo_novo = 1
                                    BEGIN
                                        -- Atualizar a data de reativação na tabela log_produto_inativos
                                        UPDATE log_produto_inativos
                                        SET data_reativacao = GETDATE()
                                        WHERE id_produto = @id_produto;
                                    END
                        END

                    FETCH NEXT FROM cur INTO @id_produto, @nome, @preco, @is_ativo_novo;
                END

            CLOSE cur;
            DEALLOCATE cur;
        END
END;
GO


-- Cria o gatilho tr_aplicar_cupom_after_insert
CREATE TRIGGER tr_aplicar_cupom_after_insert
    ON tb_cupom_compra
    AFTER INSERT
    AS
BEGIN
    -- Iterar sobre as linhas inseridas na tabela virtual 'inserted'
    DECLARE cur CURSOR FOR SELECT id_cupom, id_compra FROM inserted;
    DECLARE @id_cupom BIGINT, @id_compra BIGINT, @desconto_cupom DECIMAL(10, 2);

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_cupom, @id_compra;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obter o desconto do cupom
            SELECT @desconto_cupom = desconto
            FROM tb_cupom
            WHERE id = @id_cupom;

            -- Atualizar o preço total da compra com o desconto do cupom
            UPDATE tb_compra
            SET preco_total = preco_total - @desconto_cupom
            WHERE id = @id_compra;

            FETCH NEXT FROM cur INTO @id_cupom, @id_compra;
        END

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

-- Cria o gatilho tr_log_produto_preco_historico_before_update
CREATE TRIGGER tr_log_produto_preco_historico_before_update
    ON tb_produto
    FOR UPDATE
    AS
BEGIN
    -- Iterar sobre as linhas na tabela virtual 'inserted'
    DECLARE cur CURSOR FOR SELECT id, preco FROM inserted;
    DECLARE @id_produto BIGINT, @preco_novo DECIMAL(10, 2);

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_produto, @preco_novo;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Verificar se o produto está ativo usando a função
            IF dbo.fun_verificar_produto_ativo(@id_produto) = 1
                BEGIN
                    -- Obter o preço anterior do produto
                    DECLARE @preco_anterior DECIMAL(10, 2);
                    SELECT @preco_anterior = preco FROM deleted WHERE id = @id_produto;

                    -- Verificar se o preço foi alterado
                    IF @preco_anterior != @preco_novo
                        BEGIN
                            -- Inserir o histórico de alteração de preço na tabela log_produto_preco_historico
                            INSERT INTO log_produto_preco_historico (id_produto, preco_anterior, preco_novo)
                            VALUES (@id_produto, @preco_anterior, @preco_novo);
                        END;
                END
            ELSE
                BEGIN
                    -- Lançar um erro e reverter a transação se o produto estiver inativo
                    RAISERROR ('Não é possível atualizar o preço de um produto inativo.', 16, 1);
                    ROLLBACK TRANSACTION;
                END;

            FETCH NEXT FROM cur INTO @id_produto, @preco_novo;
        END

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

-- Cria o gatilho tr_calcular_preco_unitario_before_insert
CREATE TRIGGER tr_calcular_preco_unitario_before_insert
    ON tb_compra_produto
    FOR INSERT
    AS
BEGIN
    -- Iterar sobre as linhas na tabela virtual 'inserted'
    DECLARE cur CURSOR FOR SELECT id_compra, id_produto, quantidade FROM inserted;
    DECLARE @id_compra BIGINT, @id_produto BIGINT, @quantidade INT;
    DECLARE @estoque_atual INT;
    DECLARE @preco_produto DECIMAL(10, 2);
    DECLARE @produto_ativo BIT;
    DECLARE @desconto_promocao DECIMAL(10, 2);

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_compra, @id_produto, @quantidade;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obter a quantidade em estoque e o status do produto
            SELECT @estoque_atual = e.quantidade,
                   @produto_ativo = p.is_ativo
            FROM tb_estoque e
                     JOIN tb_produto p ON e.id_produto = p.id
            WHERE e.id_produto = @id_produto;

            -- Verificar se o produto está ativo
            IF @produto_ativo = 1
                BEGIN
                    -- Obter o preço do produto
                    SELECT @preco_produto = preco
                    FROM tb_produto
                    WHERE id = @id_produto;

                    -- Calcular o desconto da promoção (se houver)
                    SELECT TOP 1 @desconto_promocao = p.desconto
                    FROM tb_promocao_produto pp
                             JOIN tb_promocao p ON pp.id_promocao = p.id
                    WHERE pp.id_produto = @id_produto
                      AND GETDATE() BETWEEN p.data_inicio AND p.data_fim;

                    -- Verificar se há estoque suficiente
                    IF @estoque_atual >= @quantidade
                        BEGIN
                            -- Definir o preço unitário como o preço do produto com desconto da promoção (se houver)
                            UPDATE tb_compra_produto
                            SET @preco_produto = @preco_produto * (
                                1 - ISNULL(@desconto_promocao, 0) / 100
                                )
                            WHERE id_compra = @id_compra
                              AND id_produto = @id_produto;
                        END
                    ELSE
                        BEGIN
                            RAISERROR ('Estoque insuficiente para o produto.', 16, 1);
                            ROLLBACK TRANSACTION;
                        END;
                END
            ELSE
                BEGIN
                    RAISERROR ('Não é possível comprar um produto inativo.', 16, 1);
                    ROLLBACK TRANSACTION;
                END;

            FETCH NEXT FROM cur INTO @id_compra, @id_produto, @quantidade;
        END

    CLOSE cur;
    DEALLOCATE cur;
END;
GO

-- Cria o gatilho tr_atualizar_preco_compra_after_insert
CREATE TRIGGER tr_atualizar_preco_compra_after_insert
    ON tb_compra_produto
    AFTER INSERT
    AS
BEGIN
    -- Atualizar o preço total da compra para cada compra afetada
    UPDATE c
    SET preco_total = c.preco_total + i.preco_total_item
    FROM tb_compra c
             JOIN (SELECT id_compra, SUM(quantidade * preco_unit) AS preco_total_item -- Correção: usar 'preco_unit'
                   FROM inserted
                   WHERE dbo.fun_verificar_produto_ativo(id_produto) = 1
                   GROUP BY id_compra) i ON c.id = i.id_compra;

    -- Verificar se algum produto inativo foi inserido
    IF EXISTS (SELECT 1 FROM inserted WHERE dbo.fun_verificar_produto_ativo(id_produto) = 0)
        BEGIN
            THROW 51000, 'Não é possível atualizar o preço da compra com um produto inativo.', 1;
        END;
END;
GO
-- Cria o gatilho tr_atualizar_estoque_after_insert
CREATE TRIGGER tr_atualizar_estoque_after_insert
    ON tb_compra_produto
    AFTER INSERT
    AS
BEGIN
    -- Iterar sobre as linhas na tabela virtual 'inserted'
    DECLARE cur CURSOR FOR SELECT id_produto, quantidade FROM inserted;
    DECLARE @id_produto BIGINT, @quantidade INT;

    OPEN cur;
    FETCH NEXT FROM cur INTO @id_produto, @quantidade;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Verificar se o produto está ativo
            IF dbo.fun_verificar_produto_ativo(@id_produto) = 1
                BEGIN
                    -- Atualizar o estoque na tabela tb_estoque
                    UPDATE tb_estoque
                    SET quantidade = quantidade - @quantidade
                    WHERE id_produto = @id_produto;

                    -- Verificar se a quantidade em estoque ficou negativa
                    IF (SELECT quantidade
                        FROM tb_estoque
                        WHERE id_produto = @id_produto) < 0
                        BEGIN
                            -- Lançar um erro para cancelar a operação
                            RAISERROR ('Estoque insuficiente para o produto.', 16, 1);
                            ROLLBACK TRANSACTION;
                        END;
                END
            ELSE
                BEGIN
                    RAISERROR ('Não é possível atualizar o estoque de um produto inativo.', 16, 1);
                    ROLLBACK TRANSACTION;
                END;

            FETCH NEXT FROM cur INTO @id_produto, @quantidade;
        END
    CLOSE cur;
    DEALLOCATE cur;
END;
GO

-- View para listar Stored Procedures
CREATE VIEW vw_stored_procedures AS
SELECT ROW_NUMBER() OVER (ORDER BY SPECIFIC_NAME) AS row_num,
       SPECIFIC_NAME                              AS object_name,
       'PROCEDURE'                                AS object_type
FROM information_schema.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_SCHEMA = 'dbo';
GO

-- View para listar Views
CREATE VIEW vw_views AS
SELECT ROW_NUMBER() OVER (ORDER BY TABLE_NAME) AS row_num,
       TABLE_NAME                              AS object_name,
       'VIEW'                                  AS object_type
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'dbo';
GO

-- View para listar Functions
CREATE VIEW vw_functions AS
SELECT ROW_NUMBER() OVER (ORDER BY ROUTINE_NAME) AS row_num,
       ROUTINE_NAME                              AS object_name,
       'FUNCTION'                                AS object_type
FROM information_schema.ROUTINES
WHERE ROUTINE_TYPE = 'FUNCTION'
  AND ROUTINE_SCHEMA = 'dbo';
GO

CREATE VIEW vw_Triggers AS
SELECT ROW_NUMBER() OVER (ORDER BY t.name) AS row_num,
       t.name                              AS object_name,
       'TRIGGER'                           AS object_type,
       SCHEMA_NAME(o.schema_id)            AS schema_name -- Pegando schema_id da tabela sys.objects
FROM sys.triggers t
         JOIN sys.objects o ON t.object_id = o.object_id
WHERE SCHEMA_NAME(o.schema_id) = 'dbo'; -- Usando schema_id da sys.objects
GO

-- View para listar todos os recursos (Stored Procedures, Views, Functions e Triggers)
CREATE VIEW vw_todos_os_recursos AS
SELECT ROW_NUMBER() OVER (ORDER BY object_type, object_name) AS row_num,
       object_name,
       object_type
FROM (SELECT object_name,
             object_type
      FROM vw_stored_procedures
      UNION ALL
      SELECT object_name,
             object_type
      FROM vw_views
      UNION ALL
      SELECT object_name,
             object_type
      FROM vw_functions
      UNION ALL
      SELECT object_name,
             object_type
      FROM vw_triggers) AS recursos;
GO

SELECT *
FROM vw_stored_procedures;
SELECT *
FROM vw_views;
SELECT *
FROM vw_functions;
SELECT *
FROM vw_triggers;
SELECT *
FROM vw_todos_os_recursos;


-- Habilita a verificação de chaves estrangeiras novamente

EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';