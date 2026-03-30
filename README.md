# Desafio — Análise de Vendas E-commerce

Parcitipei do Desafio proposto pelo [walter Gonzaga](https://www.youtube.com/@gonzagadosdados) da `Comunidade dos Dados`.

## Contexto

Você trabalha em uma empresa de e-commerce e recebeu uma base de vendas. Seu objetivo é transformar esses dados em informações de negócio utilizando SQL e Python. Esse desafio simula uma situação real de trabalho onde o profissional de dados precisa extrair, transformar e analisar dados para gerar insights.

- **Dashboard** : [Acesse Aqui](https://app.powerbi.com/view?r=eyJrIjoiMTI4ZTA0YTYtMTljYi00OWI4LWEwOGEtMTIxNmE3Y2NkMWFiIiwidCI6IjM2Yzc4ZDUwLThlY2UtNDNmYS1iMThlLTFlOWE5ZTNjNDI1ZCJ9)
---

## Estrutura do Projeto

```
desafio_comuniDados/
├── data/
│   ├── vendas_desafio.csv         # Base de dados bruta
│   ├── vendas_normalizadas.csv    # Dados após limpeza e normalização
│   └── resumo_vendas.csv          # Resumo agregado por produto e categoria
├── sql/
│   ├── normalizando_colunas.sql   # Script de criação e normalização das tabelas
│   └── queries_analises.sql       # Queries analíticas de negócio
├── notebook/
│   └── analises.ipynb             # Análise exploratória e visualizações em Python
├── pyproject.toml
└── uv.lock
```

---

## Sobre os Dados

A base `vendas_desafio.csv` contém registros de vendas do ano de 2024 com as seguintes colunas:

| Coluna           | Descrição                          |
|------------------|------------------------------------|
| `id_venda`       | Identificador único da venda       |
| `data_venda`     | Data da realização da venda        |
| `cliente`        | Nome do cliente                    |
| `produto`        | Produto vendido                    |
| `categoria`      | Categoria do produto               |
| `quantidade`     | Quantidade de itens vendidos       |
| `preco_unitario` | Preço unitário do produto          |
| `vendedor`       | Nome do vendedor responsável       |
| `cidade`         | Cidade da venda                    |
| `estado`         | Sigla do estado                    |

**Problema de qualidade identificado:** as siglas de `estado` estavam inconsistentes em relação às cidades — corrigido tanto via SQL quanto via Python.

---

## Etapas do Projeto

### 1. Normalização dos Dados (SQL)

Arquivo: [sql/normalizando_colunas.sql](sql/normalizando_colunas.sql)

- Criação do banco `dw_vendas` e tabela de staging (`staging_vendas`)
- Conversão do tipo da coluna `preco_unitario` para `DECIMAL(10,2)`
- Criação da coluna calculada `valor_venda = quantidade * preco_unitario`
- Correção das siglas de estado com base na cidade
- Criação da tabela `vendas` normalizada e inserção dos dados tratados

### 2. Análises de Negócio (SQL)

Arquivo: [sql/queries_analises.sql](sql/queries_analises.sql)

| Análise                          | Técnica utilizada         |
|----------------------------------|---------------------------|
| Faturamento por produto          | `GROUP BY` + `SUM`        |
| Faturamento por categoria        | `GROUP BY` + `SUM`        |
| Ticket médio por cliente         | `GROUP BY` + `AVG`        |
| Faturamento por vendedor         | `GROUP BY` + `SUM`        |
| Faturamento mensal               | `MONTH()` + `GROUP BY`    |
| Top 5 produtos mais vendidos     | `TOP 5` + `ORDER BY`      |
| Cidade com maior faturamento     | `TOP 1` + `ORDER BY`      |
| Cliente que mais comprou         | `TOP 1` + `ORDER BY`      |
| Resumo por produto e categoria   | CTE (`WITH`)              |

### 3. Análise Exploratória e Visualizações (Python)

Arquivo: [notebook/analises.ipynb](notebook/analises.ipynb)

- Carregamento e inspeção da base com **Pandas**
- Correção das siglas de estado via `loc`
- Criação da coluna `valor_venda`
- Agrupamentos por produto, categoria e cliente (faturamento e quantidade)
- Análise de desempenho por vendedor (qtd de vendas e valor total)
- Análise de sazonalidade: faturamento mensal ao longo de 2024
- Análise de recorrência de clientes
- Gráfico de barras de faturamento por categoria com **Seaborn** e **Matplotlib**
- Exportação dos dados normalizados e do resumo de vendas para CSV

---

## Principais Insights

### Faturamento
- **Notebook** é o produto de maior faturamento: **R$ 8.290.852,39**
- **Eletrônicos** é a categoria líder, com **R$ 11.741.663,09** em faturamento
- A categoria **Móveis** ocupa o segundo lugar com **R$ 4.722.771,51**
- Os dados cobrem **282 clientes distintos** e **10 produtos** em **4 categorias**

### Volume de Vendas (Quantidade)
- **Eletrônicos** também lidera em quantidade: **12.593 unidades** vendidas — mais que o dobro da segunda colocada (Livros, 4.944)
- **Monitor** é o produto com mais registros de venda: **1.045 transações**, seguido de Mochila (1.037) e Mouse (1.036)

### Sazonalidade
- **Abril/2024** foi o mês de maior faturamento: **R$ 1.571.459,42**
- **Dezembro/2024** registrou o menor faturamento: **R$ 1.223.728,66** — queda de ~22% em relação ao pico
- Os meses de março, abril e setembro formam o trimestre mais forte do ano

### Vendedores
- **Ana** lidera em valor total: **R$ 3.544.588,45**, com 1.982 vendas realizadas
- **Daniela** lidera em quantidade de vendas: **2.053 transações**, mas com ticket médio menor
- Os cinco vendedores apresentam performance equilibrada — diferença de apenas ~2% entre o primeiro e o último em faturamento

### Clientes
- **Alexandre** é o cliente mais recorrente: **50 compras** ao longo de 2024
- Todos os 282 clientes compraram mais de uma vez, indicando boa retenção da base

---

## Tecnologias Utilizadas

![Microsoft SQL Server](https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=flat-square&logo=microsoft-sql-server&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_Bi-F2C811?style=flat-square&logo=codeforces&logoColor=black)
- **Python 3.14+** — pandas, seaborn, matplotlib
- **SQL** — T-SQL (SQL Server) com DDL, DML, agregações e CTEs
- **Power BI** — Modelagem, KPIs e DAX
- **uv** — gerenciamento de dependências e ambiente virtual

---

## 📩 Contato
[Linkedin](https://www.linkedin.com/in/gushtavoroberto/) | 📧 almeida.gustavo0420@gmail.com
