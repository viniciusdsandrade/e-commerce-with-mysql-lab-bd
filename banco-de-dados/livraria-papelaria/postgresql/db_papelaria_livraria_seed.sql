-- Desabilita o modo de confirmação implícita para evitar erros
SET client_min_messages TO WARNING;

-- Usa o banco de dados
\c db_papelaria_livraria;

-- Inserindo dados na tabela tb_administrador
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 1', 'admin1@papelaria.com', 'senha_admin1', 'admin1_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 2', 'admin2@papelaria.com', 'senha_admin2', 'admin2_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 3', 'admin3@papelaria.com', 'senha_admin3', NULL);
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 4', 'admin4@papelaria.com', 'senha_admin4', 'admin4_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 5', 'admin5@papelaria.com', 'senha_admin5', 'admin5_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 6', 'admin6@papelaria.com', 'senha_admin6', 'admin6_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 7', 'admin7@papelaria.com', 'senha_admin7', 'admin7_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 8', 'admin8@papelaria.com', 'senha_admin8', 'admin8_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 9', 'admin9@papelaria.com', 'senha_admin9', 'admin9_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 10', 'admin10@papelaria.com', 'senha_admin10', 'admin10_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 11', 'admin11@papelaria.com', 'senha_admin11', 'admin11_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 12', 'admin12@papelaria.com', 'senha_admin12', 'admin12_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 13', 'admin13@papelaria.com', 'senha_admin13', 'admin13_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 14', 'admin14@papelaria.com', 'senha_admin14', 'admin14_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 15', 'admin15@papelaria.com', 'senha_admin15', 'admin15_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 16', 'admin16@papelaria.com', 'senha_admin16', 'admin16_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 17', 'admin17@papelaria.com', 'senha_admin17', 'admin17_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 18', 'admin18@papelaria.com', 'senha_admin18', 'admin18_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 19', 'admin19@papelaria.com', 'senha_admin19', 'admin19_recuperacao@papelaria.com');
INSERT INTO tb_administrador (nome, email, senha, email_de_recuperacao) VALUES ('Administrador 20', 'admin20@papelaria.com', 'senha_admin20', 'admin20_recuperacao@papelaria.com');

-- Inserções na tabela de Transportadoras
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Alpha', 5.00, '12.345.678/0001-00', '1234567890', '(11) 98765-4321', 'alpha@transportadora.com', 'Rua A, 123');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Beta', 6.50, '23.456.789/0001-01', '2345678901', '(11) 99876-5432', 'beta@transportadora.com', 'Rua B, 456');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Gama', 4.75, '34.567.890/0001-02', '3456789012', '(11) 98765-3210', 'gama@transportadora.com', 'Rua C, 789');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Delta', 5.25, '45.678.901/0001-03', '4567890123', '(11) 98765-6543', 'delta@transportadora.com', 'Rua D, 012');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Epsilon', 6.00, '56.789.012/0001-04', '5678901234', '(11) 98765-9876', 'epsilon@transportadora.com', 'Rua E, 345');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Zeta', 5.80, '67.890.123/0001-05', '6789012345', '(11) 98765-6543', 'zeta@transportadora.com', 'Rua F, 678');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Eta', 7.00, '78.901.234/0001-06', '7890123456', '(11) 98765-3210', 'eta@transportadora.com', 'Rua G, 901');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Theta', 4.95, '89.012.345/0001-07', '8901234567', '(11) 98765-0987', 'theta@transportadora.com', 'Rua H, 234');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Iota', 5.10, '90.123.456/0001-08', '9012345678', '(11) 98765-8765', 'iota@transportadora.com', 'Rua I, 567');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Kappa', 6.20, '01.234.567/0001-09', '0123456789', '(11) 98765-6543', 'kappa@transportadora.com', 'Rua J, 890');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Lambda', 5.50, '13.456.789/0001-10', '1345678902', '(11) 98765-2109', 'lambda@transportadora.com', 'Rua K, 468');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Mu', 6.25, '24.567.890/0001-11', '2456789013', '(11) 99876-3210', 'mu@transportadora.com', 'Rua L, 790');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Nu', 4.80, '35.678.901/0001-12', '3567890124', '(11) 98765-1098', 'nu@transportadora.com', 'Rua M, 135');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Xi', 5.70, '46.789.012/0001-13', '4678901235', '(11) 98765-0987', 'xi@transportadora.com', 'Rua N, 246');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Omicron', 6.40, '57.890.123/0001-14', '5789012346', '(11) 98765-9876', 'omicron@transportadora.com', 'Rua O, 357');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Pi', 5.90, '68.901.234/0001-15', '6890123457', '(11) 98765-8765', 'pi@transportadora.com', 'Rua P, 579');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Rho', 7.20, '79.012.345/0001-16', '7901234568', '(11) 98765-7654', 'rho@transportadora.com', 'Rua Q, 680');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Sigma', 5.05, '80.123.456/0001-17', '8012345679', '(11) 98765-6543', 'sigma@transportadora.com', 'Rua R, 791');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Tau', 5.30, '91.234.567/0001-18', '9123456780', '(11) 98765-5432', 'tau@transportadora.com', 'Rua S, 802');
INSERT INTO tb_transportadora (nome, preco_km, cnpj, inscricao_estadual, telefone, email, endereco) VALUES ('Transportadora Upsilon', 6.10, '02.345.678/0001-19', '0234567891', '(11) 98765-4321', 'upsilon@transportadora.com', 'Rua T, 913');

-- Inserindo dados na tabela tb_usuario
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
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Fernando Rodrigues', '111.222.333-44', '(12) 91234-0987', 'fernando@exemplo.com', 'senha111', 'fernando.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Isabela Castro', '222.333.444-55', '(22) 92345-1098', 'isabela@exemplo.com', 'senha222', 'isabela.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Ricardo Barbosa', '333.444.555-66', '(32) 93456-2109', 'ricardo@exemplo.com', 'senha333', 'ricardo.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Mariana Cunha', '444.555.666-77', '(42) 94567-3210', 'mariana@exemplo.com', 'senha444', 'mariana.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Gustavo Lima', '555.666.777-88', '(52) 95678-4321', 'gustavo@exemplo.com', 'senha555', 'gustavo.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Amanda Gomes', '666.777.888-99', '(62) 96789-5432', 'amanda@exemplo.com', 'senha666', 'amanda.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Rafael Freitas', '777.888.999-00', '(72) 97890-6543', 'rafael@exemplo.com', 'senha777', 'rafael.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Bruna Cardoso', '888.999.000-11', '(82) 98901-7654', 'bruna@exemplo.com', 'senha888', 'bruna.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Leonardo Dias', '999.000.111-22', '(92) 99012-8765', 'leonardo@exemplo.com', 'senha999', 'leonardo.recuperacao@exemplo.com');
INSERT INTO tb_usuario (nome, cpf, telefone, email, senha, email_de_recuperacao) VALUES ('Vitória Moraes', '000.111.222-33', '(13) 91123-9876', 'vitoria@exemplo.com', 'senha000', 'vitoria.recuperacao@exemplo.com');

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
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (11, 'Rua K', '135', 'Vila Nova', 'Campinas', 'SP', '01100-000', 'Ap 101', TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (12, 'Rua L', '246', 'Centro', 'Niterói', 'RJ', '02200-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (13, 'Rua M', '357', 'Jardim', 'Contagem', 'MG', '03300-000', 'Casa 2', TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (14, 'Rua N', '468', 'Bairro', 'São José dos Pinhais', 'PR', '04400-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (15, 'Rua O', '579', 'Centro', 'Canoas', 'RS', '05500-000', 'Ap 202', TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (16, 'Rua P', '680', 'Asa Norte', 'Brasília', 'DF', '06600-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (17, 'Rua Q', '791', 'Pituba', 'Salvador', 'BA', '07700-000', 'Casa 3', TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (18, 'Rua R', '802', 'Meireles', 'Fortaleza', 'CE', '08800-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (19, 'Rua S', '913', 'Adrianópolis', 'Manaus', 'AM', '09900-000', 'Ap 303', TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (20, 'Rua T', '024', 'Boa Viagem', 'Recife', 'PE', '10100-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (1, 'Rua X', '987', 'Outro Bairro', 'São Paulo', 'SP', '01234-567', 'Fundos', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (2, 'Rua Y', '654', 'Zona Sul', 'Rio de Janeiro', 'RJ', '23456-789', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (3, 'Rua Z', '321', 'Região Leste', 'Belo Horizonte', 'MG', '34567-890', 'Bloco A', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (4, 'Rua W', '159', 'Novo Bairro', 'Curitiba', 'PR', '45678-901', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (5, 'Rua V', '753', 'Litoral', 'Porto Alegre', 'RS', '56789-012', 'Casa 10', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (6, 'Rua U', '086', 'Asa Sul', 'Brasília', 'DF', '67890-123', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (7, 'Rua T', '420', 'Barra', 'Salvador', 'BA', '78901-234', 'Ap 501', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (8, 'Rua S', '137', 'Praia', 'Fortaleza', 'CE', '89012-345', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (9, 'Rua R', '963', 'Centro-Sul', 'Manaus', 'AM', '90123-456', 'Casa 5', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (10, 'Rua Q', '258', 'Zona Norte', 'Recife', 'PE', '01234-567', NULL, FALSE);

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
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Livro - Aventura', 35.00, 'Um livro de aventura emocionante');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Jogo de Tabuleiro', 80.00, 'Jogo de tabuleiro para toda a família');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Caneca Personalizada', 25.00, 'Caneca com a sua foto ou frase');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Vaso Decorativo', 40.00, 'Vaso para decorar sua casa');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Chapéu de Festa', 10.00, 'Chapéu para animar sua festa');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Caixa de Bombons', 30.00, 'Caixa de bombons para presentear');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Mochila Escolar', 120.00, 'Mochila para carregar seus materiais escolares');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Estojo de Canetas', 20.00, 'Estojo com diversas canetas coloridas');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Mouse Sem Fio', 50.00, 'Mouse sem fio para seu computador');
INSERT INTO tb_produto (nome, preco, descricao) VALUES ('Teclado Gamer', 150.00, 'Teclado gamer com iluminação RGB');

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
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (11, 80, 'Prateleira K1');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (12, 100, 'Prateleira L2');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (13, 50, 'Prateleira M3');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (14, 60, 'Prateleira N4');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (15, 150, 'Prateleira O5');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (16, 70, 'Prateleira P6');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (17, 90, 'Prateleira Q7');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (18, 120, 'Prateleira R8');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (19, 40, 'Prateleira S9');
INSERT INTO tb_estoque (id_produto, quantidade, localizacao) VALUES (20, 80, 'Prateleira T10');


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
INSERT INTO tb_categoria (nome) VALUES ('Moda');
INSERT INTO tb_categoria (nome) VALUES ('Beleza');
INSERT INTO tb_categoria (nome) VALUES ('Casa e Jardim');
INSERT INTO tb_categoria (nome) VALUES ('Esporte e Lazer');
INSERT INTO tb_categoria (nome) VALUES ('Alimentos e Bebidas');
INSERT INTO tb_categoria (nome) VALUES ('Automotivo');
INSERT INTO tb_categoria (nome) VALUES ('Informática');
INSERT INTO tb_categoria (nome) VALUES ('Saúde');
INSERT INTO tb_categoria (nome) VALUES ('Música');
INSERT INTO tb_categoria (nome) VALUES ('Filmes e Séries');


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
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (11, 6);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (12, 7);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (13, 10);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (14, 8);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (15, 9);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (16, 5);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (17, 1);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (18, 2);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (19, 4);
INSERT INTO tb_produto_categoria (id_produto, id_categoria) VALUES (20, 3);

-- Inserções na tabela de Lista de Desejos
INSERT INTO tb_lista_desejos (id_usuario) VALUES (1);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (2);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (3);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (4);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (5);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (6);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (7);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (8);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (9);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (10);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (11);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (12);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (13);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (14);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (15);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (16);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (17);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (18);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (19);
INSERT INTO tb_lista_desejos (id_usuario) VALUES (20);

-- Inserções na tabela de Lista de Desejos e Produtos
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (1, 3);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (2, 8);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (3, 12);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (4, 1);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (5, 15);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (6, 6);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (7, 18);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (8, 9);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (9, 2);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (10, 11);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (11, 5);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (12, 14);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (13, 19);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (14, 7);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (15, 16);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (16, 10);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (17, 4);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (18, 13);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (19, 17);
INSERT INTO tb_lista_desejos_produto (id_lista_desejos, id_produto) VALUES (20, 20);

-- Inserções na tabela de Carrinho de Compras
INSERT INTO tb_carrinho (id_usuario) VALUES (1);
INSERT INTO tb_carrinho (id_usuario) VALUES (2);
INSERT INTO tb_carrinho (id_usuario) VALUES (3);
INSERT INTO tb_carrinho (id_usuario) VALUES (4);
INSERT INTO tb_carrinho (id_usuario) VALUES (5);
INSERT INTO tb_carrinho (id_usuario) VALUES (6);
INSERT INTO tb_carrinho (id_usuario) VALUES (7);
INSERT INTO tb_carrinho (id_usuario) VALUES (8);
INSERT INTO tb_carrinho (id_usuario) VALUES (9);
INSERT INTO tb_carrinho (id_usuario) VALUES (10);
INSERT INTO tb_carrinho (id_usuario) VALUES (11);
INSERT INTO tb_carrinho (id_usuario) VALUES (12);
INSERT INTO tb_carrinho (id_usuario) VALUES (13);
INSERT INTO tb_carrinho (id_usuario) VALUES (14);
INSERT INTO tb_carrinho (id_usuario) VALUES (15);
INSERT INTO tb_carrinho (id_usuario) VALUES (16);
INSERT INTO tb_carrinho (id_usuario) VALUES (17);
INSERT INTO tb_carrinho (id_usuario) VALUES (18);
INSERT INTO tb_carrinho (id_usuario) VALUES (19);
INSERT INTO tb_carrinho (id_usuario) VALUES (20);

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
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (11, 11, 1);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (12, 12, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (13, 13, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (14, 14, 1);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (15, 15, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (16, 16, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (17, 17, 1);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (18, 18, 4);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (19, 19, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (20, 20, 1);


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


-- Inserindo dados na tabela tb_compra
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-01 10:00:00', 1, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-02 11:30:00', 2, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-03 14:15:00', 3, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-04 16:20:00', 4, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-05 18:00:00', 5, 5);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-06 09:00:00', 1, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-07 12:00:00', 2, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-08 15:00:00', 3, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-09 17:00:00', 4, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-10 19:30:00', 5, 5);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-11 20:00:00', 6, 6);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-12 08:30:00', 7, 7);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-13 13:45:00', 8, 8);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-14 17:10:00', 9, 9);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-15 10:30:00', 10, 10);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-16 14:00:00', 1, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-17 11:15:00', 2, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-18 16:45:00', 3, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-19 09:30:00', 4, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-20 12:45:00', 5, 5);

-- Inserindo dados na tabela tb_compra_produto
-- Compra 1
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (1, 1, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (1, 3, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (1, 5, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (1, 7, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (1, 9, 1);

-- Compra 2
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (2, 2, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (2, 4, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (2, 6, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (2, 8, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (2, 10, 2);

-- Compra 3
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (3, 3, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (3, 1, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (3, 7, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (3, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (3, 9, 2);

-- Compra 4
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (4, 4, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (4, 2, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (4, 8, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (4, 6, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (4, 10, 3);

-- Compra 5
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (5, 5, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (5, 9, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (5, 10, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (5, 1, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (5, 3, 2);

-- Compra 6
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (6, 1, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (6, 4, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (6, 7, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (6, 10, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (6, 2, 2);

-- Compra 7
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (7, 3, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (7, 6, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (7, 9, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (7, 5, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (7, 8, 2);

-- Compra 8
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (8, 2, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (8, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (8, 8, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (8, 1, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (8, 4, 1);

-- Compra 9
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (9, 4, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (9, 7, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (9, 10, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (9, 3, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (9, 6, 2);

-- Compra 10
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (10, 6, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (10, 9, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (10, 1, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (10, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (10, 2, 1);

-- Compra 11
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (11, 7, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (11, 2, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (11, 4, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (11, 8, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (11, 10, 1);

-- Compra 12
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (12, 8, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (12, 3, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (12, 6, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (12, 1, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (12, 9, 2);

-- Compra 13
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (13, 9, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (13, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (13, 2, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (13, 7, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (13, 4, 1);

-- Compra 14
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (14, 10, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (14, 1, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (14, 6, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (14, 8, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (14, 3, 1);

-- Compra 15
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (15, 1, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (15, 4, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (15, 7, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (15, 10, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (15, 9, 1);

-- Compra 16
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (16, 2, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (16, 6, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (16, 9, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (16, 3, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (16, 5, 1);

-- Compra 17
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (17, 3, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (17, 8, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (17, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (17, 10, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (17, 7, 2);

-- Compra 18
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (18, 4, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (18, 1, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (18, 9, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (18, 6, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (18, 2, 1);

-- Compra 19
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (19, 5, 3);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (19, 7, 1);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (19, 3, 2);
INSERT INTO tb_compra_produto (id_compra, id_produto, quantidade) VALUES (19, 10, 2);

-- Criando algumas avaliações (opcional)
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (1, '⭐⭐⭐⭐', 'Ótimo produto!');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (3, '⭐⭐⭐⭐⭐', 'Excelente!');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (5, '⭐⭐⭐', 'Bom, mas pode melhorar.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (2, '⭐⭐⭐', 'Produto razoável.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (4, '⭐⭐⭐⭐', 'Boa qualidade.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (6, '⭐⭐⭐⭐⭐', 'Recomendo!');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (7, '⭐⭐', 'Não gostei.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (8, '⭐⭐⭐⭐', 'Atendeu às expectativas.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (9, '⭐⭐⭐⭐⭐', 'Excelente produto, entrega rápida.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (10, '⭐⭐⭐', 'Pode melhorar.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (11, '⭐⭐⭐⭐', 'Satisfeito com a compra.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (12, '⭐⭐⭐⭐⭐', 'Super recomendo!');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (13, '⭐⭐', 'Produto com defeito.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (14, '⭐⭐⭐⭐', 'Bom custo-benefício.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (15, '⭐⭐⭐⭐⭐', 'Adorei!');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (16, '⭐⭐⭐', 'Mais ou menos.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (17, '⭐⭐⭐⭐', 'Entrega rápida.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (18, '⭐⭐⭐⭐⭐', 'Produto de ótima qualidade.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (19, '⭐⭐', 'Não recomendo.');
INSERT INTO tb_avaliacao (id_compra_produto, avaliacao, comentario) VALUES (20, '⭐⭐⭐⭐', 'Satisfeito com a compra.');

-- Inserindo dados na tabela tb_promocao
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção de Volta às Aulas', 10.00, '2024-08-01 00:00:00', '2024-08-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Semana do Escritório', 15.00, '2024-08-15 00:00:00', '2024-08-22 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Liquidação de Tecnologia', 20.00, '2024-08-25 00:00:00', '2024-09-05 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção de Fim de Ano', 25.00, '2024-12-01 00:00:00', '2024-12-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Dia das Mães', 10.00, '2024-05-01 00:00:00', '2024-05-15 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Dia dos Pais', 15.00, '2024-08-01 00:00:00', '2024-08-15 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Black Friday', 20.00, '2024-11-25 00:00:00', '2024-11-30 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Cyber Monday', 25.00, '2024-12-01 00:00:00', '2024-12-05 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Natal', 10.00, '2024-12-15 00:00:00', '2024-12-25 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Ano Novo', 15.00, '2024-12-26 00:00:00', '2025-01-05 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Carnaval', 20.00, '2024-02-15 00:00:00', '2024-03-01 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Páscoa', 25.00, '2024-04-01 00:00:00', '2024-04-15 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Dia dos Namorados', 10.00, '2024-06-01 00:00:00', '2024-06-15 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Promoção Relâmpago', 15.00, '2024-09-10 00:00:00', '2024-09-10 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Super Ofertas', 20.00, '2024-10-01 00:00:00', '2024-10-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Descontos Imperdíveis', 25.00, '2024-11-01 00:00:00', '2024-11-15 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Queima de Estoque', 10.00, '2024-12-05 00:00:00', '2024-12-14 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Festa de Aniversário da Loja', 15.00, '2024-07-01 00:00:00', '2024-07-31 23:59:59');
INSERT INTO tb_promocao (nome, desconto, data_inicio, data_fim) VALUES ('Semana da Criança', 20.00, '2024-10-10 00:00:00', '2024-10-17 23:59:59');

-- Inserindo dados na tabela tb_promocao_produto
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (1, 1);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (2, 1);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (6, 2);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (9, 3);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (3, 1);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (4, 2);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (5, 3);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (7, 4);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (8, 5);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (10, 6);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (11, 7);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (12, 8);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (13, 9);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (14, 10);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (15, 1);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (16, 2);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (17, 3);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (18, 4);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (19, 5);
INSERT INTO tb_promocao_produto (id_produto, id_promocao) VALUES (20, 6);

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

-- Inserindo dados na tabela tb_cupom_compra (opcional)
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (1, 1);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (3, 2);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (2, 2);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (4, 3);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (5, 1);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (6, 4);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (7, 5);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (8, 2);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (9, 3);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (10, 1);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (11, 4);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (12, 5);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (13, 2);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (14, 3);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (15, 1);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (16, 4);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (17, 5);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (18, 2);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (19, 3);
INSERT INTO tb_cupom_compra (id_compra, id_cupom) VALUES (20, 1);
