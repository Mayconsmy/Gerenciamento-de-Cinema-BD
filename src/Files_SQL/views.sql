-- View para o Relatório de Vendas por Sessão (RF14)
-- Consolida informações de filmes, sessões e faturamento total
CREATE OR REPLACE VIEW view_relatorio_vendas AS
SELECT 
    f.titulo AS filme,
    s.data_sessao AS data,
    s.horario_sessao AS horario,
    sa.nome_sala AS sala,
    SUM(i.quantidade) AS ingressos_vendidos,
    SUM(i.quantidade * s.valor_ingresso) AS faturamento_total
FROM ingresso i
JOIN sessao s ON i.id_sessao = s.id_sessao
JOIN filme f ON s.id_filme = f.id_filme
JOIN sala sa ON s.id_sala = sa.id_sala
GROUP BY f.titulo, s.data_sessao, s.horario_sessao, sa.nome_sala;

-- View para Ocupação das Salas (RF13/RF14)
-- Mostra a capacidade real ocupada vs. total da sala
CREATE OR REPLACE VIEW view_ocupacao_salas AS
SELECT 
    sa.nome_sala AS sala,
    s.data_sessao AS data,
    s.horario_sessao AS horario,
    sa.capacidade AS capacidade_total,
    COALESCE(SUM(i.quantidade), 0) AS assentos_ocupados,
    (sa.capacidade - COALESCE(SUM(i.quantidade), 0)) AS assentos_livres,
    ROUND((COALESCE(SUM(i.quantidade), 0)::numeric / sa.capacidade::numeric) * 100, 2) AS porcentagem_ocupacao
FROM sala sa
JOIN sessao s ON sa.id_sala = s.id_sala
LEFT JOIN ingresso i ON s.id_sessao = i.id_sessao
GROUP BY sa.nome_sala, s.data_sessao, s.horario_sessao, sa.capacidade;

-- View de Histórico de Clientes (FP05)
-- Lista quais filmes cada cliente assistiu
CREATE OR REPLACE VIEW view_historico_clientes AS
SELECT 
    c.nome AS cliente,
    f.titulo AS filme,
    s.data_sessao AS data_venda,
    i.quantidade AS qtd_ingressos
FROM cliente c
JOIN ingresso i ON c.id_cliente = i.id_cliente
JOIN sessao s ON i.id_sessao = s.id_sessao
JOIN filme f ON s.id_filme = f.id_filme
ORDER BY c.nome, s.data_sessao DESC;