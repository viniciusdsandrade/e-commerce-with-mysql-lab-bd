USE livraria_papelaria;

DROP TABLE IF EXISTS stock_log;

-- -----------------------------------------------------
-- Table: stock_log
-- Description: Logs stock changes, including product ID,
-- previous quantity, quantity changed, new quantity,
-- reason, and timestamp.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS stock_log
(
    log_id              BIGINT AUTO_INCREMENT,
    produto_id          BIGINT       NOT NULL,
    quantidade_anterior INT UNSIGNED NOT NULL,
    quantidade_alterada INT          NOT NULL,
    quantidade_nova     INT UNSIGNED NOT NULL,
    motivo              VARCHAR(255),
    data_hora           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (log_id),

    FOREIGN KEY (produto_id) REFERENCES app_produto (id)
);