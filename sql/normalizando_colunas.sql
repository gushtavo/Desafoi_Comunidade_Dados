USE dw_vendas;

SELECT * FROM staging_vendas;

-- Alterando a coluna 'preco_unitario' para DECIMAL
ALTER TABLE staging_vendas
	ALTER COLUMN preco_unitario DECIMAL(10, 2);

-- Adicionando a coluna 'valor_venda'
ALTER TABLE staging_vendas
	ADD valor_venda AS (quantidade * preco_unitario);

-- Corrigindo as siglas dos Estado correspondente a cidade
UPDATE staging_vendas
SET estado = CASE
				WHEN cidade = 'São Paulo' THEN 'SP'
				WHEN cidade = 'Porto Alegre' THEN 'RS'
				WHEN cidade = 'Curitiba' THEN 'PR'
				WHEN cidade = 'Belo Horizonte' THEN 'MG'
				WHEN cidade = 'Rio de Janeiro' THEN 'RJ'
				ELSE cidade
			END
			WHERE cidade IN ('São Paulo', 'Porto Alegre', 'Curitiba', 'Belo Horizonte', 'Rio de Janeiro');

-- criando tabela para receber os dados normalizados
CREATE TABLE vendas (
	id_venda INT PRIMARY KEY NOT NULL,
	data_venda DATE,
	cliente VARCHAR(50),
	produto VARCHAR(50),
	categoria VARCHAR(50),
	quantidade SMALLINT,
	preco_unitario DECIMAL(10, 2),
	vendedor VARCHAR(50),
	cidade VARCHAR(50),
	estado VARCHAR(50),
	valor_venda DECIMAL(10, 2)
);

-- inserindo os dados normalizados na tabela 'vendas'
INSERT INTO vendas (id_venda, data_venda, cliente, produto, categoria, quantidade, preco_unitario, vendedor, cidade, estado, valor_venda)
SELECT
	id_venda,
	data_venda,
	cliente,
	produto,
	categoria,
	quantidade,
	preco_unitario,
	vendedor,
	cidade,
	estado,
	valor_venda
FROM staging_vendas;

-- Conferindo a inserção
SELECT * FROM vendas;