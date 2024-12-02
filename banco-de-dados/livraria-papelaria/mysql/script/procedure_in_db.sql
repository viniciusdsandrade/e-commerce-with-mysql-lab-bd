use livraria_papelaria;

DROP PROCEDURE IF EXISTS sp_processar_compra;
DROP PROCEDURE IF EXISTS sp_aplicar_cupom;
DROP PROCEDURE IF EXISTS sp_total_carrinho;


-- -----------------------------------------------------
-- Procedure: sp_aplicar_cupom
-- Description: Applies a coupon to a purchase, verifying
-- the validity of the coupon.
-- Parameters:
--   p_compra_id BIGINT - ID of the purchase
--   p_cupom_id BIGINT - ID of the coupon
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_aplicar_cupom(
    IN p_compra_id BIGINT,
    IN p_cupom_id BIGINT
)
BEGIN
    DECLARE v_data_atual DATETIME(6);

    SET v_data_atual = NOW();

    -- Check if the coupon is valid
    IF EXISTS (SELECT 1
               FROM app_cupom
               WHERE id = p_cupom_id AND data_inicio <= v_data_atual AND data_fim >= v_data_atual) THEN

        -- Insert into app_cupom_compras table
        INSERT INTO app_cupom_compras (cupom_id, compra_id)
        VALUES (p_cupom_id, p_compra_id);

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cupom inválido ou expirado.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- Procedure: sp_total_carrinho
-- Description: Calculates the total value of a user's cart.
-- Parameters:
--   p_usuario_id INT - ID of the user
--   p_total DECIMAL(10,2) OUT - Output parameter for total value
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_total_carrinho(
    IN p_usuario_id INT,
    OUT p_total DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(cp.quantidade * p.preco)
    INTO p_total
    FROM app_carrinhoproduto cp
             JOIN app_produto p ON cp.produto_id = p.id
    WHERE cp.carrinho_id = p_usuario_id;
END$$

DELIMITER ;