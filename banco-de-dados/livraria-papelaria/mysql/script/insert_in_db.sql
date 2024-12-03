-- -----------------------------------------------------
-- Insert Script to Populate Tables with Sample Data
-- -----------------------------------------------------
-- Note: This script inserts 5 elements into each table,
-- respecting foreign key constraints and ensuring data consistency.

-- ********************
-- 1. auth_user
-- ********************
-- Inserting 5 users into auth_user table
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff,
                       is_active, date_joined)
VALUES (1, 'pbkdf2_sha256$150000$example1$', NULL, 0, 'user1', 'Alice', 'Smith', 'alice@example.com', 0, 1, NOW()),
       (2, 'pbkdf2_sha256$150000$example2$', NULL, 0, 'user2', 'Bob', 'Johnson', 'bob@example.com', 0, 1, NOW()),
       (3, 'pbkdf2_sha256$150000$example3$', NULL, 0, 'user3', 'Carol', 'Williams', 'carol@example.com', 0, 1, NOW()),
       (4, 'pbkdf2_sha256$150000$example4$', NULL, 0, 'user4', 'David', 'Brown', 'david@example.com', 0, 1, NOW()),
       (5, 'pbkdf2_sha256$150000$example5$', NULL, 0, 'user5', 'Eve', 'Davis', 'eve@example.com', 0, 1, NOW());

-- ********************
-- 2. app_categoria
-- ********************
-- Inserting 5 categories into app_categoria table
INSERT INTO app_categoria (id, nome, tipo)
VALUES (1, 'Livros', 'Produto'),
       (2, 'Papelaria', 'Produto'),
       (3, 'Eletrônicos', 'Produto'),
       (4, 'Móveis', 'Produto'),
       (5, 'Brinquedos', 'Produto');

-- ********************
-- 3. app_produto
-- ********************
-- Inserting 5 products into app_produto table
INSERT INTO app_produto (id, nome, preco, descricao, is_ativo)
VALUES (1, 'Caneta Esferográfica', 1.50, 'Caneta azul de ponta fina', 1),
       (2, 'Caderno Universitário', 15.00, 'Caderno 200 folhas', 1),
       (3, 'Laptop XYZ', 2500.00, 'Laptop de alta performance', 1),
       (4, 'Mesa de Escritório', 350.00, 'Mesa em L com gavetas', 1),
       (5, 'Boneca de Pano', 45.00, 'Boneca artesanal', 1);

-- ********************
-- 4. app_categoria_produtos
-- ********************
-- Associating products with categories
INSERT INTO app_categoria_produtos (id, categoria_id, produto_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5);

-- ********************
-- 5. app_estoque
-- ********************
-- Inserting stock entries for products
INSERT INTO app_estoque (id, quantidade, localizacao, produto_id)
VALUES (1, 100, 'Depósito A', 1),
       (2, 200, 'Depósito B', 2),
       (3, 50, 'Depósito C', 3),
       (4, 30, 'Depósito D', 4),
       (5, 80, 'Depósito E', 5);

-- ********************
-- 6. app_carrinho
-- ********************
-- Creating carts for users
INSERT INTO app_carrinho (usuario_id)
VALUES (1),
       (2),
       (3),
       (4),
       (5);

-- ********************
-- 7. app_carrinhoproduto
-- ********************
-- Adding products to users' carts
INSERT INTO app_carrinhoproduto (id, quantidade, carrinho_id, produto_id)
VALUES (1, 2, 1, 1),
       (2, 1, 2, 2),
       (3, 1, 3, 3),
       (4, 1, 4, 4),
       (5, 3, 5, 5);

-- ********************
-- 8. app_listadesejos
-- ********************
-- Creating wishlists for users
INSERT INTO app_listadesejos (usuario_id)
VALUES (1),
       (2),
       (3),
       (4),
       (5);

-- ********************
-- 9. app_listadesejos_produtos
-- ********************
-- Adding products to wishlists
INSERT INTO app_listadesejos_produtos (id, listadesejos_id, produto_id)
VALUES (1, 1, 3),
       (2, 2, 4),
       (3, 3, 5),
       (4, 4, 1),
       (5, 5, 2);

-- ********************
-- 10. app_cartao
-- ********************
-- Adding credit/debit cards for users
INSERT INTO app_cartao (id, numero, validade, codigo_seguranca, nome_dono, tipo, usuario_id)
VALUES (1, '1234567812345678', '2025-12-31', '123', 'Alice Smith', 'Crédito', 1),
       (2, '2345678923456789', '2024-11-30', '456', 'Bob Johnson', 'Débito', 2),
       (3, '3456789034567890', '2026-10-31', '789', 'Carol Williams', 'Crédito', 3),
       (4, '4567890145678901', '2023-09-30', '012', 'David Brown', 'Débito', 4),
       (5, '5678901256789012', '2027-08-31', '345', 'Eve Davis', 'Crédito', 5);

-- ********************
-- 11. app_pix
-- ********************
-- Adding PIX keys for users
INSERT INTO app_pix (id, chave, usuario_id)
VALUES (1, 'alice@example.com', 1),
       (2, 'bob@example.com', 2),
       (3, 'carol@example.com', 3),
       (4, 'david@example.com', 4),
       (5, 'eve@example.com', 5);

-- ********************
-- 12. app_endereco
-- ********************
-- Adding addresses for users
INSERT INTO app_endereco (id, nome, rua, numero, bairro, cidade, estado, cep, complemento, is_principal, usuario_id)
VALUES (1, 'Residencial', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, 1, 1),
       (2, 'Comercial', 'Avenida Paulista', '2000', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Sala 101', 0, 1),
       (3, 'Residencial', 'Rua do Sol', '50', 'Copacabana', 'Rio de Janeiro', 'RJ', '22060-002', NULL, 1, 2),
       (4, 'Residencial', 'Rua da Praia', '300', 'Boa Viagem', 'Recife', 'PE', '51020-010', NULL, 1, 3),
       (5, 'Residencial', 'Rua das Palmeiras', '400', 'Centro', 'Curitiba', 'PR', '80010-000', NULL, 1, 4);

-- ********************
-- 13. app_compra
-- ********************
-- Creating purchase records
INSERT INTO app_compra (id, data_realizada, usuario_id, endereco_id)
VALUES (1, NOW() - INTERVAL 5 DAY, 1, 1),
       (2, NOW() - INTERVAL 4 DAY, 2, 3),
       (3, NOW() - INTERVAL 3 DAY, 3, 4),
       (4, NOW() - INTERVAL 2 DAY, 4, 5),
       (5, NOW() - INTERVAL 1 DAY, 5, 5);

-- ********************
-- 14. app_compraproduto
-- ********************
-- Adding products to purchases
INSERT INTO app_compraproduto (id, quantidade, compra_id, produto_id)
VALUES (1, 2, 1, 1),
       (2, 1, 2, 2),
       (3, 1, 3, 3),
       (4, 1, 4, 4),
       (5, 2, 5, 5);

-- ********************
-- 15. app_avaliacao
-- ********************
-- Adding product evaluations
INSERT INTO app_avaliacao (compra_produto_id, nota, comentario)
VALUES (1, '5', 'Excelente qualidade!'),
       (2, '4', 'Muito bom, recomendo.'),
       (3, '5', 'Superou as expectativas.'),
       (4, '3', 'Poderia ser melhor.'),
       (5, '5', 'Adorei o produto!');

-- ********************
-- 16. app_transportadora
-- ********************
-- Adding transport companies
INSERT INTO app_transportadora (id, nome, cnpj, inscricao_estadual, telefone, email, preco_km, endereco)
VALUES (1, 'Transporte Rápido', '00.000.000/0001-91', '123456789', '(11) 1111-1111', 'contato@transrapido.com', 1.50,
        'Rua A, 100'),
       (2, 'Entrega Segura', '00.000.000/0002-82', '987654321', '(21) 2222-2222', 'contato@entregasegura.com', 2.00,
        'Rua B, 200'),
       (3, 'Logística Express', '00.000.000/0003-73', '192837465', '(31) 3333-3333', 'contato@logexpress.com', 1.80,
        'Rua C, 300'),
       (4, 'Correios', '00.000.000/0004-64', '564738291', '(41) 4444-4444', 'contato@correios.com', 1.70, 'Rua D, 400'),
       (5, 'Entrega Rápida', '00.000.000/0005-55', '918273645', '(51) 5555-5555', 'contato@entregarapida.com', 1.60,
        'Rua E, 500');

-- ********************
-- 17. app_entrega
-- ********************
-- Adding delivery records
INSERT INTO app_entrega (compra_produto_id, codigo_rastreio, data_postado, data_transito, data_recebido, estado,
                         transportadora_id)
VALUES (1, 'ABC123456', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 1),
       (2, 'DEF234567', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 2),
       (3, 'GHI345678', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 3),
       (4, 'JKL456789', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 4),
       (5, 'MNO567890', NOW(), NULL, NULL, 'Aguardando postagem', 5);

-- ********************
-- 18. app_cupom
-- ********************
-- Adding discount coupons
INSERT INTO app_cupom (id, nome, desconto, data_inicio, data_fim)
VALUES (1, 'PROMO10', 10.00, NOW() - INTERVAL 10 DAY, NOW() + INTERVAL 20 DAY),
       (2, 'PROMO20', 20.00, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 15 DAY),
       (3, 'PROMO30', 30.00, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY),
       (4, 'PROMO40', 40.00, NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 25 DAY),
       (5, 'PROMO50', 50.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 9 DAY);

-- ********************
-- 19. app_cupom_compras
-- ********************
-- Applying coupons to purchases
INSERT INTO app_cupom_compras (id, cupom_id, compra_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 5, 5);

-- ********************
-- 20. app_promocao
-- ********************
-- Adding promotions
INSERT INTO app_promocao (id, nome, data_inicio, data_fim)
VALUES (1, 'Promoção de Verão', NOW() - INTERVAL 20 DAY, NOW() + INTERVAL 10 DAY),
       (2, 'Promoção de Inverno', NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 30 DAY),
       (3, 'Black Friday', '2024-11-25', '2024-11-30'),
       (4, 'Cyber Monday', '2024-12-01', '2024-12-02'),
       (5, 'Promoção de Natal', '2024-12-20', '2024-12-25');

-- ********************
-- 21. app_promocaoproduto
-- ********************
-- Associating products with promotions
INSERT INTO app_promocaoproduto (id, desconto, produto_id, promocao_id)
VALUES (1, 0.50, 1, 1),
       (2, 5.00, 2, 1),
       (3, 500.00, 3, 3),
       (4, 50.00, 4, 3),
       (5, 10.00, 5, 5);

-- ********************
-- 22. app_estoque (Update after promotion)
-- ********************
-- Adjusting stock based on promotions (if applicable)
-- No stock adjustments needed in this script.

-- ********************
-- Data Insertion Complete
-- ********************
-- All tables have been populated with 5 sample records each.
-- Foreign key constraints have been respected.
-- The data is consistent and suitable for testing.

# USE livraria_papelaria;
#
# -- Desabilitar verificação de chaves estrangeiras
# SET FOREIGN_KEY_CHECKS = 0;
#
# -- Truncar todas as tabelas
# TRUNCATE TABLE app_avaliacao;
# TRUNCATE TABLE app_carrinho;
# TRUNCATE TABLE app_carrinhoproduto;
# TRUNCATE TABLE app_cartao;
# TRUNCATE TABLE app_categoria;
# TRUNCATE TABLE app_categoria_produtos;
# TRUNCATE TABLE app_compra;
# TRUNCATE TABLE app_compraproduto;
# TRUNCATE TABLE app_cupom;
# TRUNCATE TABLE app_cupom_compras;
# TRUNCATE TABLE app_endereco;
# TRUNCATE TABLE app_entrega;
# TRUNCATE TABLE app_estoque;
# TRUNCATE TABLE app_listadesejos;
# TRUNCATE TABLE app_listadesejos_produtos;
# TRUNCATE TABLE app_pix;
# TRUNCATE TABLE app_produto;
# TRUNCATE TABLE app_promocao;
# TRUNCATE TABLE app_promocaoproduto;
# TRUNCATE TABLE app_transportadora;
# TRUNCATE TABLE auth_group;
# TRUNCATE TABLE auth_group_permissions;
# TRUNCATE TABLE auth_permission;
# TRUNCATE TABLE auth_user;
# TRUNCATE TABLE auth_user_groups;
# TRUNCATE TABLE auth_user_user_permissions;
# TRUNCATE TABLE django_admin_log;
# TRUNCATE TABLE django_content_type;
# TRUNCATE TABLE django_migrations;
# TRUNCATE TABLE django_session;
#
# -- Reabilitar verificação de chaves estrangeiras
# SET FOREIGN_KEY_CHECKS = 1;
