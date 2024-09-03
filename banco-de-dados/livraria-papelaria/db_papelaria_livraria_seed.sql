USE db_papelaria_livraria;

-- Inserções na tabela de Transportadoras
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco)  VALUES ('Transportadora Alpha', 5.00, '12.345.678/0001-00', '1234567890', '(11) 98765-4321', 'alpha@transportadora.com', 'Rua A, 123');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Beta', 6.50, '23.456.789/0001-01', '2345678901', '(11) 99876-5432', 'beta@transportadora.com', 'Rua B, 456');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Gama', 4.75, '34.567.890/0001-02', '3456789012', '(11) 98765-3210', 'gama@transportadora.com', 'Rua C, 789');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Delta', 5.25, '45.678.901/0001-03', '4567890123', '(11) 98765-6543', 'delta@transportadora.com', 'Rua D, 012');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Epsilon', 6.00, '56.789.012/0001-04', '5678901234', '(11) 98765-9876', 'epsilon@transportadora.com', 'Rua E, 345');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Zeta', 5.80, '67.890.123/0001-05', '6789012345', '(11) 98765-6543', 'zeta@transportadora.com', 'Rua F, 678');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Eta', 7.00, '78.901.234/0001-06', '7890123456', '(11) 98765-3210', 'eta@transportadora.com', 'Rua G, 901');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Theta', 4.95, '89.012.345/0001-07', '8901234567', '(11) 98765-0987', 'theta@transportadora.com', 'Rua H, 234');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Iota', 5.10, '90.123.456/0001-08', '9012345678', '(11) 98765-8765', 'iota@transportadora.com', 'Rua I, 567');
INSERT INTO tb_transportadora (nome, preco_por_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Kappa', 6.20, '01.234.567/0001-09', '0123456789', '(11) 98765-6543', 'kappa@transportadora.com', 'Rua J, 890');

-- Inserindo dados na tabela tb_usuarios
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('João Silva', '123.456.789-00', '(11) 91234-5678', 'joao@exemplo.com', 'senha123', 'joao.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Maria Oliveira', '234.567.890-11', '(21) 92345-6789', 'maria@exemplo.com', 'senha456', 'maria.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('José Santos', '345.678.901-22', '(31) 93456-7890', 'jose@exemplo.com', 'senha789', 'jose.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Ana Souza', '456.789.012-33', '(41) 94567-8901', 'ana@exemplo.com', 'senha012', 'ana.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Pedro Lima', '567.890.123-44', '(51) 95678-9012', 'pedro@exemplo.com', 'senha345', 'pedro.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Paula Costa', '678.901.234-55', '(61) 96789-0123', 'paula@exemplo.com', 'senha678', 'paula.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Carlos Pereira', '789.012.345-66', '(71) 97890-1234', 'carlos@exemplo.com', 'senha901', 'carlos.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Julia Melo', '890.123.456-77', '(81) 98901-2345', 'julia@exemplo.com', 'senha234', 'julia.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Roberto Almeida', '901.234.567-88', '(91) 99012-3456', 'roberto@exemplo.com', 'senha567', 'roberto.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Carla Fernandes', '012.345.678-99', '(11) 91123-4567', 'carla@exemplo.com', 'senha890', 'carla.recuperacao@exemplo.com');

-- Inserindo dados na tabela tb_endereco
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (1, 'Rua A', '123', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (2, 'Rua B', '456', 'Jardim', 'Rio de Janeiro', 'RJ', '02000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (3, 'Rua C', '789', 'Vila', 'Belo Horizonte', 'MG', '03000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (4, 'Rua D', '012', 'Centro', 'Curitiba', 'PR', '04000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (5, 'Rua E', '345', 'Bairro', 'Porto Alegre', 'RS', '05000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (6, 'Rua F', '678', 'Centro', 'Brasília', 'DF', '06000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (7, 'Rua G', '901', 'Jardim', 'Salvador', 'BA', '07000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (8, 'Rua H', '234', 'Vila', 'Fortaleza', 'CE', '08000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (9, 'Rua I', '567', 'Centro', 'Manaus', 'AM', '09000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (10, 'Rua J', '890', 'Bairro', 'Recife', 'PE', '10000-000', NULL, TRUE);

-- Inserções na tabela de Produtos
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Caneta Azul', 2.50, 'Caneta esferográfica azul');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Lápis HB', 1.00, 'Lápis de madeira HB');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Caderno 100 folhas', 10.00, 'Caderno universitário de 100 folhas');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Apontador', 1.50, 'Apontador de lápis com reservatório');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Borracha', 0.75, 'Borracha branca para grafite');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Marcador de Texto', 3.00, 'Marcador de texto amarelo');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Agenda 2024', 15.00, 'Agenda anual para o ano de 2024');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Papel A4', 20.00, 'Pacote com 500 folhas de papel A4');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Calculadora', 12.00, 'Calculadora científica');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Pastas de arquivo', 5.00, 'Pastas para arquivos diversos');

-- Inserções na tabela de Estoque dos Produtos
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (1, 100, 'Prateleira A1');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (2, 200, 'Prateleira B2');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (3, 150, 'Prateleira C3');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (4, 300, 'Prateleira D4');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (5, 250, 'Prateleira E5');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (6, 120, 'Prateleira F6');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (7, 180, 'Prateleira G7');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (8, 160, 'Prateleira H8');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (9, 220, 'Prateleira I9');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (10, 140, 'Prateleira J10');

-- Inserções na tabela de Categorias
INSERT INTO tb_categoria (nome) VALUES ('Material Escolar');
INSERT INTO tb_categoria (nome) VALUES ('Papelaria');
INSERT INTO tb_categoria (nome) VALUES ('Escritório');
INSERT INTO tb_categoria (nome) VALUES ('Tecnologia');
INSERT INTO tb_categoria (nome) VALUES ('Brinquedos');
INSERT INTO tb_categoria (nome) VALUES ('Livros');
INSERT INTO tb_categoria (nome) VALUES ('Jogos');
INSERT INTO tb_categoria (nome) VALUES ('Decoração');
INSERT INTO tb_categoria (nome) VALUES ('Artigos de Festa');
INSERT INTO tb_categoria (nome) VALUES ('Presentes');

-- Inserções na tabela de Produtos e Categorias
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (1, 1);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (2, 1);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (3, 2);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (4, 2);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (5, 2);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (6, 3);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (7, 3);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (8, 3);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (9, 4);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (10, 4);

-- Inserções na tabela de Carrinho de Compras
INSERT INTO tb_carrinhos (id_usuario) VALUES (1);
INSERT INTO tb_carrinhos (id_usuario) VALUES (2);
INSERT INTO tb_carrinhos (id_usuario) VALUES (3);
INSERT INTO tb_carrinhos (id_usuario) VALUES (4);
INSERT INTO tb_carrinhos (id_usuario) VALUES (5);
INSERT INTO tb_carrinhos (id_usuario) VALUES (6);
INSERT INTO tb_carrinhos (id_usuario) VALUES (7);
INSERT INTO tb_carrinhos (id_usuario) VALUES (8);
INSERT INTO tb_carrinhos (id_usuario) VALUES (9);
INSERT INTO tb_carrinhos (id_usuario) VALUES (10);

-- Inserções na tabela de Carrinho de Compras e Produtos
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (1, 1, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (2, 2, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (3, 3, 1);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (4, 4, 5);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (5, 5, 4);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (6, 6, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (7, 7, 6);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (8, 8, 7);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (9, 9, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (10, 10, 1);

-- Inserindo dados na tabela tb_cupom
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom1', 5.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom2', 10.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom3', 15.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom4', 20.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom5', 25.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom6', 30.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom7', 35.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom8', 40.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom9', 45.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_cupom (nome, desconto, data_inicio, data_fim) VALUES ('Cupom10', 50.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');

-- Inserindo dados na tabela tb_compras
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-01 10:00:00', 1, 1);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-02 11:30:00', 2, 2);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-03 14:15:00', 3, 3);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-04 16:20:00', 4, 4);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-05 18:00:00', 5, 5);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-06 09:00:00', 1, 1);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-07 12:00:00', 2, 2);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-08 15:00:00', 3, 3);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-09 17:00:00', 4, 4);
INSERT INTO tb_compra (data_compra, id_usuario, id_endereco) VALUES ('2024-08-10 19:30:00', 5, 5);

-- Inserindo dados na tabela tb_compra_produto
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (1, 1, '⭐⭐⭐⭐', 'Ótimo produto', '2024-08-02 12:00:00', 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (2, 2, '⭐⭐⭐', 'Bom, mas pode melhorar', '2024-08-03 13:00:00', 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (3, 3, '⭐⭐⭐⭐⭐', 'Excelente!', '2024-08-04 15:00:00', 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (4, 4, '⭐⭐', 'Não gostei muito', '2024-08-05 16:00:00', 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (5, 5, '⭐⭐⭐⭐', 'Produto de boa qualidade', '2024-08-06 18:00:00', 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (6, 1, '⭐⭐⭐⭐⭐', 'Incrível, superou as expectativas', '2024-08-07 19:00:00', 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (7, 2, '⭐⭐⭐', 'Bom, mas com alguns problemas', '2024-08-08 20:00:00', 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (8, 3, '⭐⭐⭐⭐', 'Gostei bastante', '2024-08-09 21:00:00', 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (9, 4, '⭐', 'Não recomendaria', '2024-08-10 22:00:00', 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, avaliacao, comentario, data_avaliacao, quantidade) VALUES (10, 5, '⭐⭐⭐⭐⭐', 'Perfeito', '2024-08-11 23:00:00', 1);

-- Inserindo dados na tabela tb_promocao
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 1', 10.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 2', 15.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 3', 20.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 4', 25.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 5', 30.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 6', 35.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 7', 40.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 8', 45.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 9', 50.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção 10', 55.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');

-- Inserindo dados na tabela tb_promocao_produto
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (1, 1, '2024-08-01 10:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (2, 2, '2024-08-02 11:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (3, 3, '2024-08-03 12:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (4, 4, '2024-08-04 13:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (5, 5, '2024-08-05 14:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (1, 6, '2024-08-06 15:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (2, 7, '2024-08-07 16:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (3, 8, '2024-08-08 17:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (4, 9, '2024-08-09 18:00:00');
INSERT INTO tb_promocao_produto (id_produto, id_promocao, data_aplicacao) VALUES (5, 10, '2024-08-10 19:00:00');
