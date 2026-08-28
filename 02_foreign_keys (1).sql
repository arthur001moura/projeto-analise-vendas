-- Garante que todo cliente_id em vendas realmente existe na tabela clientes
ALTER TABLE vendas
ADD CONSTRAINT fk_clientes
FOREIGN KEY (cliente_id)
REFERENCES clientes (id);

-- Garante que todo produto_id em vendas realmente existe na tabela produtos
ALTER TABLE vendas
ADD CONSTRAINT fk_produtos
FOREIGN KEY (produto_id)
REFERENCES produtos (id);

-- Teste (não roda de propósito, só documentação): isso aqui deve dar erro,
-- porque cliente_id = 999 não existe em clientes.
-- INSERT INTO vendas (id, cliente_id, produto_id, quantidade)
-- VALUES (9, 999, 1, 1);
