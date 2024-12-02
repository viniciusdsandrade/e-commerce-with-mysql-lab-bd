USE livraria_papelaria;

DROP TABLE IF EXISTS purchase_log;
DROP TABLE IF EXISTS stock_log;
DROP TABLE IF EXISTS user_activity_log;

-- ********************
--     LOG TABLES
-- ********************

-- -----------------------------------------------------
-- Table: purchase_log
-- Description: Logs purchases made, including purchase ID,
-- user ID, date, total value, and timestamp.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS purchase_log
(
    log_id         BIGINT AUTO_INCREMENT,
    compra_id      BIGINT         NOT NULL,
    usuario_id     INT            NOT NULL,
    data_realizada DATETIME(6)    NOT NULL,
    total_compra   DECIMAL(10, 2) NOT NULL,
    log_timestamp  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (log_id),

    FOREIGN KEY (compra_id) REFERENCES app_compra (id),
    FOREIGN KEY (usuario_id) REFERENCES auth_user (id)
);


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

-- -----------------------------------------------------
-- Table: user_activity_log
-- Description: Logs user activities such as login, logout,
-- and other actions.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS user_activity_log
(
    log_id     BIGINT AUTO_INCREMENT,
    usuario_id INT          NOT NULL,
    atividade  VARCHAR(255) NOT NULL,
    data_hora  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (log_id),
    FOREIGN KEY (usuario_id) REFERENCES auth_user (id)
);


SELECT * FROM purchase_log;
SELECT * FROM stock_log;
SELECT * FROM user_activity_log;