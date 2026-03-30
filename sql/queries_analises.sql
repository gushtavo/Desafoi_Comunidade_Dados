SELECT * FROM vendas;

-- Fatumento por Produto
SELECT
	produto,
	SUM(valor_venda) AS faturamento_total
FROM vendas
GROUP BY produto
ORDER BY faturamento_total DESC;

-- Faturamento por Categoria
SELECT
	categoria,
	SUM(valor_venda) AS faturamento_total
FROM vendas
GROUP BY categoria
ORDER BY faturamento_total DESC;

-- Ticket médio por Cliente
SELECT
	cliente,
	ROUND(AVG(valor_venda), 2) AS ticket_medio
FROM vendas
GROUP BY cliente
ORDER BY ticket_medio DESC;

-- Faturamento por Vendedor
SELECT
	vendedor,
	SUM(valor_venda) AS faturamento_total
FROM vendas
GROUP BY vendedor
ORDER BY faturamento_total DESC;

-- Faturamento por Mês
SELECT
	MONTH(data_venda) AS mes,
	SUM(valor_venda) AS faturamento_total
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY mes;

-- Top 5 produtos vendidos
SELECT TOP 5
	produto,
	SUM(quantidade) AS qtd_vendidas
FROM vendas
GROUP BY produto
ORDER BY qtd_vendidas DESC;

-- Cidade com maior Faturamento
SELECT TOP 1
	cidade,
	SUM(valor_venda) AS faturamento_total
FROM vendas
GROUP BY cidade
ORDER BY faturamento_total DESC;

-- Cliente que mais comprou em valor
SELECT TOP 1
	cliente,
	SUM(valor_venda) AS valor_gasto
FROM vendas
GROUP BY cliente
ORDER BY valor_gasto DESC;

-- Criando CTE 'resumo_vendas' com as seguintes colunas: produto, categoria, quantidade_total e faturamento_total
WITH resumo_vendas AS (
	SELECT 
		produto,
		categoria,
		SUM(quantidade) AS quantidade_total,
		SUM(valor_venda) AS faturamento_total
	FROM vendas
	GROUP BY produto, categoria
)
SELECT
	*
FROM resumo_vendas;

-- Porcentagem do mes anterior
SELECT
    YEAR(data_venda) AS Ano,
    MONTH(data_venda) AS Mes,
    SUM(valor_venda) AS Vendas_Mes,
    LAG(SUM(valor_venda)) OVER (
        ORDER BY YEAR(data_venda), MONTH(data_venda)
    ) AS Vendas_Mes_Anterior,
    ROUND(
        (SUM(valor_venda) - LAG(SUM(valor_venda)) OVER (ORDER BY YEAR(data_venda), MONTH(data_venda)))
        / NULLIF(LAG(SUM(valor_venda)) OVER (ORDER BY YEAR(data_venda), MONTH(data_venda)), 0)
        * 100, 2
    ) AS Variacao_Pct
FROM vendas
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY Ano, Mes;
