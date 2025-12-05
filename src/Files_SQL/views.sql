-- Views (No mínimo 2)

-- 1. VIEW: sessoes_disponiveis
-- Finalidade: Simplificar a consulta para o cliente, mostrando apenas as sessões futuras com o nome do filme e da sala.
CREATE VIEW sessoes_disponiveis AS
SELECT
    s.id_sessao,
    f.titulo AS filme,
    sa.nome_sala AS sala,
    s.data_sessao,
    s.horario_sessao,
    s.valor_ingresso
FROM
    sessao s
JOIN
    filme f ON s.id_filme = f.id_filme
JOIN
    sala sa ON s.id_sala = sa.id_sala
WHERE
    s.data_sessao >= CURRENT_DATE
ORDER BY
    s.data_sessao, s.horario_sessao;

-- 2. VIEW: relatorio_vendas_por_funcionario
-- Finalidade: Controlar o desempenho dos funcionários, mostrando o total de ingressos vendidos e o valor total transacionado por cada um.
CREATE VIEW relatorio_vendas_por_funcionario AS
SELECT
    f.nome AS nome_funcionario,
    f.cargo,
    COUNT(i.id_ingresso) AS total_vendas,
    SUM(i.quantidade) AS total_ingressos_vendidos,
    SUM(i.quantidade * s.valor_ingresso) AS valor_total_transacionado
FROM
    funcionario f
JOIN
    ingresso i ON f.id_funcionario = i.id_funcionario
JOIN
    sessao s ON i.id_sessao = s.id_sessao
GROUP BY
    f.id_funcionario, f.nome, f.cargo
ORDER BY
    valor_total_transacionado DESC;