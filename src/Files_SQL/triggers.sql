-- Gatilhos (Triggers) (No mi�nimo 2)

-- 1. TRIGGER: verificar_capacidade_sala_venda
-- Finalidade: Impedir a inserção de um ingresso se a quantidade total de ingressos vendidos para a sessão exceder a capacidade da sala.
-- Disparado: ANTES de uma inserção na tabela 'ingresso'.
-- Ação: Verifica a capacidade restante e levanta uma exceção se a venda for impossível.

CREATE OR REPLACE FUNCTION verificar_capacidade_sala_venda_func()
RETURNS TRIGGER AS $$
DECLARE
    v_capacidade_sala INT;
    v_ingressos_vendidos INT;
    v_sala_nome VARCHAR;
BEGIN
    -- 1. Busca a capacidade da sala
    SELECT s.capacidade, s.nome_sala
    INTO v_capacidade_sala, v_sala_nome
    FROM sala s
    JOIN sessao se ON s.id_sala = se.id_sala
    WHERE se.id_sessao = NEW.id_sessao;

    -- 2. Soma quantos ingressos JÁ foram vendidos para essa sessão (excluindo a venda atual)
    SELECT COALESCE(SUM(quantidade), 0)
    INTO v_ingressos_vendidos
    FROM ingresso
    WHERE id_sessao = NEW.id_sessao;

    -- 3. Verifica se a nova quantidade (NEW.quantidade) mais o que já foi vendido excede a capacidade
    IF (v_ingressos_vendidos + NEW.quantidade) > v_capacidade_sala THEN
        RAISE EXCEPTION 'VENDA RECUSADA (Trigger): A sala "%" tem capacidade de % assentos. Já foram vendidos % e a nova venda de % excede o limite.',
        v_sala_nome, v_capacidade_sala, v_ingressos_vendidos, NEW.quantidade;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_capacidade_sala_venda
BEFORE INSERT ON ingresso
FOR EACH ROW
EXECUTE FUNCTION verificar_capacidade_sala_venda_func();


-- 2. TRIGGER: atualizar_documento_cliente
-- Finalidade: Garantir que o campo 'documento' na tabela 'cliente' seja sempre armazenado em maiúsculas, para padronização e evitar duplicidade.
-- Disparado: ANTES de uma inserção ou atualização na tabela 'cliente'.
-- Ação: Converte o campo 'documento' para maiúsculas.

CREATE OR REPLACE FUNCTION atualizar_documento_cliente_func()
RETURNS TRIGGER AS $$
BEGIN
    NEW.documento := UPPER(NEW.documento);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_documento_cliente
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
EXECUTE FUNCTION atualizar_documento_cliente_func();
