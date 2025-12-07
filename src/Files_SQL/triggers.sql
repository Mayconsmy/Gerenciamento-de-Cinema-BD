-- Gatilho para impedir venda acima da lotação (RF08)
CREATE TRIGGER trg_verificar_lotacao
BEFORE INSERT ON ingresso
FOR EACH ROW
EXECUTE FUNCTION verificar_capacidade();

CREATE OR REPLACE FUNCTION verificar_conflito_horario()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM sessao
        WHERE id_sala = NEW.id_sala
        AND data_sessao = NEW.data_sessao
        AND horario_sessao = NEW.horario_sessao
        AND id_sessao <> NEW.id_sessao
    ) THEN
        RAISE EXCEPTION 'Conflito: Já existe uma sessão nesta sala e horário.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_evitar_conflito_sessao
BEFORE INSERT OR UPDATE ON sessao
FOR EACH ROW
EXECUTE FUNCTION verificar_conflito_horario();