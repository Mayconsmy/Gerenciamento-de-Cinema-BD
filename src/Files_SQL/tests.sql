-- Teste 1: Relatório de Vendas (RF14)
-- Lista filme, horário, qtd ingressos vendidos e total arrecadado
SELECT 
    f.titulo,
    s.data_sessao,
    s.horario_sessao,
    sa.nome_sala,
    SUM(i.quantidade) as total_ingressos_vendidos,
    SUM(i.quantidade * s.valor_ingresso) as receita_total
FROM ingresso i
JOIN sessao s ON i.id_sessao = s.id_sessao
JOIN filme f ON s.id_filme = f.id_filme
JOIN sala sa ON s.id_sala = sa.id_sala
GROUP BY f.titulo, s.data_sessao, s.horario_sessao, sa.nome_sala;

-- Teste 2: Consultar Ocupação da Sala (RF13)
SELECT 
    sa.nome_sala,
    sa.capacidade,
    COALESCE(SUM(i.quantidade), 0) as ocupado,
    (sa.capacidade - COALESCE(SUM(i.quantidade), 0)) as disponivel
FROM sala sa
LEFT JOIN sessao s ON sa.id_sala = s.id_sala
LEFT JOIN ingresso i ON s.id_sessao = i.id_sessao
WHERE s.id_sessao = 1 -- Exemplo para a Sessão 1
GROUP BY sa.nome_sala, sa.capacidade;

-- Teste 3: Teste do Gatilho de Lotação (Deve falhar se a sala tiver 50 e tentarmos vender 51)
-- INSERT INTO ingresso (quantidade, id_sessao, id_cliente, id_funcionario) VALUES (101, 1, 1, 1);

-- ultilizando as views
-- Consultar o faturamento total por filme/sessão
SELECT * FROM view_relatorio_vendas;

-- Verificar quais sessões estão próximas de lotar
SELECT * FROM view_ocupacao_salas WHERE porcentagem_ocupacao > 80;

-- Consultar histórico de um cliente específico
SELECT * FROM view_historico_clientes WHERE cliente = 'Carlos Pereira';