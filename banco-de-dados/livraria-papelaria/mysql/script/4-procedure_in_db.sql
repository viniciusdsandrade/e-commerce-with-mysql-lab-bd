USE livraria_papelaria;

DROP PROCEDURE IF EXISTS sp_processar_compra;
DROP PROCEDURE IF EXISTS sp_aplicar_cupom;
DROP PROCEDURE IF EXISTS sp_total_carrinho;
DROP PROCEDURE IF EXISTS sp_insert_endereco;
DROP PROCEDURE IF EXISTS sp_update_endereco;

-- -----------------------------------------------------
-- Procedure: sp_aplicar_cupom
-- Description: Aplica um cupom a uma compra, verificando
--              a validade do cupom.
-- Parameters:
--   p_compra_id BIGINT - ID da compra
--   p_cupom_id BIGINT - ID do cupom
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- Procedure: sp_total_carrinho
-- Description: Calcula o valor total do carrinho de um usuário.
-- Parameters:
--   p_usuario_id INT - ID do usuário
--   p_total DECIMAL(10,2) OUT - Parâmetro de saída para o valor total
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_total_carrinho(
    IN p_usuario_id INT,
    OUT p_total DECIMAL(10, 2)
)
BEGIN
    SELECT IFNULL(SUM(cp.quantidade * p.preco), 0)
    INTO p_total
    FROM app_carrinhoproduto cp
             JOIN app_produto p ON cp.produto_id = p.id
    WHERE cp.carrinho_id = p_usuario_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- Procedure: sp_insert_endereco
-- Description: Insere um novo endereço para um usuário, definindo
--              se é o endereço principal.
-- Parameters:
--   p_nome VARCHAR(20) - Nome do endereço
--   p_rua VARCHAR(100) - Rua
--   p_numero VARCHAR(8) - Número
--   p_bairro VARCHAR(100) - Bairro
--   p_cidade VARCHAR(100) - Cidade
--   p_estado VARCHAR(100) - Estado
--   p_cep VARCHAR(20) - CEP
--   p_complemento VARCHAR(50) - Complemento
--   p_is_principal TINYINT(1) - Indica se é o endereço principal (1) ou não (0)
--   p_usuario_id INT - ID do usuário
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_insert_endereco(
    IN p_nome VARCHAR(20),
    IN p_rua VARCHAR(100),
    IN p_numero VARCHAR(8),
    IN p_bairro VARCHAR(100),
    IN p_cidade VARCHAR(100),
    IN p_estado VARCHAR(100),
    IN p_cep VARCHAR(20),
    IN p_complemento VARCHAR(50),
    IN p_is_principal TINYINT(1),
    IN p_usuario_id INT
)
BEGIN
    START TRANSACTION;

    IF p_is_principal = 1 THEN
        -- Define todos os outros endereços como não principais
        UPDATE app_endereco
        SET is_principal = 0
        WHERE usuario_id = p_usuario_id;
    END IF;

    -- Insere o novo endereço
    INSERT INTO app_endereco (nome, rua, numero, bairro, cidade, estado, cep, complemento, is_principal, usuario_id)
    VALUES (p_nome, p_rua, p_numero, p_bairro, p_cidade, p_estado, p_cep, p_complemento, p_is_principal, p_usuario_id);
    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- Procedure: sp_update_endereco
-- Description: Atualiza um endereço existente de um usuário, definindo
--              se é o endereço principal.
-- Parameters:
--   p_id BIGINT - ID do endereço a ser atualizado
--   p_nome VARCHAR(20) - Nome do endereço
--   p_rua VARCHAR(100) - Rua
--   p_numero VARCHAR(8) - Número
--   p_bairro VARCHAR(100) - Bairro
--   p_cidade VARCHAR(100) - Cidade
--   p_estado VARCHAR(100) - Estado
--   p_cep VARCHAR(20) - CEP
--   p_complemento VARCHAR(50) - Complemento
--   p_is_principal TINYINT(1) - Indica se é o endereço principal (1) ou não (0)
--   p_usuario_id INT - ID do usuário
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE sp_update_endereco(
    IN p_id BIGINT,
    IN p_nome VARCHAR(20),
    IN p_rua VARCHAR(100),
    IN p_numero VARCHAR(8),
    IN p_bairro VARCHAR(100),
    IN p_cidade VARCHAR(100),
    IN p_estado VARCHAR(100),
    IN p_cep VARCHAR(20),
    IN p_complemento VARCHAR(50),
    IN p_is_principal TINYINT(1),
    IN p_usuario_id INT
)
BEGIN
    START TRANSACTION;

    IF p_is_principal = 1 THEN
        -- Define todos os outros endereços como não principais
        UPDATE app_endereco
        SET is_principal = 0
        WHERE usuario_id = p_usuario_id
          AND id <> p_id;
    END IF;

    -- Atualiza o endereço especificado
    UPDATE app_endereco
    SET nome         = p_nome,
        rua          = p_rua,
        numero       = p_numero,
        bairro       = p_bairro,
        cidade       = p_cidade,
        estado       = p_estado,
        cep          = p_cep,
        complemento  = p_complemento,
        is_principal = p_is_principal
    WHERE id = p_id;
    COMMIT;
END$$

DELIMITER ;
