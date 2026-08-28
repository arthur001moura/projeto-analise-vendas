-- Criação do banco de dados (rodar isso separado, fora de uma transação com as tabelas)
-- CREATE DATABASE projeto_vendas;

-- Tabela de clientes
CREATE TABLE clientes (
    id INTEGER PRIMARY KEY,
    nome VARCHAR,
    email VARCHAR
);

-- Tabela de produtos
CREATE TABLE produtos (
    id INTEGER PRIMARY KEY,
    nome VARCHAR,
    preco DECIMAL
);

-- Tabela de vendas (funciona como "ponte" entre clientes e produtos)
CREATE TABLE vendas (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    produto_id INTEGER,
    quantidade INTEGER
);
