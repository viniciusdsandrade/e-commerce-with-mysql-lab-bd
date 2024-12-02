use livraria_papelaria;

INSERT INTO django_content_type (id, app_label, model)
VALUES (24, 'app', 'novo_modelo1'),
       (25, 'app', 'novo_modelo2'),
       (26, 'app', 'novo_modelo3'),
       (27, 'app', 'novo_modelo4'),
       (28, 'app', 'novo_modelo5');

INSERT INTO auth_group (id, name)
VALUES (1, 'Administradores'),
       (2, 'Clientes'),
       (3, 'Vendedores'),
       (4, 'Suporte'),
       (5, 'Gerentes');


INSERT INTO auth_permission (id, name, content_type_id, codename)
VALUES (93, 'Can approve orders', 9, 'approve_orders'),
       (94, 'Can ship orders', 9, 'ship_orders'),
       (95, 'Can refund orders', 9, 'refund_orders'),
       (96, 'Can view reports', 1, 'view_reports'),
       (97, 'Can manage inventory', 19, 'manage_inventory');


INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff,
                       is_active, date_joined)
VALUES (1, 'pbkdf2_sha256$150000$abc123...', NULL, 1, 'admin', 'Admin', 'User', 'admin@example.com', 1, 1,
        '2024-12-02 10:00:00'),
       (2, 'pbkdf2_sha256$150000$def456...', NULL, 0, 'cliente1', 'Cliente', 'Um', 'cliente1@example.com', 0, 1,
        '2024-12-02 10:05:00'),
       (3, 'pbkdf2_sha256$150000$ghi789...', NULL, 0, 'vendedor1', 'Vendedor', 'Um', 'vendedor1@example.com', 1, 1,
        '2024-12-02 10:10:00'),
       (4, 'pbkdf2_sha256$150000$jkl012...', NULL, 0, 'suporte1', 'Suporte', 'Um', 'suporte1@example.com', 0, 1,
        '2024-12-02 10:15:00'),
       (5, 'pbkdf2_sha256$150000$mno345...', NULL, 0, 'gerente1', 'Gerente', 'Um', 'gerente1@example.com', 1, 1,
        '2024-12-02 10:20:00');


INSERT INTO app_categoria (id, nome, tipo)
VALUES (1, 'Livros', 'Produto'),
       (2, 'Papelaria', 'Produto'),
       (3, 'Eletrônicos', 'Produto'),
       (4, 'Brinquedos', 'Produto'),
       (5, 'Moda', 'Produto');


INSERT INTO app_produto (id, nome, preco, descricao, is_ativo)
VALUES (1, 'Livro A', 29.90, 'Descrição do Livro A', 1),
       (2, 'Caderno 100 folhas', 15.50, 'Caderno espiral 100 folhas', 1),
       (3, 'Caneta Esferográfica', 2.99, 'Caneta azul esferográfica', 1),
       (4, 'Mouse Óptico', 25.00, 'Mouse sem fio óptico', 1),
       (5, 'Boneca de Pelúcia', 19.99, 'Boneca de pelúcia macia', 1);


INSERT INTO app_promocao (id, nome, data_inicio, data_fim)
VALUES (1, 'Black Friday', '2024-11-25 00:00:00', '2024-11-30 23:59:59'),
       (2, 'Cyber Monday', '2024-12-02 00:00:00', '2024-12-02 23:59:59'),
       (3, 'Natal', '2024-12-20 00:00:00', '2024-12-26 23:59:59'),
       (4, 'Ano Novo', '2024-12-31 00:00:00', '2025-01-01 23:59:59'),
       (5, 'Volta às Aulas', '2024-01-10 00:00:00', '2024-01-20 23:59:59');


INSERT INTO app_transportadora (id, nome, cnpj, inscricao_estadual, telefone, email, preco_km, endereco)
VALUES (1, 'Transportadora A', '12.345.678/0001-99', '123456789', '(11) 1234-5678', 'contato@transportea.com.br', 2.50,
        'Rua A, 123'),
       (2, 'Transportadora B', '98.765.432/0001-11', '987654321', '(21) 8765-4321', 'contato@transporteb.com.br', 3.00,
        'Avenida B, 456'),
       (3, 'Transportadora C', '11.222.333/0001-44', '112233445', '(31) 1357-2468', 'contato@transportec.com.br', 2.75,
        'Praça C, 789'),
       (4, 'Transportadora D', '55.666.777/0001-88', '556677889', '(41) 2468-1357', 'contato@transported.com.br', 3.25,
        'Alameda D, 101'),
       (5, 'Transportadora E', '99.888.777/0001-66', '998877665', '(51) 1122-3344', 'contato@transportee.com.br', 2.60,
        'Travessa E, 202');


INSERT INTO app_endereco (id, nome, rua, numero, bairro, cidade, estado, cep, complemento, is_principal, usuario_id)
VALUES (1, 'Casa', 'Rua das Flores', '100', 'Jardim', 'São Paulo', 'SP', '01000-000', 'Apto 101', 1, 2),
       (2, 'Trabalho', 'Avenida Central', '200', 'Centro', 'Rio de Janeiro', 'RJ', '20000-000', 'Sala 202', 0, 2),
       (3, 'Apartamento', 'Rua Secundária', '300', 'Bairro Novo', 'Belo Horizonte', 'MG', '30000-000', 'Bloco B', 1, 3),
       (4, 'Cobertura', 'Avenida das Américas', '400', 'Barra', 'Rio de Janeiro', 'RJ', '22000-000', 'Cobertura', 0, 4),
       (5, 'Loja', 'Rua Comercial', '500', 'Comércio', 'Curitiba', 'PR', '80000-000', 'Loja 5', 1, 5);


INSERT INTO app_compra (id, data_realizada, usuario_id, endereco_id)
VALUES (1, '2024-12-01 10:30:00', 2, 1),
       (2, '2024-12-01 11:00:00', 3, 3),
       (3, '2024-12-01 12:15:00', 4, 4),
       (4, '2024-12-01 13:45:00', 5, 5),
       (5, '2024-12-01 14:20:00', 2, 2);


INSERT INTO app_compraproduto (id, quantidade, compra_id, produto_id)
VALUES (1, 2, 1, 1),
       (2, 5, 1, 3),
       (3, 1, 2, 4),
       (4, 3, 3, 2),
       (5, 4, 4, 5);


INSERT INTO app_avaliacao (compra_produto_id, nota, comentario)
VALUES (1, '5', 'Excelente produto!'),
       (2, '4', 'Boa qualidade.'),
       (3, '3', 'Produto mediano.'),
       (4, '2', 'Não atendeu minhas expectativas.'),
       (5, '1', 'Produto de baixa qualidade.');


INSERT INTO app_carrinho (usuario_id)
VALUES (2),
       (3),
       (4),
       (5),
       (2);


INSERT INTO app_carrinho (usuario_id)
VALUES (2),
       (3),
       (4),
       (5),
       (2);


INSERT INTO app_carrinhoproduto (id, quantidade, carrinho_id, produto_id)
VALUES (1, 1, 1, 2),
       (2, 3, 1, 3),
       (3, 2, 2, 1),
       (4, 4, 3, 5),
       (5, 1, 4, 4);


INSERT INTO app_cartao (id, numero, validade, codigo_seguranca, nome_dono, tipo, usuario_id)
VALUES (1, '4111111111111111', '2026-12-31', '123', 'Cliente Um', 'Visa', 2),
       (2, '5500000000000004', '2025-11-30', '456', 'Vendedor Um', 'Master', 3),
       (3, '340000000000009', '2027-10-31', '789', 'Suporte Um', 'Amex', 4),
       (4, '30000000000004', '2024-09-30', '012', 'Gerente Um', 'Diners', 5),
       (5, '6011000000000004', '2028-08-31', '345', 'Cliente Dois', 'Discover', 2);


INSERT INTO app_cupom (id, nome, desconto, data_inicio, data_fim)
VALUES (1, 'CUPOM10', 10.00, '2024-12-01 00:00:00', '2024-12-31 23:59:59'),
       (2, 'CUPOM20', 20.00, '2024-12-05 00:00:00', '2024-12-25 23:59:59'),
       (3, 'CUPOM15', 15.00, '2024-12-10 00:00:00', '2024-12-20 23:59:59'),
       (4, 'CUPOM5', 5.00, '2024-12-15 00:00:00', '2024-12-22 23:59:59'),
       (5, 'CUPOM25', 25.00, '2024-12-18 00:00:00', '2024-12-28 23:59:59');


INSERT INTO app_cupom_compras (id, cupom_id, compra_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5);


INSERT INTO app_estoque (id, quantidade, localizacao, produto_id)
VALUES (1, 50, 'A1', 1),
       (2, 100, 'B2', 2),
       (3, 75, 'C3', 3),
       (4, 60, 'D4', 4),
       (5, 30, 'E5', 5);


INSERT INTO app_listadesejos (usuario_id)
VALUES (2),
       (3),
       (4),
       (5),
       (2);


INSERT INTO app_listadesejos_produtos (id, listadesejos_id, produto_id)
VALUES (1, 1, 1),
       (2, 1, 3),
       (3, 2, 2),
       (4, 3, 4),
       (5, 4, 5);


INSERT INTO app_pix (id, chave, usuario_id)
VALUES (1, 'cliente1@pix', 2),
       (2, 'vendedor1@pix', 3),
       (3, 'suporte1@pix', 4),
       (4, 'gerente1@pix', 5),
       (5, 'cliente2@pix', 2);


INSERT INTO app_promocaoproduto (id, desconto, produto_id, promocao_id)
VALUES (1, 5.00, 1, 1),
       (2, 10.00, 2, 2),
       (3, 15.00, 3, 3),
       (4, 20.00, 4, 4),
       (5, 25.00, 5, 5);


INSERT INTO app_entrega (compra_produto_id, codigo_rastreio, data_postado, data_transito, data_recebido, estado,
                         transportadora_id)
VALUES (1, 'RASTREIO123', '2024-12-01 11:00:00', '2024-12-02 12:00:00', '2024-12-03 15:00:00', 'Entregue', 1),
       (2, 'RASTREIO456', '2024-12-01 12:00:00', '2024-12-02 13:00:00', '2024-12-03 16:00:00', 'Entregue', 2),
       (3, 'RASTREIO789', '2024-12-01 13:00:00', '2024-12-02 14:00:00', '2024-12-03 17:00:00', 'Entregue', 3),
       (4, 'RASTREIO012', '2024-12-01 14:00:00', '2024-12-02 15:00:00', '2024-12-03 18:00:00', 'Entregue', 4),
       (5, 'RASTREIO345', '2024-12-01 15:00:00', '2024-12-02 16:00:00', '2024-12-03 19:00:00', 'Entregue', 5);


INSERT INTO auth_user_groups (id, user_id, group_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5);


INSERT INTO auth_user_user_permissions (id, user_id, permission_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 5);


INSERT INTO django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id,
                              user_id)
VALUES (1, '2024-12-01 10:35:00', '1', 'Compra 1', 1, 'Adicionado no carrinho', 9, 1),
       (2, '2024-12-01 11:05:00', '2', 'Produto A', 2, 'Alterado preço', 10, 1),
       (3, '2024-12-01 12:20:00', '3', 'Categoria Livros', 3, 'Deletado categoria', 20, 1),
       (4, '2024-12-01 13:50:00', '4', 'Promoção Black Friday', 4, 'Visualização de promoção', 11, 1),
       (5, '2024-12-01 14:25:00', '5', 'Transportadora A', 1, 'Adicionado nova transportadora', 12, 1);


INSERT INTO django_session (session_key, session_data, expire_date)
VALUES ('ABC123XYZ456', 'session_data_1', '2024-12-03 10:00:00'),
       ('DEF456XYZ789', 'session_data_2', '2024-12-04 11:00:00'),
       ('GHI789XYZ012', 'session_data_3', '2024-12-05 12:00:00'),
       ('JKL012XYZ345', 'session_data_4', '2024-12-06 13:00:00'),
       ('MNO345XYZ678', 'session_data_5', '2024-12-07 14:00:00');


INSERT INTO django_migrations (id, app, name, applied)
VALUES (20, 'app', '0002_nova_migracao', '2024-12-02 15:00:00'),
       (21, 'app', '0003_nova_migracao', '2024-12-02 16:00:00'),
       (22, 'app', '0004_nova_migracao', '2024-12-02 17:00:00'),
       (23, 'app', '0005_nova_migracao', '2024-12-02 18:00:00'),
       (24, 'app', '0006_nova_migracao', '2024-12-02 19:00:00');
