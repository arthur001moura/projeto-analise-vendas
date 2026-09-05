#  Projeto Vendas — Análise em SQL (PostgreSQL)

Meu primeiro projeto prático de SQL, criado durante minha trilha de estudos
rumo à área de Dados. A ideia foi simular um mini sistema de vendas (tipo
uma lojinha fictícia) e responder perguntas reais de negócio usando
consultas SQL.

##  Estrutura do banco

Banco `projeto_vendas`, com 3 tabelas relacionadas:

```
clientes ← vendas → produtos
```

- **clientes**: id, nome, email
- **produtos**: id, nome, preco
- **vendas**: id, cliente_id, produto_id, quantidade (tabela "ponte")

Implementei integridade referencial com `FOREIGN KEY`, garantindo que toda
venda só possa referenciar clientes e produtos que realmente existem no
banco (testei isso na prática tentando inserir uma venda com cliente
inexistente — o PostgreSQL bloqueou corretamente ✅).

Os scripts SQL completos estão na pasta [`sql/`](./sql).

##  Perguntas de negócio respondidas

### 1. Qual cliente mais comprou (em número de vendas)?

```sql
SELECT clientes.nome, count(vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
GROUP BY clientes.nome
ORDER BY count(vendas.quantidade) DESC;
```

### 2. Qual produto vendeu mais (em unidades)?

```sql
SELECT produtos.nome, sum(vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id
GROUP BY produtos.nome
ORDER BY sum(vendas.quantidade) DESC;
```

### 3. Quanto cada cliente gastou no total?

```sql
SELECT clientes.nome, sum(produtos.preco * vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON produtos.id = vendas.produto_id
GROUP BY clientes.id
ORDER BY sum(produtos.preco * vendas.quantidade) DESC;
```

### 4. Qual foi o ticket médio geral?

```sql
SELECT AVG(produtos.preco * vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id;
```

### 5. Qual o ticket médio por cliente (considerando só quem comprou mais de uma vez)?

```sql
SELECT clientes.nome, avg(produtos.preco * vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON produtos.id = vendas.produto_id
GROUP BY clientes.id
HAVING count(vendas.quantidade) > 1
ORDER BY avg(produtos.preco * vendas.quantidade) DESC;
```

>  Achei essa métrica interessante porque ela mostra algo diferente da
> pergunta 3: um cliente pode não ser quem mais gastou no total, mas ter
> o maior ticket médio (compra pouco, mas caro).

### 6. Quais produtos estão com estoque baixo (menos de 5 unidades)?
 
```sql
SELECT nome, estoque
FROM produtos
WHERE estoque < 5
ORDER BY estoque ASC;
```
 
>  Depois que expandi o schema adicionando as colunas `categoria` e
> `estoque` (via `ALTER TABLE ADD COLUMN`), essa pergunta virou possível.
> É um filtro simples de `WHERE`, mas em um cenário real ajudaria a
> identificar produtos que precisam de reposição.
 
##  Ferramentas usadas

- PostgreSQL
- DBeaver

##  Planos futuros

- Trabalhar com um dataset mais próximo da realidade
- Adicionar Python + Pandas para limpeza e análise (Versão 2)
- Visualização/dashboard (Versão 3)
