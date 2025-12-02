-- Criação das Tabelas
-- Baseado no Dicionário de Dados (páginas 19-22 do PDF)
CREATE DATABASE cinema_db;

CREATE TABLE filme (
    id_filme SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    duracao INTEGER NOT NULL, -- em minutos
    classificacao VARCHAR(20) NOT NULL,
    sinopse TEXT
);

CREATE TABLE sala (
    id_sala SERIAL PRIMARY KEY,
    nome_sala VARCHAR(100) NOT NULL,
    capacidade INTEGER NOT NULL,
    tipo_sala VARCHAR(50) NOT NULL -- Ex: 2D ou 3D
);

CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    e_mail VARCHAR(150)
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    documento VARCHAR(20) NOT NULL, -- CPF ou outro documento
    e_mail VARCHAR(150),
    telefone VARCHAR(20)
);

-- Tabela SESSAO (Depende de FILME e SALA)
CREATE TABLE sessao (
    id_sessao SERIAL PRIMARY KEY,
    data_sessao DATE NOT NULL,
    horario_sessao TIME NOT NULL,
    valor_ingresso NUMERIC(10, 2) NOT NULL,
    
    -- Chaves Estrangeiras
    id_filme INTEGER NOT NULL, -- FK: filme exibido na sessão [cite: 264]
    id_sala INTEGER NOT NULL,  -- FK: sala onde a sessão ocorre [cite: 264]
    
    FOREIGN KEY (id_filme) REFERENCES filme (id_filme),
    FOREIGN KEY (id_sala) REFERENCES sala (id_sala),
    
    -- Restrição de Conflito de Agendamento (RF06)
    UNIQUE (id_sala, data_sessao, horario_sessao)
);

-- Tabela INGRESSO (Depende de SESSAO, CLIENTE e FUNCIONARIO)
CREATE TABLE ingresso (
    id_ingresso SERIAL PRIMARY KEY,
    quantidade INTEGER NOT NULL,
    data_venda DATE NOT NULL,
    
    -- Chaves Estrangeiras
    id_sessao INTEGER NOT NULL,      -- FK: sessão correspondente à venda [cite: 268]
    id_cliente INTEGER,              -- FK: cliente que comprou (pode ser NULL se for venda avulsa - RF10) [cite: 268]
    id_funcionario INTEGER NOT NULL, -- FK: funcionário responsável pela venda [cite: 268]
    
    FOREIGN KEY (id_sessao) REFERENCES sessao (id_sessao),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario)
);