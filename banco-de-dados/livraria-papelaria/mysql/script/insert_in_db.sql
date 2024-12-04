-- -----------------------------------------------------
-- Insert Script to Populate Tables with Sample Data
-- -----------------------------------------------------
-- Note: This script inserts 5 elements into each table,
-- respecting foreign key constraints and ensuring data consistency.

USE livraria_papelaria;

START TRANSACTION;

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
       (5, 'pbkdf2_sha256$150000$example5$', NULL, 0, 'user5', 'Eve', 'Davis', 'eve@example.com', 0, 1, NOW()),
       (6, 'pbkdf2_sha256$870000$example7$', NULL, 0, 'user7', 'Frank', 'Wilson', 'frank@example.com', 0, 1, NOW()),
        (7, 'pbkdf2_sha256$870000$example8$', NULL, 0, 'user8', 'Grace', 'Martinez', 'grace@example.com', 0, 1, NOW()),
        (8, 'pbkdf2_sha256$870000$example9$', NULL, 0, 'user9', 'Henry', 'Anderson', 'henry@example.com', 0, 1, NOW()),
        (9, 'pbkdf2_sha256$870000$example10$', NULL, 0, 'user10', 'Ivy', 'Thomas', 'ivy@example.com', 0, 1, NOW()),
        (10, 'pbkdf2_sha256$870000$example11$', NULL, 0, 'user11', 'Jack', 'Roberts', 'jack@example.com', 0, 1, NOW()),
        (11, 'pbkdf2_sha256$870000$example12$', NULL, 0, 'user12', 'Kelly', 'Evans', 'kelly@example.com', 0, 1, NOW()),
        (12, 'pbkdf2_sha256$870000$example13$', NULL, 0, 'user13', 'Liam', 'Perez', 'liam@example.com', 0, 1, NOW()),
        (13, 'pbkdf2_sha256$870000$example14$', NULL, 0, 'user14', 'Mia', 'Garcia', 'mia@example.com', 0, 1, NOW()),
        (14, 'pbkdf2_sha256$870000$example15$', NULL, 0, 'user15', 'Noah', 'Rodriguez', 'noah@example.com', 0, 1, NOW()),
        (15, 'pbkdf2_sha256$870000$example16$', NULL, 0, 'user16', 'Olivia', 'Lopez', 'olivia@example.com', 0, 1, NOW()),
        (16, 'pbkdf2_sha256$870000$example17$', NULL, 0, 'user17', 'Peter', 'Hernandez', 'peter@example.com', 0, 1, NOW()),
        (17, 'pbkdf2_sha256$870000$example18$', NULL, 0, 'user18', 'Quinn', 'Gonzalez', 'quinn@example.com', 0, 1, NOW()),
        (18, 'pbkdf2_sha256$870000$example19$', NULL, 0, 'user19', 'Rose', 'Parker', 'rose@example.com', 0, 1, NOW()),
        (19, 'pbkdf2_sha256$870000$example20$', NULL, 0, 'user20', 'Sam', 'Morris', 'sam@example.com', 0, 1, NOW()),
        (20, 'pbkdf2_sha256$870000$example21$', NULL, 0, 'user21', 'Tom', 'Young', 'tom@example.com', 0, 1, NOW()),
       (21, 'pbkdf2_sha256$870000$2IZXgyAwNkEC7SxrWQGSgG$/pXObGzJG2+7LAoaJsORb9Y4j5lfXHGQ0AthGPV+UJc=', NULL, 1,
       'admin', 'Admin', 'Admin', 'admin@example.com', 1, 1, NOW());

-- ********************
-- 2. app_categoria
-- ********************
-- Inserting 5 categories into app_categoria table
INSERT INTO app_categoria (id, nome, tipo)
VALUES (1, 'Suspense', 'Livraria'),
        (2, 'Romance', 'Livraria'),
        (3, 'Ficção Científica', 'Livraria'),
        (4, 'Fantasia', 'Livraria'),
        (5, 'Infantil', 'Livraria'),
        (6, 'Autoajuda', 'Livraria'),
        (7, 'Ciência', 'Livraria'),
        (8, 'História', 'Livraria'),
        (9, 'Biografia', 'Livraria'),
        (10, 'Terror', 'Livraria'),
        (11, 'Papel', 'Papelaria'),
        (12, 'Escrita', 'Papelaria'),
        (13, 'Escola', 'Papelaria'),
        (14, 'Escritório', 'Papelaria'),
        (15, 'Artesanato', 'Papelaria'),
        (16, 'Presentes', 'Papelaria'),
        (17, 'Adesivos', 'Papelaria'),
        (18, 'Decoração', 'Papelaria'),
        (19, 'Placas', 'Papelaria'),
        (20, 'Pôsters', 'Papelaria');



-- ********************
-- 3. app_produto
-- ********************
-- Inserting 5 products into app_produto table
INSERT INTO app_produto (id, nome, preco, descricao, is_ativo)
VALUES 
    (1, 'O Mistério da Casa Abandonada', 29.99, 'Um suspense intrigante sobre uma casa cheia de segredos.', 1),
    (2, 'A Sombra do Assassino', 39.99, 'Um thriller emocionante que vai te prender do início ao fim.', 1),
    (3, 'Amor em Paris', 19.99, 'Uma história de amor inesquecível na cidade mais romântica do mundo.', 1),
    (4, 'Corações Entrelaçados', 24.99, 'Um romance comovente sobre duas almas destinadas a se encontrar.', 1),
    (5, 'Viagem ao Futuro', 34.99, 'Uma aventura de ficção científica que desafia as leis do tempo.', 1),
    (6, 'O Enigma do Espaço', 44.99, 'Uma jornada épica pelo universo em busca de respostas.', 1),
    (7, 'O Reino Encantado', 29.99, 'Uma história de fantasia cheia de magia e criaturas místicas.', 1),
    (8, 'A Espada do Destino', 39.99, 'Uma aventura fantástica sobre um herói em busca de seu destino.', 1),
    (9, 'Aventuras de Joãozinho', 14.99, 'Histórias divertidas e educativas para crianças.', 1),
    (10, 'O Mundo dos Dinossauros', 19.99, 'Uma viagem ao passado para conhecer os gigantes da Terra.', 1),
    (11, 'O Poder do Hábito', 24.99, 'Um guia prático para transformar sua vida através de bons hábitos.', 1),
    (12, 'A Mente Milionária', 29.99, 'Dicas e estratégias para alcançar o sucesso financeiro.', 1),
    (13, 'O Universo em uma Casca de Noz', 34.99, 'Uma introdução fascinante aos mistérios do cosmos.', 1),
    (14, 'A Teoria de Tudo', 39.99, 'Uma exploração das maiores descobertas científicas da humanidade.', 1),
    (15, 'A História do Mundo', 29.99, 'Uma viagem através dos eventos mais importantes da história.', 1),
    (16, 'Guerras Mundiais', 34.99, 'Um relato detalhado dos conflitos que moldaram o mundo moderno.', 1),
    (17, 'A Vida de Einstein', 24.99, 'Uma biografia inspiradora do maior gênio da ciência.', 1),
    (18, 'O Diário de Anne Frank', 29.99, 'O emocionante relato de uma jovem durante a Segunda Guerra Mundial.', 1),
    (19, 'O Terror na Colina', 19.99, 'Uma história de terror que vai te deixar sem dormir.', 1),
    (20, 'A Casa dos Pesadelos', 24.99, 'Um conto assustador sobre uma casa amaldiçoada.', 1),
    (21, 'Papel Sulfite A4', 9.99, 'Pacote com 500 folhas de papel sulfite tamanho A4.', 1),
    (22, 'Papel Fotográfico', 14.99, 'Papel de alta qualidade para impressão de fotos.', 1),
    (23, 'Caneta Esferográfica', 4.99, 'Caneta esferográfica azul de escrita suave.', 1),
    (24, 'Lápis de Cor', 9.99, 'Conjunto com 24 lápis de cor de alta qualidade.', 1),
    (25, 'Caderno Universitário', 19.99, 'Caderno com 200 folhas pautadas para uso escolar.', 1),
    (26, 'Mochila Escolar', 24.99, 'Mochila resistente e espaçosa para uso diário.', 1),
    (27, 'Agenda Executiva', 29.99, 'Agenda de couro para organização pessoal e profissional.', 1),
    (28, 'Grampeador de Mesa', 34.99, 'Grampeador de alta capacidade para uso em escritório.', 1),
    (29, 'Kit de Artesanato', 14.99, 'Conjunto completo para projetos de artesanato.', 1),
    (30, 'Tinta para Tecido', 19.99, 'Tinta de alta qualidade para pintura em tecido.', 1),
    (31, 'Caixa de Presentes', 24.99, 'Caixa decorativa para embalar presentes.', 1),
    (32, 'Papel de Presente', 29.99, 'Rolo de papel de presente com design elegante.', 1),
    (33, 'Adesivos Decorativos', 4.99, 'Conjunto de adesivos para decoração e personalização.', 1),
    (34, 'Adesivos Infantis', 9.99, 'Adesivos coloridos e divertidos para crianças.', 1),
    (35, 'Quadro Decorativo', 19.99, 'Quadro decorativo para embelezar ambientes.', 1),
    (36, 'Vaso de Flores', 24.99, 'Vaso decorativo para flores e plantas.', 1),
    (37, 'Placa Motivacional', 14.99, 'Placa com frases motivacionais para decoração.', 1),
    (38, 'Placa de Aviso', 19.99, 'Placa de aviso para uso em ambientes comerciais.', 1),
    (39, 'Pôster de Filme', 9.99, 'Pôster decorativo de filmes clássicos.', 1),
    (40, 'Pôster de Paisagem', 14.99, 'Pôster com belas paisagens para decoração.', 1);

-- ********************
-- 4. app_categoria_produtos
-- ********************
-- Associating products with categories
INSERT INTO app_categoria_produtos (categoria_id, produto_id)
VALUES 
    (1, 1), (1, 2),
    (2, 3), (2, 4),
    (3, 5), (3, 6),
    (4, 7), (4, 8),
    (5, 9), (5, 10),
    (6, 11), (6, 12),
    (7, 13), (7, 14),
    (8, 15), (8, 16),
    (9, 17), (9, 18),
    (10, 19), (10, 20),
    (11, 21), (11, 22),
    (12, 23), (12, 24),
    (13, 25), (13, 26),
    (14, 27), (14, 28),
    (15, 29), (15, 30),
    (16, 31), (16, 32),
    (17, 33), (17, 34),
    (18, 35), (18, 36),
    (19, 37), (19, 38),
    (20, 39), (20, 40);

-- ********************
-- 5. app_estoque
-- ********************
-- Inserting stock entries for products
INSERT INTO app_estoque (id, quantidade, localizacao, produto_id)
VALUES (1, 100, 'Depósito A', 1),
       (2, 200, 'Depósito B', 2),
       (3, 50, 'Depósito C', 3),
       (4, 30, 'Depósito D', 4),
       (5, 80, 'Depósito E', 5),
       (6, 150, 'Depósito F', 6),
       (7, 120, 'Depósito G', 7),
       (8, 70, 'Depósito H', 8),
       (9, 300, 'Depósito I', 9),
       (10, 250, 'Depósito J', 10),
       (11, 500, 'Depósito K', 11),
       (12, 400, 'Depósito L', 12),
       (13, 100, 'Depósito M', 13),
       (14, 200, 'Depósito N', 14),
       (15, 50, 'Depósito O', 15),
       (16, 30, 'Depósito P', 16),
       (17, 80, 'Depósito Q', 17),
       (18, 150, 'Depósito R', 18),
       (19, 120, 'Depósito S', 19),
       (20, 70, 'Depósito T', 20),
       (21, 1000, 'Depósito U', 21),
       (22, 2000, 'Depósito V', 22),
       (23, 500, 'Depósito W', 23),
       (24, 300, 'Depósito X', 24),
       (25, 800, 'Depósito Y', 25),
       (26, 1500, 'Depósito Z', 26),
       (27, 1200, 'Depósito A1', 27),
       (28, 700, 'Depósito B1', 28),
       (29, 3000, 'Depósito C1', 29),
       (30, 2500, 'Depósito D1', 30),
       (31, 5000, 'Depósito E1', 31),
       (32, 4000, 'Depósito F1', 32),
       (33, 1000, 'Depósito G1', 33),
       (34, 2000, 'Depósito H1', 34),
       (35, 500, 'Depósito I1', 35),
       (36, 300, 'Depósito J1', 36),
       (37, 800, 'Depósito K1', 37),
       (38, 1500, 'Depósito L1', 38),
       (39, 1200, 'Depósito M1', 39),
       (40, 700, 'Depósito N1', 40);

-- ********************
-- 6. app_carrinho
-- ********************
-- Creating carts for users
INSERT INTO app_carrinho (usuario_id)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
       (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

-- ********************
-- 7. app_carrinhoproduto
-- ********************
-- Adding products to users' carts
INSERT INTO app_carrinhoproduto (id, quantidade, carrinho_id, produto_id)
VALUES (1, 2, 1, 1),
       (2, 1, 2, 2),
       (3, 1, 3, 3),
       (4, 1, 4, 4),
       (5, 3, 5, 5),
       (6, 2, 1, 6),
        (7, 1, 2, 7),
        (8, 1, 3, 8),
        (9, 1, 4, 9),
        (10, 2, 5, 10),
        (11, 1, 1, 11),
        (12, 1, 2, 12),
        (13, 1, 3, 13),
        (14, 1, 4, 14),
        (15, 3, 5, 15),
        (16, 2, 1, 16),
        (17, 1, 2, 17),
        (18, 1, 3, 18),
        (19, 1, 4, 19),
        (20, 2, 5, 20);

-- ********************
-- 8. app_listadesejos
-- ********************
-- Creating wishlists for users
INSERT INTO app_listadesejos (usuario_id)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
       (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);

-- ********************
-- 9. app_listadesejos_produtos
-- ********************
-- Adding products to wishlists
INSERT INTO app_listadesejos_produtos (id, listadesejos_id, produto_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5),
       (6, 1, 6),
        (7, 2, 7),
        (8, 3, 8),
        (9, 4, 9),
        (10, 5, 10),
        (11, 1, 11),
        (12, 2, 12),
        (13, 3, 13),
        (14, 4, 14),
        (15, 5, 15),
        (16, 1, 16),
        (17, 2, 17),
        (18, 3, 18),
        (19, 4, 19),
        (20, 5, 20);

-- ********************
-- 9.5. app_formapagamento
-- ********************
-- Adding payment methods for users
INSERT INTO app_formapagamento (id, usuario_id)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
        (11, 1), (12, 2), (13, 3), (14, 4), (15, 5), (16, 6), (17, 7), (18, 8), (19, 9), (20, 10),
        (21, 1), (22, 2), (23, 3), (24, 4), (25, 5), (26, 6), (27, 7), (28, 8), (29, 9), (30, 10),
        (31, 1), (32, 2), (33, 3), (34, 4), (35, 5), (36, 6), (37, 7), (38, 8), (39, 9), (40, 10);


-- ********************
-- 10. app_cartao
-- ********************
-- Adding credit/debit cards for users
INSERT INTO app_cartao (formapagamento_ptr_id, numero, validade, codigo_seguranca, nome_dono, tipo)
VALUES (1, '1234567812345678', '2025-12-31', '123', 'Alice Smith', 'Crédito'),
       (2, '2345678923456789', '2024-11-30', '456', 'Bob Johnson', 'Débito'),
       (3, '3456789034567890', '2026-10-31', '789', 'Carol Williams', 'Crédito'),
       (4, '4567890145678901', '2026-09-30', '012', 'David Brown', 'Débito'),
       (5, '5678901256789012', '2027-08-31', '345', 'Eve Davis', 'Crédito'),
        (6, '6789012367890123', '2027-07-31', '678', 'Frank Wilson', 'Débito'),
        (7, '7890123478901234', '2028-06-30', '901', 'Grace Martinez', 'Crédito'),
        (8, '8901234589012345', '2028-05-31', '234', 'Henry Anderson', 'Débito'),
        (9, '9012345690123456', '2029-04-30', '567', 'Ivy Thomas', 'Crédito'),
        (10, '0123456701234567', '2029-03-31', '890', 'Jack Roberts', 'Débito'),
        (11, '1234567812345678', '2025-12-31', '123', 'Alice Smith', 'Crédito'),
        (12, '2345678923456789', '2024-11-30', '456', 'Bob Johnson', 'Débito'),
        (13, '3456789034567890', '2026-10-31', '789', 'Carol Williams', 'Crédito'),
        (14, '4567890145678901', '2026-09-30', '012', 'David Brown', 'Débito'),
        (15, '5678901256789012', '2027-08-31', '345', 'Eve Davis', 'Crédito'),
        (16, '6789012367890123', '2027-07-31', '678', 'Frank Wilson', 'Débito'),
        (17, '7890123478901234', '2028-06-30', '901', 'Grace Martinez', 'Crédito'),
        (18, '8901234589012345', '2028-05-31', '234', 'Henry Anderson', 'Débito'),
        (19, '9012345690123456', '2029-04-30', '567', 'Ivy Thomas', 'Crédito'),
        (20, '0123456701234567', '2029-03-31', '890', 'Jack Roberts', 'Débito');

-- ********************
-- 11. app_pix
-- ********************
-- Adding PIX keys for users
INSERT INTO app_pix (formapagamento_ptr_id, chave)
VALUES (21, 'alice@example.com'),
       (22, 'bob@example.com'),
       (23, 'carol@example.com'),
       (24, 'david@example.com'),
       (25, 'eve@example.com'),
       (26, 'frank@example.com'),
       (27, 'grace@example.com'),
       (28, 'henry@example.com'),
       (29, 'ivy@example.com'),
       (30, 'jack@example.com'),
       (31, 'alice.smith@pix.com'),
       (32, 'bob.johnson@pix.com'),
       (33, 'carol.williams@pix.com'),
       (34, 'david.brown@pix.com'),
       (35, 'eve.davis@pix.com'),
       (36, 'frank.wilson@pix.com'),
       (37, 'grace.martinez@pix.com'),
       (38, 'henry.anderson@pix.com'),
       (39, 'ivy.thomas@pix.com'),
       (40, 'jack.roberts@pix.com');

-- ********************
-- 12. app_endereco
-- ********************
-- Adding addresses for users
INSERT INTO app_endereco (id, nome, rua, numero, bairro, cidade, estado, cep, complemento, is_principal, usuario_id)
VALUES (1, 'Residencial', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, 1, 1),
       (2, 'Comercial', 'Avenida Paulista', '2000', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Sala 101', 0, 1),
       (3, 'Residencial', 'Rua do Sol', '50', 'Copacabana', 'Rio de Janeiro', 'RJ', '22060-002', NULL, 1, 2),
       (4, 'Residencial', 'Rua da Praia', '300', 'Boa Viagem', 'Recife', 'PE', '51020-010', NULL, 1, 3),
       (5, 'Residencial', 'Rua das Palmeiras', '400', 'Centro', 'Curitiba', 'PR', '80010-000', NULL, 1, 4),
       (6, 'Residencial', 'Avenida Beira Mar', '500', 'Ponta Verde', 'Maceió', 'AL', '57030-000', NULL, 1, 5),
       (7, 'Residencial', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, 1, 6),
       (8, 'Comercial', 'Avenida Paulista', '2000', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Sala 101', 0, 7),
       (9, 'Residencial', 'Rua do Sol', '50', 'Copacabana', 'Rio de Janeiro', 'RJ', '22060-002', NULL, 1, 8),
       (10, 'Residencial', 'Rua da Praia', '300', 'Boa Viagem', 'Recife', 'PE', '51020-010', NULL, 1, 9),
       (11, 'Residencial', 'Rua das Palmeiras', '400', 'Centro', 'Curitiba', 'PR', '80010-000', NULL, 1, 10),
       (12, 'Residencial', 'Avenida Beira Mar', '500', 'Ponta Verde', 'Maceió', 'AL', '57030-000', NULL, 1, 11),
       (13, 'Residencial', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, 1, 12),
       (14, 'Comercial', 'Avenida Paulista', '2000', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Sala 101', 0, 13),
       (15, 'Residencial', 'Rua do Sol', '50', 'Copacabana', 'Rio de Janeiro', 'RJ', '22060-002', NULL, 1, 14),
       (16, 'Residencial', 'Rua da Praia', '300', 'Boa Viagem', 'Recife', 'PE', '51020-010', NULL, 1, 15),
        (17, 'Residencial', 'Rua das Palmeiras', '400', 'Centro', 'Curitiba', 'PR', '80010-000', NULL, 1, 16),
        (18, 'Residencial', 'Avenida Beira Mar', '500', 'Ponta Verde', 'Maceió', 'AL', '57030-000', NULL, 1, 17),
        (19, 'Residencial', 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, 1, 18),
        (20, 'Comercial', 'Avenida Paulista', '2000', 'Bela Vista', 'São Paulo', 'SP', '01310-100', 'Sala 101', 0, 19);

-- ********************
-- 13. app_compra
-- ********************
-- Creating purchase records
INSERT INTO app_compra (id, data_realizada, usuario_id, endereco_id)
VALUES (1, NOW() - INTERVAL 5 DAY, 1, 1),
        (2, NOW() - INTERVAL 4 DAY, 2, 3),
        (3, NOW() - INTERVAL 3 DAY, 3, 4),
        (4, NOW() - INTERVAL 2 DAY, 4, 5),
        (5, NOW() - INTERVAL 1 DAY, 5, 6),
        (6, NOW(), 6, 7),
        (7, NOW() - INTERVAL 5 DAY, 7, 8),
        (8, NOW() - INTERVAL 4 DAY, 8, 9),
        (9, NOW() - INTERVAL 3 DAY, 9, 10),
        (10, NOW() - INTERVAL 2 DAY, 10, 11),
        (11, NOW() - INTERVAL 1 DAY, 11, 12),
        (12, NOW(), 12, 13),
        (13, NOW() - INTERVAL 5 DAY, 13, 14),
        (14, NOW() - INTERVAL 4 DAY, 14, 15),
        (15, NOW() - INTERVAL 3 DAY, 15, 16),
        (16, NOW() - INTERVAL 2 DAY, 16, 17),
        (17, NOW() - INTERVAL 1 DAY, 17, 18),
        (18, NOW(), 18, 19),
        (19, NOW() - INTERVAL 5 DAY, 19, 20),
        (20, NOW() - INTERVAL 4 DAY, 1, 2);


-- ********************
-- 14. app_compraproduto
-- ********************
-- Adding products to purchases
INSERT INTO app_compraproduto (id, quantidade, compra_id, produto_id)
VALUES (1, 2, 1, 1),
       (2, 4, 1, 11),
        (3, 1, 2, 2),
        (4, 3, 2, 12),
        (5, 1, 3, 3),
        (6, 2, 3, 13),
        (7, 1, 4, 4),
        (8, 3, 4, 14),
        (9, 3, 5, 5),
        (10, 1, 5, 15),
        (11, 2, 6, 6),
        (12, 4, 6, 16),
        (13, 1, 7, 7),
        (14, 3, 7, 17),
        (15, 3, 8, 8),
        (16, 1, 8, 18),
        (17, 2, 9, 9),
        (18, 4, 9, 19),
        (19, 1, 10, 10),
        (20, 3, 10, 20),
        (21, 2, 11, 1),
        (22, 4, 11, 11),
        (23, 1, 12, 2),
        (24, 3, 12, 12),
        (25, 1, 13, 3),
        (26, 2, 13, 13),
        (27, 1, 14, 4),
        (28, 3, 14, 14),
        (29, 3, 15, 5),
        (30, 1, 15, 15),
        (31, 2, 16, 6),
        (32, 4, 16, 16),
        (33, 1, 17, 7),
        (34, 3, 17, 17),
        (35, 3, 18, 8),
        (36, 1, 18, 18),
        (37, 2, 19, 9),
        (38, 4, 19, 19),
        (39, 1, 20, 10),
        (40, 3, 20, 20); 


-- ********************
-- 15. app_avaliacao
-- ********************
-- Adding product evaluations
INSERT INTO app_avaliacao (compra_produto_id, nota, comentario)
VALUES (1, '⭐⭐⭐⭐⭐', 'Excelente qualidade!'),
       (2, '⭐⭐⭐⭐', 'Muito bom, recomendo.'),
       (3, '⭐⭐⭐⭐⭐', 'Superou as expectativas.'),
       (4, '⭐⭐⭐', 'Poderia ser melhor.'),
       (5, '⭐⭐⭐⭐⭐', 'Adorei o produto!'),
        (6, '⭐⭐⭐⭐', 'Atendeu às expectativas.'),
        (7, '⭐⭐⭐⭐⭐', 'Produto incrível!'),
        (8, '⭐⭐⭐', 'Poderia ser mais barato.'),
        (9, '⭐⭐⭐⭐⭐', 'Recomendo a todos.'),
        (10, '⭐⭐⭐⭐', 'Ótimo custo-benefício.'),
        (11, '⭐⭐⭐⭐⭐', 'Excelente qualidade!'),
        (12, '⭐⭐⭐⭐', 'Muito bom, recomendo.'),
        (13, '⭐⭐⭐⭐⭐', 'Superou as expectativas.'),
        (14, '⭐⭐⭐', 'Poderia ser melhor.'),
        (15, '⭐⭐⭐⭐⭐', 'Adorei o produto!'),
        (16, '⭐⭐⭐⭐', 'Atendeu às expectativas.'),
        (17, '⭐⭐⭐⭐⭐', 'Produto incrível!'),
        (18, '⭐⭐⭐', 'Poderia ser mais barato.'),
        (19, '⭐⭐⭐⭐⭐', 'Recomendo a todos.'),
        (20, '⭐⭐⭐⭐', 'Ótimo custo-benefício...');

-- ********************
-- 16. app_transportadora
-- ********************
-- Adding transport companies
INSERT INTO app_transportadora (id, nome, cnpj, inscricao_estadual, preco)
VALUES (1, 'Transporte Rápido', '00.000.000/0001-91', '123456789', 1.50),
       (2, 'Entrega Segura', '00.000.000/0002-82', '987654321', 2.00),
       (3, 'Logística Express', '00.000.000/0003-73', '192837465', 1.80),
       (4, 'Correios', '00.000.000/0004-64', '564738291', 1.7),
       (5, 'Entrega Rápida', '00.000.000/0005-55', '918273645', 1.60),
        (6, 'Transportadora Ágil', '00.000.000/0006-46', '374829165', 1.55),
        (7, 'Entrega Expressa', '00.000.000/0007-37', '645372819', 1.75),
        (8, 'Logística Eficiente', '00.000.000/0008-28', '819273645', 1.65),
        (9, 'Transporte Seguro', '00.000.000/0009-19', '465738291', 1.45),
        (10, 'Entrega Econômica', '00.000.000/0010-00', '918374626', 1.40),
        (11, 'Sedex', '00.000.000/0011-91', '374829166', 1.70),
        (12, 'PAC', '00.000.000/0012-82', '645372818', 1.80),
        (13, 'Transportadora Nacional', '00.000.000/0013-73', '819273646', 1.60),
        (14, 'Entrega Local', '00.000.000/0014-64', '465738292', 1.55),
        (15, 'Logística Nacional', '00.000.000/0015-55', '918374627', 1.75),
        (16, 'Transporte Regional', '00.000.000/0016-46', '374829167', 1.65),
        (17, 'Entrega Regional', '00.000.000/0017-37', '645372817', 1.45),
        (18, 'Logística Regional', '00.000.000/0018-28', '819273647', 1.40),
        (19, 'Transportadora Veloz', '00.000.000/0019-19', '465738293', 1.70),
        (20, 'Entrega Boa', '00.000.000/0020-00', '918374625', 1.80);

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
       (5, 'MNO567890', NOW(), NULL, NULL, 'Em trânsito', 5),
       (6, 'PQR678901', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 6),
       (7, 'STU789012', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 7),
       (8, 'VWX890123', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 8),
       (9, 'YZA901234', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 9),
       (10, 'BCD012345', NOW(), NULL, NULL, 'Em trânsito', 10),
       (11, 'EFG123456', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 11),
       (12, 'HIJ234567', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 12),
       (13, 'KLM345678', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 13),
       (14, 'NOP456789', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 14),
       (15, 'PQR567890', NOW(), NULL, NULL, 'Em trânsito', 15),
       (16, 'STU678901', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 16),
       (17, 'VWX789012', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 17),
       (18, 'YZA890123', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 18),
       (19, 'BCD901234', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 19),
       (20, 'EFG012345', NOW(), NULL, NULL, 'Em trânsito', 20),
        (21, 'HIJ123456', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 1),
        (22, 'KLM234567', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 2),
        (23, 'NOP345678', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 3),
        (24, 'PQR456789', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 4),
        (25, 'STU567890', NOW(), NULL, NULL, 'Em trânsito', 5),
        (26, 'VWX678901', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 6),
        (27, 'YZA789012', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 7),
        (28, 'BCD890123', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 8),
        (29, 'EFG901234', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 9),
        (30, 'HIJ012345', NOW(), NULL, NULL, 'Em trânsito', 10),
        (31, 'KLM123456', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 11),
        (32, 'NOP234567', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 12),
        (33, 'PQR345678', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 13),
        (34, 'STU456789', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 14),
        (35, 'VWX567890', NOW(), NULL, NULL, 'Em trânsito', 15),
        (36, 'YZA678901', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 1 DAY, 'Entregue', 16),
        (37, 'BCD789012', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW(), 'Entregue', 17),
        (38, 'EFG890123', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 1 DAY, NULL, 'Em trânsito', 18),
        (39, 'HIJ901234', NOW() - INTERVAL 1 DAY, NULL, NULL, 'Postado', 19),
        (40, 'KLM012345', NOW(), NULL, NULL, 'Em trânsito', 20);

-- ********************
-- 18. app_cupom
-- ********************
-- Adding discount coupons
INSERT INTO app_cupom (id, nome, desconto, data_inicio, data_fim)
VALUES (1, 'PROMO10', 10.00, NOW() - INTERVAL 10 DAY, NOW() + INTERVAL 20 DAY),
       (2, 'PROMO20', 20.00, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 15 DAY),
       (3, 'PROMO30', 30.00, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY),
       (4, 'PROMO40', 40.00, NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 25 DAY),
       (5, 'PROMO50', 50.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 9 DAY),
        (6, 'PROMO60', 60.00, NOW() - INTERVAL 10 DAY, NOW() + INTERVAL 10 DAY),
        (7, 'PROMO70', 70.00, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 15 DAY),
        (8, 'PROMO80', 80.00, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY),
        (9, 'PROMO90', 90.00, NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 25 DAY),
        (10, 'PROMO100', 100.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 9 DAY),
        (11, 'PROMO110', 110.00, NOW() - INTERVAL 10 DAY, NOW() + INTERVAL 10 DAY),
        (12, 'PROMO120', 120.00, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 15 DAY),
        (13, 'PROMO130', 130.00, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY),
        (14, 'PROMO140', 140.00, NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 25 DAY),
        (15, 'PROMO150', 150.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 9 DAY),
        (16, 'PROMO160', 160.00, NOW() - INTERVAL 10 DAY, NOW() + INTERVAL 10 DAY),
        (17, 'PROMO170', 170.00, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 15 DAY),
        (18, 'PROMO180', 180.00, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY),
        (19, 'PROMO190', 190.00, NOW() + INTERVAL 5 DAY, NOW() + INTERVAL 25 DAY),
        (20, 'PROMO200', 200.00, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 9 DAY);

-- ********************
-- 19. app_cupom_compras
-- ********************
-- Applying coupons to purchases
INSERT INTO app_cupom_compras (id, cupom_id, compra_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
        (5, 5, 5),
       (6, 6, 6),
       (7, 7, 7),
       (8, 8, 8),
       (9, 9, 9),
       (10, 10, 10),
       (11, 11, 11),
       (12, 12, 12),
       (13, 13, 13),
       (14, 14, 14),
       (15, 15, 15),
       (16, 16, 16),
       (17, 17, 17),
       (18, 18, 18),
       (19, 19, 19),
       (20, 20, 20);



-- ********************
-- 20. app_promocao
-- ********************
-- Adding promotions
INSERT INTO app_promocao (id, nome, data_inicio, data_fim)
VALUES (1, 'Promoção de Verão', NOW() - INTERVAL 20 DAY, NOW() + INTERVAL 10 DAY),
       (2, 'Promoção de Inverno', NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 30 DAY),
       (3, 'Black Friday', '2024-11-25', '2024-12-10'),
       (4, 'Cyber Monday', '2024-12-01', '2024-12-12'),
       (5, 'Promoção de Natal', '2024-12-20', '2024-12-26'),
        (6, 'Promoção de Ano Novo', '2024-12-27', '2025-01-02'),
        (7, 'Promoção de Verão', NOW() - INTERVAL 20 DAY, NOW() + INTERVAL 10 DAY),
        (8, 'Promoção de Inverno', NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 30 DAY),
        (9, 'Black Friday', '2024-11-25', '2024-12-10'),
        (10, 'Cyber Monday', '2024-12-01', '2024-12-12'),
        (11, 'Promoção de Natal', '2024-12-20', '2024-12-26'),
        (12, 'Promoção de Ano Novo', '2024-12-27', '2025-01-02'),
        (13, 'Promoção de Verão', NOW() - INTERVAL 20 DAY, NOW() + INTERVAL 10 DAY),
        (14, 'Promoção de Inverno', NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 30 DAY),
        (15, 'Black Friday', '2024-11-25', '2024-12-10'),
        (16, 'Cyber Monday', '2024-12-01', '2024-12-12'),
        (17, 'Promoção de Natal', '2024-12-20', '2024-12-26'),
        (18, 'Promoção de Ano Novo', '2024-12-27', '2025-01-02'),
        (19, 'Promoção de Verão', NOW() - INTERVAL 20 DAY, NOW() + INTERVAL 10 DAY),
        (20, 'Promoção de Inverno', NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 30 DAY);


-- ********************
-- 21. app_promocaoproduto
-- ********************
-- Associating products with promotions
INSERT INTO app_promocaoproduto (id, desconto, produto_id, promocao_id)
VALUES (1, 0.50, 1, 1),
       (2, 0.25, 2, 2),
       (3, 0.30, 3, 3),
       (4, 0.90, 4, 4),
       (5, 0.10, 5, 5),
        (6, 0.20, 6, 6),
        (7, 0.50, 7, 7),
        (8, 0.25, 8, 8),
        (9, 0.30, 9, 9),
        (10, 0.90, 10, 10),
        (11, 0.10, 11, 11),
        (12, 0.20, 12, 12),
        (13, 0.50, 13, 13),
        (14, 0.25, 14, 14),
        (15, 0.30, 15, 15),
        (16, 0.90, 16, 16),
        (17, 0.70, 17, 17),
        (18, 0.20, 18, 18),
        (19, 0.50, 19, 19),
        (20, 0.25, 20, 20);

COMMIT;

-- ********************
-- Data Insertion Complete
-- ********************
-- All tables have been populated with 5 sample records each.
-- Foreign key constraints have been respected.
-- The data is consistent and suitable for testing.
