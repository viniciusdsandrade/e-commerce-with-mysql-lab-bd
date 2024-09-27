USE db_papelaria_livraria;

-- Inserindo dados na tabela tb_administrador
INSERT INTO tb_role (nome, descricao) VALUES ('ADMINISTRADOR', 'Responsável por gerenciar todo o sistema, incluindo permissões e usuários.');
INSERT INTO tb_role (nome, descricao) VALUES ('GERENTE', 'Gerente de operações, responsável por supervisionar processos e aprovar mudanças.');
INSERT INTO tb_role (nome, descricao) VALUES ('SUPORTE', 'Função de suporte ao cliente e solução de problemas.');
INSERT INTO tb_role (nome, descricao) VALUES ('OPERADOR_FINANCEIRO', 'Responsável pela gestão financeira, incluindo controle de pagamentos.');
INSERT INTO tb_role (nome, descricao) VALUES ('GERENTE_DE_VENDAS', 'Gerente de vendas, responsável por monitorar e incentivar vendas.');
INSERT INTO tb_role (nome, descricao) VALUES ('ANALISTA_DE_DADOS', 'Responsável pela análise de dados e relatórios do sistema.');
INSERT INTO tb_role (nome, descricao) VALUES ('DESENVOLVEDOR', 'Responsável pelo desenvolvimento e manutenção do sistema.');
INSERT INTO tb_role (nome, descricao) VALUES ('TESTADOR', 'Responsável pela validação e testes de funcionalidades do sistema.');
INSERT INTO tb_role (nome, descricao) VALUES ('SUPERVISOR', 'Supervisiona as atividades operacionais e garante o cumprimento dos procedimentos.');
INSERT INTO tb_role (nome, descricao) VALUES ('COORDENADOR', 'Coordena as equipes e assegura a execução correta das operações.');
INSERT INTO tb_role (nome, descricao) VALUES ('ANALISTA_DE_SUPORTE', 'Responsável pelo atendimento de suporte técnico e solução de dúvidas.');
INSERT INTO tb_role (nome, descricao) VALUES ('GERENTE_DE_TI', 'Gerencia a infraestrutura de TI e a equipe de suporte técnico.');
INSERT INTO tb_role (nome, descricao) VALUES ('OPERADOR_DE_ESTOQUE', 'Responsável pelo controle e organização do estoque.');
INSERT INTO tb_role (nome, descricao) VALUES ('ADMINISTRADOR_DE_REDE', 'Gerencia e monitora a rede da empresa.');
INSERT INTO tb_role (nome, descricao) VALUES ('GERENTE_DE_MARKETING', 'Gerencia campanhas e estratégias de marketing da empresa.');
INSERT INTO tb_role (nome, descricao) VALUES ('ANALISTA_FINANCEIRO', 'Analista responsável pelas finanças e relatórios financeiros.');
INSERT INTO tb_role (nome, descricao) VALUES ('COORDENADOR_DE_ATENDIMENTO', 'Coordena a equipe de atendimento ao cliente.');
INSERT INTO tb_role (nome, descricao) VALUES ('OPERADOR_DE_LOGISTICA', 'Responsável pelo gerenciamento logístico e entregas.');
INSERT INTO tb_role (nome, descricao) VALUES ('DIRETOR_EXECUTIVO', 'Dirige a empresa em nível estratégico.');
INSERT INTO tb_role (nome, descricao) VALUES ('ENGENHEIRO_DE_SOFTWARE', 'Desenvolve e implementa soluções de software na empresa.');

-- Inserindo dados na tabela tb_permissao
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_BANIR_USUARIO', 'Permissão para banir usuários do sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CONVERSAR_COM_USUARIO', 'Permissão para conversar diretamente com os usuários.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_CATEGORIAS', 'Permissão para visualizar categorias no sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_CATEGORIAS', 'Permissão para criar novas categorias.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_CATEGORIAS', 'Permissão para editar categorias existentes.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_CATEGORIAS', 'Permissão para remover categorias do sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_PRODUTOS', 'Permissão para visualizar produtos no sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_PRODUTOS', 'Permissão para adicionar novos produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_PRODUTOS', 'Permissão para editar informações de produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_PRODUTOS', 'Permissão para remover produtos do sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_ESTOQUES', 'Permissão para visualizar o estoque de produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_ESTOQUES', 'Permissão para criar novos registros de estoque.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_ESTOQUES', 'Permissão para editar informações de estoque.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_ESTOQUES', 'Permissão para remover registros de estoque.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_PROMOCOES', 'Permissão para visualizar promoções de produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_PROMOCOES', 'Permissão para criar novas promoções.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_PROMOCOES', 'Permissão para editar promoções existentes.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_PROMOCOES', 'Permissão para remover promoções do sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_TRANSPORTADORA', 'Permissão para adicionar novas transportadoras.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_TRANSPORTADORA', 'Permissão para editar transportadoras.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_TRANSPORTADORA', 'Permissão para remover transportadoras do sistema.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_AVALIACOES', 'Permissão para visualizar as avaliações de produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_AVALIACOES', 'Permissão para remover avaliações de produtos.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_VISUALIZAR_CUPONS', 'Permissão para visualizar cupons de desconto.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_CRIAR_CUPONS', 'Permissão para criar novos cupons de desconto.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_EDITAR_CUPONS', 'Permissão para editar cupons de desconto existentes.');
INSERT INTO tb_permissao (nome, descricao) VALUES ('PODE_REMOVER_CUPONS', 'Permissão para remover cupons de desconto.');

-- Associando o papel 'ADMINISTRADOR' a várias permissões
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (1, 1); -- ADMINISTRADOR pode banir usuários
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (1, 2); -- ADMINISTRADOR pode conversar com usuários
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (1, 3); -- ADMINISTRADOR pode visualizar categorias
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (1, 4); -- ADMINISTRADOR pode criar categorias

-- Associando o papel 'GERENTE' a algumas permissões
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (2, 3); -- GERENTE pode visualizar categorias
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (2, 5); -- GERENTE pode editar categorias
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (2, 7); -- GERENTE pode visualizar produtos

-- Associando o papel 'SUPORTE' a permissões relacionadas ao atendimento de usuários
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (3, 2); -- SUPORTE pode conversar com usuários
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (3, 10); -- SUPORTE pode remover produtos
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (3, 12); -- SUPORTE pode criar estoques

-- Associando o papel 'OPERADOR_FINANCEIRO' a permissões financeiras
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (4, 24); -- OPERADOR_FINANCEIRO pode visualizar cupons
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (4, 25); -- OPERADOR_FINANCEIRO pode criar cupons
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (4, 26); -- OPERADOR_FINANCEIRO pode editar cupons

-- Associando o papel 'GERENTE_DE_VENDAS' a permissões relacionadas a produtos e promoções
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (5, 7);  -- GERENTE_DE_VENDAS pode visualizar produtos
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (5, 16); -- GERENTE_DE_VENDAS pode visualizar promoções
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (5, 17); -- GERENTE_DE_VENDAS pode criar promoções

-- Associando o papel 'ANALISTA_DE_DADOS' a permissões de visualização
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (6, 3);  -- ANALISTA_DE_DADOS pode visualizar categorias
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (6, 7);  -- ANALISTA_DE_DADOS pode visualizar produtos
INSERT INTO tb_role_permissao (id_role, id_permissao) VALUES (6, 11); -- ANALISTA_DE_DADOS pode visualizar estoques

-- Inserindo 20 pessoas na tabela tb_pessoa
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('João Silva', '1990-01-15', '123.456.789-00', 'joao.silva@email.com', 'hash_senha1', 'salt1', '11999999999');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Maria Oliveira', '1985-03-22', '123.456.789-01', 'maria.oliveira@email.com', 'hash_senha2', 'salt2', '11988888888');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Pedro Santos', '1992-06-30', '123.456.789-02', 'pedro.santos@email.com', 'hash_senha3', 'salt3', '11977777777');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Ana Costa', '1995-09-12', '123.456.789-03', 'ana.costa@email.com', 'hash_senha4', 'salt4', '11966666666');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Lucas Lima', '1993-04-25', '123.456.789-04', 'lucas.lima@email.com', 'hash_senha5', 'salt5', '11955555555');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Julia Mendes', '1988-11-05', '123.456.789-05', 'julia.mendes@email.com', 'hash_senha6', 'salt6', '11944444444');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Fernando Sousa', '1987-08-20', '123.456.789-06', 'fernando.sousa@email.com', 'hash_senha7', 'salt7', '11933333333');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Clara Rodrigues', '1991-02-10', '123.456.789-07', 'clara.rodrigues@email.com', 'hash_senha8', 'salt8', '11922222222');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Rafael Teixeira', '1996-12-31', '123.456.789-08', 'rafael.teixeira@email.com', 'hash_senha9', 'salt9', '11911111111');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Marina Ferreira', '1994-07-18', '123.456.789-09', 'marina.ferreira@email.com', 'hash_senha10', 'salt10', '11900000000');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Gustavo Nunes', '1990-01-15', '123.456.789-10', 'gustavo.nunes@email.com', 'hash_senha11', 'salt11', '11999999900');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Isabel Souza', '1985-03-22', '123.456.789-11', 'isabel.souza@email.com', 'hash_senha12', 'salt12', '11988888800');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Vinicius Farias', '1992-06-30', '123.456.789-12', 'vinicius.farias@email.com', 'hash_senha13', 'salt13', '11977777700');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Paula Borges', '1995-09-12', '123.456.789-13', 'paula.borges@email.com', 'hash_senha14', 'salt14', '11966666600');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Hugo Matos', '1993-04-25', '123.456.789-14', 'hugo.matos@email.com', 'hash_senha15', 'salt15', '11955555500');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Livia Cardoso', '1988-11-05', '123.456.789-15', 'livia.cardoso@email.com', 'hash_senha16', 'salt16', '11944444400');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Bruno Almeida', '1987-08-20', '123.456.789-16', 'bruno.almeida@email.com', 'hash_senha17', 'salt17', '11933333300');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Camila Ribeiro', '1991-02-10', '123.456.789-17', 'camila.ribeiro@email.com', 'hash_senha18', 'salt18', '11922222200');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Daniel Martins', '1996-12-31', '123.456.789-18', 'daniel.martins@email.com', 'hash_senha19', 'salt19', '11911111100');
INSERT INTO tb_pessoa (nome, data_nascimento, cpf, email, senha_hash, salt, telefone) VALUES ('Sara Rocha', '1994-07-18', '123.456.789-19', 'sara.rocha@email.com', 'hash_senha20', 'salt20', '11900000000');

-- Associando 10 pessoas como funcionários na tabela tb_funcionario
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (1, 'joao.recupera@email.com', 1);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (2, 'maria.recupera@email.com', 2);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (3, 'pedro.recupera@email.com', 1);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (4, 'ana.recupera@email.com', 3);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (5, 'lucas.recupera@email.com', 1);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (6, 'julia.recupera@email.com', 4);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (7, 'fernando.recupera@email.com', 2);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (8, 'clara.recupera@email.com', 5);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (9, 'rafael.recupera@email.com', 1);
INSERT INTO tb_funcionario (id_pessoa, email_recuperacao, id_nivel_acesso) VALUES (10, 'marina.recupera@email.com', 3);

-- Associando 10 pessoas como usuários na tabela tb_usuario
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (11, 500.00, 'ATIVO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (12, 100.00, 'SUSPENSO', '2024-10-30');
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (13, 250.00, 'BANIDO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (14, 0.00, 'AGUARDANDO_VERIFICACAO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (15, 800.00, 'ATIVO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (16, 50.00, 'ATIVO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (17, 0.00, 'SUSPENSO', '2024-12-01');
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (18, 1200.00, 'ATIVO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (19, 300.00, 'BANIDO', NULL);
INSERT INTO tb_usuario (id_pessoa, saldo, estado, data_final_suspensao) VALUES (20, 75.00, 'ATIVO', NULL);


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

-- Associando cada usuário a um role na tabela tb_usuario_role
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (11, 1); -- Usuário com id_pessoa 11 recebe o role 1 (ex: ADMINISTRADOR)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (12, 2); -- Usuário com id_pessoa 12 recebe o role 2 (ex: GERENTE)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (13, 3); -- Usuário com id_pessoa 13 recebe o role 3 (ex: SUPORTE)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (14, 4); -- Usuário com id_pessoa 14 recebe o role 4 (ex: OPERADOR_FINANCEIRO)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (15, 5); -- Usuário com id_pessoa 15 recebe o role 5 (ex: GERENTE_DE_VENDAS)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (16, 1); -- Usuário com id_pessoa 16 recebe o role 1 (ex: ADMINISTRADOR)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (17, 2); -- Usuário com id_pessoa 17 recebe o role 2 (ex: GERENTE)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (18, 3); -- Usuário com id_pessoa 18 recebe o role 3 (ex: SUPORTE)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (19, 4); -- Usuário com id_pessoa 19 recebe o role 4 (ex: OPERADOR_FINANCEIRO)
INSERT INTO tb_usuario_role (id_usuario, id_role) VALUES (20, 5); -- Usuário com id_pessoa 20 recebe o role 5 (ex: GERENTE_DE_VENDAS)

-- Endereços principais
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (11, 'Rua A', '123', 'Centro', 'São Paulo', 'SP', '01000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (12, 'Rua B', '456', 'Jardim', 'Rio de Janeiro', 'RJ', '02000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (13, 'Rua C', '789', 'Vila', 'Belo Horizonte', 'MG', '03000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (14, 'Rua D', '012', 'Centro', 'Curitiba', 'PR', '04000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (15, 'Rua E', '345', 'Bairro', 'Porto Alegre', 'RS', '05000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (16, 'Rua F', '678', 'Centro', 'Brasília', 'DF', '06000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (17, 'Rua G', '901', 'Jardim', 'Salvador', 'BA', '07000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (18, 'Rua H', '234', 'Vila', 'Fortaleza', 'CE', '08000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (19, 'Rua I', '567', 'Centro', 'Manaus', 'AM', '09000-000', NULL, TRUE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (20, 'Rua J', '890', 'Bairro', 'Recife', 'PE', '10000-000', NULL, TRUE);

-- Endereços secundários
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (11, 'Rua X', '987', 'Outro Bairro', 'São Paulo', 'SP', '01234-567', 'Fundos', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (12, 'Rua Y', '654', 'Zona Sul', 'Rio de Janeiro', 'RJ', '23456-789', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (13, 'Rua Z', '321', 'Região Leste', 'Belo Horizonte', 'MG', '34567-890', 'Bloco A', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (14, 'Rua W', '159', 'Novo Bairro', 'Curitiba', 'PR', '45678-901', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (15, 'Rua V', '753', 'Litoral', 'Porto Alegre', 'RS', '56789-012', 'Casa 10', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (16, 'Rua U', '086', 'Asa Sul', 'Brasília', 'DF', '67890-123', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (17, 'Rua T', '420', 'Barra', 'Salvador', 'BA', '78901-234', 'Ap 501', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (18, 'Rua S', '137', 'Praia', 'Fortaleza', 'CE', '89012-345', NULL, FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (19, 'Rua R', '963', 'Centro-Sul', 'Manaus', 'AM', '90123-456', 'Casa 5', FALSE);
INSERT INTO tb_endereco (id_usuario, rua, numero, bairro, cidade, estado, cep, complemento, is_principal) VALUES (20, 'Rua Q', '258', 'Zona Norte', 'Recife', 'PE', '01234-567', NULL, FALSE);

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

-- Inserções na tabela de Carrinho de Compras
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

SELECT * FROM tb_carrinho;

-- Inserções na tabela de Carrinho de Compras e Produtos
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (11, 1, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (12, 2, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (13, 3, 1);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (14, 4, 5);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (15, 5, 4);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (16, 6, 2);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (17, 7, 6);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (18, 8, 7);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (19, 9, 3);
INSERT INTO tb_carrinho_produto (id_carrinho, id_produto, quantidade) VALUES (20, 10, 1);

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
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-01 10:00:00', 11, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-02 11:30:00', 12, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-03 14:15:00', 13, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-04 16:20:00', 14, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-05 18:00:00', 15, 5);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-06 09:00:00', 11, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-07 12:00:00', 12, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-08 15:00:00', 13, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-09 17:00:00', 14, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-10 19:30:00', 15, 5);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-11 20:00:00', 16, 6);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-12 08:30:00', 17, 7);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-13 13:45:00', 18, 8);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-14 17:10:00', 19, 9);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-15 10:30:00', 20, 10);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-16 14:00:00', 11, 1);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-17 11:15:00', 12, 2);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-18 16:45:00', 13, 3);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-19 09:30:00', 14, 4);
INSERT INTO tb_compra (data_realizada, id_usuario, id_endereco) VALUES ('2024-08-20 12:45:00', 15, 5);

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
