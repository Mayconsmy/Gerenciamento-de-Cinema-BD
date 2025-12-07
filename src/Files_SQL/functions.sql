-- Função para verificar disponibilidade de assentos
CREATE OR REPLACE FUNCTION verificar_capacidade()
RETURNS TRIGGER AS $$
DECLARE
    lugares_ocupados INTEGER;
    capacidade_sala INTEGER;
BEGIN
    -- Busca a capacidade da sala da sessão
    SELECT s.capacidade INTO capacidade_sala
    FROM sala s
    JOIN sessao se ON s.id_sala = se.id_sala
    WHERE se.id_sessao = NEW.id_sessao;

    -- Conta quantos ingressos já foram vendidos para esta sessão
    SELECT COALESCE(SUM(quantidade), 0) INTO lugares_ocupados
    FROM ingresso
    WHERE id_sessao = NEW.id_sessao;

    -- Verifica se a nova venda ultrapassa a capacidade
    IF (lugares_ocupados + NEW.quantidade) > capacidade_sala THEN
        RAISE EXCEPTION 'Venda não autorizada: Capacidade da sala excedida.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;