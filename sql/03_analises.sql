
-- 1. Qual cliente mais comprou (em número de vendas)?

SELECT clientes.nome, count(vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
GROUP BY clientes.nome
ORDER BY count(vendas.quantidade) DESC;


-- 2. Qual produto vendeu mais (em unidades)?

SELECT produtos.nome, sum(vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id
GROUP BY produtos.nome
ORDER BY sum(vendas.quantidade) DESC;


-- 3. Quanto cada cliente gastou no total?

SELECT clientes.nome, sum(produtos.preco * vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON produtos.id = vendas.produto_id
GROUP BY clientes.id
ORDER BY sum(produtos.preco * vendas.quantidade) DESC;



-- 4. Qual foi o ticket médio geral?

SELECT AVG(produtos.preco * vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id;


-- 5. Qual o ticket médio por cliente?
-- (considerando só quem comprou mais de uma vez)

SELECT clientes.nome, avg(produtos.preco * vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON produtos.id = vendas.produto_id
GROUP BY clientes.id
HAVING count(vendas.quantidade) > 1
ORDER BY avg(produtos.preco * vendas.quantidade) DESC;

-- 6. Quais produtos estão com estoque baixo (menos de 5 unidades)?

SELECT nome, estoque
FROM produtos
WHERE estoque < 5
ORDER BY estoque ASC;
