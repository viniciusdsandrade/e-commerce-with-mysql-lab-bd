USE db_papelaria_livraria;

DROP TRIGGER IF EXISTS tr_produto_exclusao;
DROP TRIGGER IF EXISTS atualizar_estoque_apos_insercao;
DROP TRIGGER IF EXISTS calcular_preco_unitario_before_insert;
DROP TRIGGER IF EXISTS atualizar_preco_compra_apos_insercao_item;
DROP TRIGGER IF EXISTS tr_produto_preco_historico;

-- Trigger para registrar a exclusão de produtos na tabela de histórico
DELIMITER //
CREATE TRIGGER tr_produto_exclusao
    AFTER DELETE
    ON tb_produto
    FOR EACH ROW
BEGIN
    -- Inserir o produto excluído na tabela de histórico com novo id e id_produto_original
    INSERT INTO tb_produto_excluido (id_produto_original, nome, preco)
    VALUES (OLD.id, OLD.nome, OLD.preco);
END //
DELIMITER ;

-- Trigger para registrar a alteração de preço na tabela de histórico
DELIMITER //
CREATE TRIGGER tr_produto_preco_historico
    BEFORE UPDATE
    ON tb_produto
    FOR EACH ROW
BEGIN
    IF OLD.preco != NEW.preco THEN
        INSERT INTO tb_produto_preco_historico (id_produto, preco_anterior, preco_novo)
        VALUES (OLD.id, OLD.preco, NEW.preco);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER IF NOT EXISTS calcular_preco_unitario_before_insert
    BEFORE INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    DECLARE preco_produto DECIMAL(10, 2);

    -- Obter a quantidade em estoque do produto
    SELECT quantidade
    INTO estoque_atual
    FROM tb_estoque
    WHERE id_produto = NEW.id_produto;

    -- Obter o preço do produto
    SELECT preco
    INTO preco_produto
    FROM tb_produto
    WHERE id = NEW.id_produto;

    -- Verificar se há estoque suficiente
    IF estoque_atual >= NEW.quantidade THEN
        -- Definir o preço unitário como o preço do produto
        SET NEW.quantidade = preco_produto;
    ELSE
        -- Lançar um erro caso não haja estoque suficiente, impedindo a inserção
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
    END IF;
END;
DELIMITER ;

DELIMITER //
CREATE TRIGGER IF NOT EXISTS atualizar_estoque_apos_insercao
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    -- Atualizar o estoque na tabela tb_estoque
    UPDATE tb_estoque
    SET quantidade = quantidade - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;
DELIMITER ;

DELIMITER //
CREATE TRIGGER IF NOT EXISTS atualizar_preco_compra_apos_insercao_item
    AFTER INSERT
    ON tb_compra_produto
    FOR EACH ROW
BEGIN
    -- Atualizar o preço total da compra na tabela tb_compra
    UPDATE tb_compra
    SET preco_total = preco_total + (
        NEW.quantidade * (SELECT preco
                          FROM tb_produto
                          WHERE id = NEW.id_produto))
    WHERE id = NEW.id_compra;
END;
DELIMITER ;
