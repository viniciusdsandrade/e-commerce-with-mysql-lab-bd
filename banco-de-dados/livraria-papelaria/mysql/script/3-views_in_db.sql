use livraria_papelaria;


DROP VIEW IF EXISTS vw_produtos_promocoes;
DROP VIEW IF EXISTS vw_historico_compras;
DROP VIEW IF EXISTS vw_estoque_atual;

-- ********************
--       VIEWS
-- ********************

-- -----------------------------------------------------
-- View: vw_produtos_promocoes
-- Description: Displays products with their active promotions,
-- showing original price, discount, and promotional price.
-- -----------------------------------------------------
CREATE OR REPLACE VIEW vw_produtos_promocoes AS
SELECT p.id                    AS produto_id,
       p.nome                  AS produto_nome,
       p.preco                 AS preco_original,
       pp.desconto             AS desconto_promocao,
       (p.preco - pp.desconto) AS preco_promocional,
       pr.nome                 AS promocao_nome,
       pr.data_inicio,
       pr.data_fim
FROM app_produto p
         LEFT JOIN app_promocaoproduto pp ON p.id = pp.produto_id
         LEFT JOIN app_promocao pr ON pp.promocao_id = pr.id
WHERE pr.data_inicio <= NOW()
  AND pr.data_fim >= NOW();

-- -----------------------------------------------------
-- View: vw_historico_compras
-- Description: Presents the purchase history per user,
-- detailing purchased products, quantities, and total values.
-- -----------------------------------------------------
CREATE OR REPLACE VIEW vw_historico_compras AS
SELECT u.id                      AS usuario_id,
       u.username,
       c.id                      AS compra_id,
       c.data_realizada,
       cp.produto_id,
       p.nome                    AS produto_nome,
       cp.quantidade,
       (p.preco * cp.quantidade) AS valor_total
FROM auth_user u
         JOIN app_compra c ON u.id = c.usuario_id
         JOIN app_compraproduto cp ON c.id = cp.compra_id
         JOIN app_produto p ON cp.produto_id = p.id;

-- -----------------------------------------------------
-- View: vw_estoque_atual
-- Description: Shows the current stock level of each product,
-- facilitating monitoring and replenishment.
-- -----------------------------------------------------
CREATE OR REPLACE VIEW vw_estoque_atual AS
SELECT p.id         AS produto_id,
       p.nome       AS produto_nome,
       e.quantidade AS quantidade_em_estoque,
       e.localizacao
FROM app_produto p
         JOIN app_estoque e ON p.id = e.produto_id;



SELECT *
FROM vw_produtos_promocoes;
SELECT *
FROM vw_historico_compras;
SELECT *
FROM vw_estoque_atual;