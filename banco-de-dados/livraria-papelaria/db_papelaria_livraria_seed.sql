USE db_papelaria_livraria;

-- Inserções na tabela de Transportadoras
INSERT INTO tb_transportadoras (nome, preco_por_km, CNPJ, inscricao_estadual, telefone, email, endereco)
VALUES ('Transportadora Alpha', 5.00, '12.345.678/0001-00', '1234567890', '(11) 98765-4321', 'alpha@transportadora.com',
        'Rua A, 123'),
       ('Transportadora Beta', 6.50, '23.456.789/0001-01', '2345678901', '(11) 99876-5432', 'beta@transportadora.com',
        'Rua B, 456'),
       ('Transportadora Gama', 4.75, '34.567.890/0001-02', '3456789012', '(11) 98765-3210', 'gama@transportadora.com',
        'Rua C, 789'),
       ('Transportadora Delta', 5.25, '45.678.901/0001-03', '4567890123', '(11) 98765-6543', 'delta@transportadora.com',
        'Rua D, 012'),
       ('Transportadora Epsilon', 6.00, '56.789.012/0001-04', '5678901234', '(11) 98765-9876',
        'epsilon@transportadora.com', 'Rua E, 345'),
       ('Transportadora Zeta', 5.80, '67.890.123/0001-05', '6789012345', '(11) 98765-6543', 'zeta@transportadora.com',
        'Rua F, 678'),
       ('Transportadora Eta', 7.00, '78.901.234/0001-06', '7890123456', '(11) 98765-3210', 'eta@transportadora.com',
        'Rua G, 901'),
       ('Transportadora Theta', 4.95, '89.012.345/0001-07', '8901234567', '(11) 98765-0987', 'theta@transportadora.com',
        'Rua H, 234'),
       ('Transportadora Iota', 5.10, '90.123.456/0001-08', '9012345678', '(11) 98765-8765', 'iota@transportadora.com',
        'Rua I, 567'),
       ('Transportadora Kappa', 6.20, '01.234.567/0001-09', '0123456789', '(11) 98765-6543', 'kappa@transportadora.com',
        'Rua J, 890');

-- Inserções na tabela de Usuários
INSERT INTO tb_usuarios (nome, CPF, telefone, email, senha, email_de_recuperacao)
VALUES ('João Silva', '123.456.789-00', '(11) 91234-5678', 'joao@exemplo.com', 'senha123',
        'joao.recuperacao@exemplo.com'),
       ('Maria Oliveira', '234.567.890-11', '(21) 92345-6789', 'maria@exemplo.com', 'senha456',
        'maria.recuperacao@exemplo.com'),
       ('José Santos', '345.678.901-22', '(31) 93456-7890', 'jose@exemplo.com', 'senha789',
        'jose.recuperacao@exemplo.com'),
       ('Ana Souza', '456.789.012-33', '(41) 94567-8901', 'ana@exemplo.com', 'senha012', 'ana.recuperacao@exemplo.com'),
       ('Pedro Lima', '567.890.123-44', '(51) 95678-9012', 'pedro@exemplo.com', 'senha345',
        'pedro.recuperacao@exemplo.com'),
       ('Paula Costa', '678.901.234-55', '(61) 96789-0123', 'paula@exemplo.com', 'senha678',
        'paula.recuperacao@exemplo.com'),
       ('Carlos Pereira', '789.012.345-66', '(71) 97890-1234', 'carlos@exemplo.com', 'senha901',
        'carlos.recuperacao@exemplo.com'),
       ('Julia Melo', '890.123.456-77', '(81) 98901-2345', 'julia@exemplo.com', 'senha234',
        'julia.recuperacao@exemplo.com'),
       ('Roberto Almeida', '901.234.567-88', '(91) 99012-3456', 'roberto@exemplo.com', 'senha567',
        'roberto.recuperacao@exemplo.com'),
       ('Carla Fernandes', '012.345.678-99', '(11) 91123-4567', 'carla@exemplo.com', 'senha890',
        'carla.recuperacao@exemplo.com');

-- Inserindo dados na tabela tb_forma_de_pagamento
INSERT INTO tb_forma_de_pagamento (id_usuario, forma_pagamento)
VALUES (1, 'CARTAO_CREDITO'),
       (2, 'PIX'),
       (3, 'BOLETO'),
       (4, 'CARTAO_DEBITO'),
       (5, 'TRANSFERENCIA'),
       (6, 'CARTAO_CREDITO'),
       (7, 'PIX'),
       (8, 'BOLETO'),
       (9, 'TRANSFERENCIA'),
       (10, 'CARTAO_DEBITO');

-- Inserções na tabela de Endereços dos Usuários
INSERT INTO tb_enderecos (id_usuario, rua, numero, bairro, cidade, estado, CEP, complemento, is_principal)
VALUES (1, 'Rua A', '123', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, TRUE),
       (2, 'Rua B', '456', 'Jardim', 'Rio de Janeiro', 'RJ', '02000-000', NULL, TRUE),
       (3, 'Rua C', '789', 'Vila', 'Belo Horizonte', 'MG', '03000-000', NULL, TRUE),
       (4, 'Rua D', '012', 'Centro', 'Curitiba', 'PR', '04000-000', NULL, TRUE),
       (5, 'Rua E', '345', 'Bairro', 'Porto Alegre', 'RS', '05000-000', NULL, TRUE),
       (6, 'Rua F', '678', 'Centro', 'Brasília', 'DF', '06000-000', NULL, TRUE),
       (7, 'Rua G', '901', 'Jardim', 'Salvador', 'BA', '07000-000', NULL, TRUE),
       (8, 'Rua H', '234', 'Vila', 'Fortaleza', 'CE', '08000-000', NULL, TRUE),
       (9, 'Rua I', '567', 'Centro', 'Manaus', 'AM', '09000-000', NULL, TRUE),
       (10, 'Rua J', '890', 'Bairro', 'Recife', 'PE', '10000-000', NULL, TRUE);

-- Inserções na tabela de Produtos
INSERT INTO tb_produtos (nome, preco, descricao)
VALUES ('Caneta Azul', 2.50, 'Caneta esferográfica azul'),
       ('Lápis HB', 1.00, 'Lápis de madeira HB'),
       ('Caderno 100 folhas', 10.00, 'Caderno universitário de 100 folhas'),
       ('Borracha Branca', 0.75, 'Borracha branca para lápis'),
       ('Marcador de Texto', 3.50, 'Marcador de texto amarelo'),
       ('Corretivo Líquido', 5.00, 'Corretivo líquido branco'),
       ('Tesoura Escolar', 7.00, 'Tesoura escolar sem ponta'),
       ('Régua 30cm', 4.00, 'Régua de plástico 30cm'),
       ('Apontador Duplo', 1.50, 'Apontador duplo com depósito'),
       ('Cola Bastão', 3.00, 'Cola bastão 10g');

-- Inserções na tabela de Estoque dos Produtos
INSERT INTO tb_estoque_produto (id_produto, quantidade, localizacao)
VALUES (1, 100, 'Prateleira A1'),
       (2, 200, 'Prateleira B2'),
       (3, 150, 'Prateleira C3'),
       (4, 300, 'Prateleira D4'),
       (5, 250, 'Prateleira E5'),
       (6, 120, 'Prateleira F6'),
       (7, 180, 'Prateleira G7'),
       (8, 160, 'Prateleira H8'),
       (9, 220, 'Prateleira I9'),
       (10, 140, 'Prateleira J10');

-- Inserções na tabela de Categorias
INSERT INTO tb_categorias (nome)
VALUES ('Material Escolar'),
       ('Papelaria'),
       ('Escritório'),
       ('Tecnologia'),
       ('Brinquedos'),
       ('Livros'),
       ('Jogos'),
       ('Decoração'),
       ('Artigos de Festa'),
       ('Presentes');

-- Inserções na tabela de Produtos e Categorias
INSERT INTO tb_produtos_categorias (id_produto, id_categoria)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 2),
       (5, 2),
       (6, 3),
       (7, 3),
       (8, 3),
       (9, 4),
       (10, 4);

-- Inserções na tabela de Carrinho de Compras
INSERT INTO tb_carrinho (id_usuario)
VALUES (1),
       (2),
       (3),
       (4),
       (5),
       (6),
       (7),
       (8),
       (9),
       (10);

-- Inserções na tabela de Carrinho de Compras e Produtos
INSERT INTO tb_carrinho_produtos (id_carrinho, id_produto, quantidade)
VALUES (1, 1, 2),
       (2, 2, 3),
       (3, 3, 1),
       (4, 4, 5),
       (5, 5, 4),
       (6, 6, 2),
       (7, 7, 6),
       (8, 8, 7),
       (9, 9, 3),
       (10, 10, 1);

-- Inserindo dados na tabela tb_cupons
INSERT INTO tb_cupons (nome, desconto, data_inicio, data_fim)
VALUES ('Cupom1', 5.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom2', 10.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom3', 15.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom4', 20.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom5', 25.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom6', 30.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom7', 35.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom8', 40.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom9', 45.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Cupom10', 50.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');


-- Inserindo dados na tabela tb_compras com o campo forma_pagamento e id_cupom
INSERT INTO tb_compras (data_compra, id_usuario, id_endereco, id_transportadora, forma_pagamento, id_cupom)
VALUES ('2024-08-01 10:00:00', 1, 1, 1, 'CARTAO_CREDITO', 1),
       ('2024-08-02 11:30:00', 2, 2, 2, 'PIX', 2),
       ('2024-08-03 14:15:00', 3, 3, 3, 'BOLETO', 3),
       ('2024-08-04 16:20:00', 4, 4, 4, 'CARTAO_DEBITO', 4),
       ('2024-08-05 18:00:00', 5, 5, 5, 'TRANSFERENCIA', 5),
       ('2024-08-06 09:00:00', 1, 2, 3, 'PIX', NULL),
       ('2024-08-07 12:00:00', 2, 3, 4, 'CARTAO_CREDITO', NULL),
       ('2024-08-08 15:00:00', 3, 4, 5, 'BOLETO', NULL),
       ('2024-08-09 17:00:00', 4, 5, 1, 'TRANSFERENCIA', NULL),
       ('2024-08-10 19:30:00', 5, 1, 2, 'CARTAO_DEBITO', NULL);


-- Inserindo dados na tabela tb_compra_produto_avaliacao
INSERT INTO tb_compra_produto_avaliacao (id_compra, id_produto, avaliacao, comentario, data_avaliacao)
VALUES (1, 1, '⭐⭐⭐⭐', 'Ótimo produto', '2024-08-02 12:00:00'),
       (2, 2, '⭐⭐⭐', 'Bom, mas pode melhorar', '2024-08-03 13:00:00'),
       (3, 3, '⭐⭐⭐⭐⭐', 'Excelente!', '2024-08-04 15:00:00'),
       (4, 4, '⭐⭐', 'Não gostei muito', '2024-08-05 16:00:00'),
       (5, 5, '⭐⭐⭐⭐', 'Produto de boa qualidade', '2024-08-06 18:00:00'),
       (6, 1, '⭐⭐⭐⭐⭐', 'Incrível, superou as expectativas', '2024-08-07 19:00:00'),
       (7, 2, '⭐⭐⭐', 'Bom, mas com alguns problemas', '2024-08-08 20:00:00'),
       (8, 3, '⭐⭐⭐⭐', 'Gostei bastante', '2024-08-09 21:00:00'),
       (9, 4, '⭐', 'Não recomendaria', '2024-08-10 22:00:00'),
       (10, 5, '⭐⭐⭐⭐⭐', 'Perfeito', '2024-08-11 23:00:00');

-- Inserindo dados na tabela tb_compras_produtos
INSERT INTO tb_compras_produtos (id_compra, id_produto, quantidade)
VALUES (1, 1, 2),
       (2, 2, 1),
       (3, 3, 3),
       (4, 4, 1),
       (5, 5, 2),
       (6, 1, 1),
       (7, 2, 2),
       (8, 3, 1),
       (9, 4, 3),
       (10, 5, 1);

-- Inserindo dados na tabela tb_promocoes
INSERT INTO tb_promocoes (nome, desconto, data_inicio, data_fim)
VALUES ('Promoção 1', 10.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 2', 15.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 3', 20.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 4', 25.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 5', 30.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 6', 35.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 7', 40.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 8', 45.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 9', 50.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59'),
       ('Promoção 10', 55.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');

-- Inserindo dados na tabela tb_promocoes_produtos
INSERT INTO tb_promocoes_produtos (id_produto, id_promocao, data_aplicacao)
VALUES (1, 1, '2024-08-01 10:00:00'),
       (2, 2, '2024-08-02 11:00:00'),
       (3, 3, '2024-08-03 12:00:00'),
       (4, 4, '2024-08-04 13:00:00'),
       (5, 5, '2024-08-05 14:00:00'),
       (1, 6, '2024-08-06 15:00:00'),
       (2, 7, '2024-08-07 16:00:00'),
       (3, 8, '2024-08-08 17:00:00'),
       (4, 9, '2024-08-09 18:00:00'),
       (5, 10, '2024-08-10 19:00:00');