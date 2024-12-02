use livraria_papelaria;

DROP PROCEDURE IF EXISTS sp_processar_compra;
DROP PROCEDURE IF EXISTS sp_aplicar_cupom;
DROP PROCEDURE IF EXISTS sp_total_carrinho;


DELIMITER $$

CREATE PROCEDURE sp_processar_compra(
    IN p_usuario_id INT,
    IN p_endereco_id BIGINT,
    IN p_produto_id BIGINT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_compra_id BIGINT;

    START TRANSACTION;

    -- Verifica se há estoque suficiente
    IF (SELECT quantidade FROM app_estoque WHERE produto_id = p_produto_id) >= p_quantidade THEN

        -- Insere na tabela app_compra
        INSERT INTO app_compra (data_realizada, usuario_id, endereco_id)
        VALUES (NOW(), p_usuario_id, p_endereco_id);

        SET v_compra_id = LAST_INSERT_ID();

        -- Insere na tabela app_compraproduto
        INSERT INTO app_compraproduto (quantidade, compra_id, produto_id)
        VALUES (p_quantidade, v_compra_id, p_produto_id);

        -- Atualiza o estoque
        UPDATE app_estoque
        SET quantidade = quantidade - p_quantidade
        WHERE produto_id = p_produto_id;

        COMMIT;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente.';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_aplicar_cupom(
    IN p_compra_id BIGINT,
    IN p_cupom_id BIGINT
)
BEGIN
    DECLARE v_data_atual DATETIME(6);

    SET v_data_atual = NOW();

    -- Verifica se o cupom é válido
    IF EXISTS (SELECT 1
               FROM app_cupom
               WHERE id = p_cupom_id
                 AND data_inicio <= v_data_atual
                 AND data_fim >= v_data_atual) THEN

        -- Insere na tabela app_cupom_compras
        INSERT INTO app_cupom_compras (cupom_id, compra_id)
        VALUES (p_cupom_id, p_compra_id);

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cupom inválido ou expirado.';
    END IF;
END$$

DELIMITER ;


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
