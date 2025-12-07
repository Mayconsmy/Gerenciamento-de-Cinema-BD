-- Inserindo Filmes
INSERT INTO filme (titulo, genero, duracao, classificacao, sinopse) VALUES
('Interestelar', 'Ficção Científica', 169, '10 anos', 'Exploração espacial e buracos negros.'),
('O Auto da Compadecida 2', 'Comédia', 110, 'Livre', 'O retorno de João Grilo e Chicó.');

-- Inserindo Salas
INSERT INTO sala (nome_sala, capacidade, tipo_sala) VALUES
('Sala 1 IMAX', 100, '3D'),
('Sala 2 Standard', 50, '2D');

-- Inserindo Funcionários
INSERT INTO funcionario (nome, cargo, email) VALUES
('João Silva', 'Atendente', 'joao@cinema.com'),
('Maria Souza', 'Gerente', 'maria@cinema.com');

-- Inserindo Clientes
INSERT INTO cliente (nome, documento, email, telefone) VALUES
('Carlos Pereira', '123.456.789-00', 'carlos@email.com', '99999-1111'),
('Ana Costa', '987.654.321-11', 'ana@email.com', '99999-2222');

-- Inserindo Sessões
-- Filme 1 na Sala 1
INSERT INTO sessao (data_sessao, horario_sessao, valor_ingresso, id_filme, id_sala) VALUES
('2025-05-20', '19:00:00', 35.00, 1, 1),
('2025-05-20', '21:00:00', 25.00, 2, 2);

-- Inserindo Venda de Ingressos
INSERT INTO ingresso (quantidade, data_venda, id_sessao, id_cliente, id_funcionario) VALUES
(2, '2025-05-20', 1, 1, 1), -- Carlos comprou 2 ingressos para Interestelar
(1, '2025-05-20', 2, 2, 1); -- Ana comprou 1 ingresso para Auto da Compadecida