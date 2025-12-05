-- Testes (Baseado na Seção 5 do PDF)

-- 1. Testes de Inserção (Já realizados no inserts_data.sql)
-- Teste de Inserção com restrição (Documento em maiúsculas - Trigger 2)
INSERT INTO cliente (nome, documento, e_mail, telefone) VALUES
('Teste Trigger Doc', '99999999999', 'teste.trigger@email.com', NULL);
-- Resultado Esperado: O documento '99999999999' deve ser armazenado como '99999999999' (já que não tem letras, mas o trigger foi disparado).

-- 2. Testes de Listagem (SELECT)
-- Teste 2.1: Listar todas as sessões disponíveis (View 1)
SELECT * FROM sessoes_disponiveis;

-- Teste 2.2: Relatório de vendas por funcionário (View 2)
SELECT * FROM relatorio_vendas_por_funcionario;

-- Teste 2.3: Listar filmes com classificação 'Livre'
SELECT titulo, genero FROM filme WHERE classificacao = 'Livre';

-- 3. Testes de Funções
-- Teste 3.1: Realizar Venda (Função 1)
-- Tentativa de venda bem-sucedida (Sessão 1, 5 ingressos, Cliente 1, Funcionario 1)
-- Assentos restantes antes: 98. Depois: 93.
SELECT realizar_venda(1, 1, 5, 1);

-- Teste 3.2: Realizar Venda (Função 1) - Teste de Capacidade (Trigger 1)
-- Sessão 1 tem 100 lugares. Já foram vendidos 2 + 5 = 7. Restam 93.
-- Tentativa de vender 94 ingressos (deve falhar)
SELECT realizar_venda(1, 1, 94, 1);
-- Resultado Esperado: EXCEÇÃO (VENDA RECUSADA)

-- Teste 3.3: Relatório de Faturamento por Filme (Função 2)
-- Faturamento do filme 'Aventura no Espaço' (id_filme=1, valor_ingresso=25.00)
-- Vendas: 2 + 5 = 7 ingressos. Faturamento: 7 * 25.00 = 175.00
SELECT * FROM relatorio_faturamento_filme('Aventura no Espaço');

-- Teste 3.4: Relatório de Faturamento por Filme (Função 2) - Outro filme
-- Faturamento do filme 'O Mistério da Mansão' (id_filme=2, valor_ingresso=30.00)
-- Vendas: 5 ingressos. Faturamento: 5 * 30.00 = 150.00
SELECT * FROM relatorio_faturamento_filme('Mistério');

-- 4. Testes de Gatilhos (Triggers)
-- Teste 4.1: Trigger 1 (verificar_capacidade_sala_venda) - Já testado no Teste 3.2 (Realizar Venda - Falha)
-- Teste 4.2: Trigger 2 (atualizar_documento_cliente) - Já testado no Teste 1 (Inserção)

-- 5. Testes de Alteração (UPDATE)
-- Aumentar o valor do ingresso da Sessão 3
UPDATE sessao SET valor_ingresso = 40.00 WHERE id_sessao = 3;
-- Resultado Esperado: Valor alterado para 40.00

-- 6. Testes de Remoção (DELETE)
-- Remover o cliente de teste
DELETE FROM cliente WHERE nome = 'Teste Trigger Doc';
-- Resultado Esperado: 1 linha removida.
