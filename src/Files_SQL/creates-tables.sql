
-- Criação das Tabelas
-- Baseado no Dicionário de Dados (páginas 19-22 do PDF)
 CREATE DATABASE cinema_db;

-- Criação das Tabelas
CREATE TABLE filme (
    id_filme SERIAL PRIMARY KEY, -- 
    titulo VARCHAR(150) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    duracao INTEGER NOT NULL, -- em minutos
    classificacao VARCHAR(20) NOT NULL,
    sinopse TEXT
);

CREATE TABLE sala (
    id_sala SERIAL PRIMARY KEY, -- [cite: 344]
    nome_sala VARCHAR(100) NOT NULL,
    capacidade INTEGER NOT NULL,
    tipo_sala VARCHAR(50) NOT NULL -- Ex: 2D, 3D
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY, -- [cite: 355]
    nome VARCHAR(150) NOT NULL,
    documento VARCHAR(20) NOT NULL UNIQUE, -- CPF
    email VARCHAR(150),
    telefone VARCHAR(20)
);

CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY, -- [cite: 358]
    nome VARCHAR(150) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    email VARCHAR(150)
);

CREATE TABLE sessao (
    id_sessao SERIAL PRIMARY KEY, -- [cite: 348]
    data_sessao DATE NOT NULL,
    horario_sessao TIME NOT NULL,
    valor_ingresso NUMERIC(10,2) NOT NULL,
    id_filme INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    CONSTRAINT fk_sessao_filme FOREIGN KEY (id_filme) REFERENCES filme (id_filme),
    CONSTRAINT fk_sessao_sala FOREIGN KEY (id_sala) REFERENCES sala (id_sala)
);

CREATE TABLE ingresso (
    id_ingresso SERIAL PRIMARY KEY, -- [cite: 351]
    quantidade INTEGER NOT NULL DEFAULT 1,
    data_venda DATE DEFAULT CURRENT_DATE,
    id_sessao INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    CONSTRAINT fk_ingresso_sessao FOREIGN KEY (id_sessao) REFERENCES sessao (id_sessao),
    CONSTRAINT fk_ingresso_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    CONSTRAINT fk_ingresso_func FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario)
);