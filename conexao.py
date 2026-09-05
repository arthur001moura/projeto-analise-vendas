import psycopg2
import pandas as pd
import os
from dotenv import load_dotenv

load_dotenv()

dicionario = {"mais_comprou" :"""SELECT clientes.nome, count(vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
GROUP BY clientes.nome
ORDER BY count(vendas.quantidade) DESC;
""","produtos_mais_vendidos" : """SELECT produtos.nome, sum(vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id
GROUP BY produtos.nome
ORDER BY sum(vendas.quantidade) DESC;
""","gastos_cliente_total":"""SELECT clientes.nome, sum(produtos.preco * vendas.quantidade)
FROM clientes
INNER JOIN vendas ON clientes.id = vendas.cliente_id
INNER JOIN produtos ON produtos.id = vendas.produto_id
GROUP BY clientes.id
ORDER BY sum(produtos.preco * vendas.quantidade) DESC;
""","avg_tickets":"""SELECT AVG(produtos.preco * vendas.quantidade)
FROM produtos
INNER JOIN vendas ON produtos.id = vendas.produto_id;"""}   

conexao = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=os.getenv("DB_PORT")
)

print("Conectado com sucesso!")

for key, value in dicionario.items():
    print(f"Query: {key}")
    df = pd.read_sql(value, conexao)
    df.to_csv(f"{key}.csv", index=False)
    print(f"Exportado: {key}.csv")