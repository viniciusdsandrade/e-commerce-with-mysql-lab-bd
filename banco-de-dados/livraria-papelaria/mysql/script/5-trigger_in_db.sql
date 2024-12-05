use livraria_papelaria;

DROP TRIGGER IF EXISTS tr_endereco_is_principal_bi;
DROP TRIGGER IF EXISTS tr_endereco_is_principal_bu;
DROP TRIGGER IF EXISTS tr_endereco_is_principal_bi;
DROP TRIGGER IF EXISTS tr_endereco_is_principal_bu;
DROP TRIGGER IF EXISTS tr_atualizar_estoque;

-- ********************
--      TRIGGERS
-- ********************

-- -----------------------------------------------------
-- Trigger: tr_endereco_is_principal_bi
-- Description: Ensures that each user has only one main address
-- before inserting a new address.
-- -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER IF NOT EXISTS tr_endereco_is_principal_bi
    BEFORE INSERT
    ON app_endereco
    FOR EACH ROW
BEGIN
    -- If the new address is set as principal
    IF NEW.is_principal = 1 THEN
        -- Set all other addresses of the user to not principal
        UPDATE app_endereco
        SET is_principal = 0
        WHERE usuario_id = NEW.usuario_id;
    END IF;
END$$

-- -----------------------------------------------------
-- Trigger: tr_endereco_is_principal_bu
-- Description: Ensures that each user has only one main address
-- before updating an existing address.
-- -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER IF NOT EXISTS tr_endereco_is_principal_bu
    BEFORE UPDATE
    ON app_endereco
    FOR EACH ROW
BEGIN
    -- If the updated address is set as principal
    IF NEW.is_principal = 1 THEN
        -- Set all other addresses of the user to not principal
        UPDATE app_endereco
        SET is_principal = 0
        WHERE usuario_id = NEW.usuario_id
          AND id <> NEW.id;
    END IF;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- Trigger: tr_atualizar_estoque
-- Description: Updates the stock when a purchase is made.
-- -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER IF NOT EXISTS tr_atualizar_estoque
    AFTER INSERT
    ON app_compraproduto
    FOR EACH ROW
BEGIN
    -- Update the stock quantity
    UPDATE app_estoque
    SET quantidade = quantidade - NEW.quantidade
    WHERE produto_id = NEW.produto_id;

    -- Log the stock change
    INSERT INTO stock_log (produto_id, quantidade_anterior, quantidade_alterada, quantidade_nova, motivo)
    VALUES (NEW.produto_id,
            (SELECT quantidade + NEW.quantidade FROM app_estoque WHERE produto_id = NEW.produto_id),
            -NEW.quantidade,
            (SELECT quantidade FROM app_estoque WHERE produto_id = NEW.produto_id),
            'Venda realizada');
END$$

DELIMITER ;