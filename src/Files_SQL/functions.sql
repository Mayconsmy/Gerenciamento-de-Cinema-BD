-- pasta  de criação de funções sql

CREATE OR REPLACE FUNCTION realizar_venda(
    p_id_sessao INT,
    p_id_funcionario INT,
    p_quantidade INT,
    p_id_cliente INT DEFAULT NULL -- Pode ser nulo (Venda Avulsa - RF10)
) RETURNS TEXT AS $$
DECLARE
    v_capacidade_sala INT;
    v_ingressos_vendidos INT;
    v_sala_nome VARCHAR;
    v_assentos_restantes INT;
BEGIN
    -- 1. Busca a capacidade da sala e o nome dela através da sessão
    SELECT s.capacidade, s.nome_sala 
    INTO v_capacidade_sala, v_sala_nome
    FROM sala s
    JOIN sessao se ON s.id_sala = se.id_sala
    WHERE se.id_sessao = p_id_sessao;

    -- Se não achar a sessão, para tudo
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sessão % não encontrada.', p_id_sessao;
    END IF;

    -- 2. Soma quantos ingressos já foram vendidos para essa sessão
    SELECT COALESCE(SUM(quantidade), 0) 
    INTO v_ingressos_vendidos
    FROM ingresso
    WHERE id_sessao = p_id_sessao;

    -- Calcula quantos sobram
    v_assentos_restantes := v_capacidade_sala - v_ingressos_vendidos;

    -- 3. Verifica se a nova quantidade cabe
    IF p_quantidade > v_assentos_restantes THEN
        RAISE EXCEPTION 'VENDA RECUSADA: A sala "%" só tem % lugares restantes. Você tentou vender %.', 
        v_sala_nome, v_assentos_restantes, p_quantidade;
    ELSE
        -- 4. Se couber, insere na tabela INGRESSO
        INSERT INTO ingresso (quantidade, data_venda, id_sessao, id_cliente, id_funcionario)
        VALUES (p_quantidade, CURRENT_DATE, p_id_sessao, p_id_cliente, p_id_funcionario);
        
        RETURN 'Venda realizada com sucesso! Assentos restantes: ' || (v_assentos_restantes - p_quantidade);
    END IF;
END;
$$ LANGUAGE plpgsql;