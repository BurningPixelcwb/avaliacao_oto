CREATE TEMPORARY TABLE IF NOT EXISTS tmp_dates select cliente, max(data_compra) as last_buy from compras group by cliente;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_recency
SELECT 
	c.cliente,
	CASE
		WHEN DATEDIFF(CURRENT_DATE(), tmp.last_buy) < 30 THEN 'R5'
		WHEN DATEDIFF(CURRENT_DATE(), tmp.last_buy) > 30 AND DATEDIFF(CURRENT_DATE(), tmp.last_buy) <= 60 THEN 'R4'
        WHEN DATEDIFF(CURRENT_DATE(), tmp.last_buy) > 60 AND DATEDIFF(CURRENT_DATE(), tmp.last_buy) <= 120 THEN 'R3'
        WHEN DATEDIFF(CURRENT_DATE(), tmp.last_buy) > 120 AND DATEDIFF(CURRENT_DATE(), tmp.last_buy) <= 180 THEN 'R2'
        WHEN DATEDIFF(CURRENT_DATE(), tmp.last_buy) > 180 THEN 'R1'
    END as recency
	 
FROM 
	tmp_dates AS tmp
    
LEFT JOIN
	compras AS c
    ON c.cliente = tmp.cliente
GROUP BY 
	tmp.cliente;

-- Gerando tabela de frequencia
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_frequency
SELECT
	cliente, 
    CASE
		WHEN count(cliente) > 10 THEN 'F5'
        WHEN count(cliente) > 6 AND count(cliente) <= 8 THEN 'F4'
        WHEN count(cliente) > 5 AND count(cliente) <= 6 THEN 'F3'
        WHEN count(cliente) > 1 AND count(cliente) <= 5 THEN 'F2'
        WHEN count(cliente) > 0 AND count(cliente) <= 1 THEN 'F1'
	END AS frequency
    
FROM 
	compras

WHERE
	(datediff(CURRENT_DATE(), data_compra)) <= 60
GROUP BY
	cliente;

-- Gerando tabela com frequencias fora do periodo de 60 dias
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_out_frequency
SELECT
	cliente, 
	COUNT(cliente) AS frequency
    
FROM 
	compras

WHERE
	(datediff(CURRENT_DATE(), data_compra)) >= 60
GROUP BY
	cliente;
    
-- Gerando tabela com soma de vendas
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_ticket 
select 
	cliente, 
    sum(valor) AS ticket

from 
	compras 
    
group by 
	cliente;
    
CREATE TABLE IF NOT EXISTS rfv_table 
SELECT 
	c.cliente,
    r.recency,
    IF(f.frequency IS NULL, 'F1', f.frequency) AS frequency,
    t.ticket AS 'value'
    
FROM compras as c

LEFT JOIN 
	tmp_recency AS r
    ON r.cliente = c.cliente

LEFT JOIN
	tmp_frequency AS f
    ON f.cliente = c.cliente
    
LEFT JOIN 
	tmp_ticket AS t
    ON t.cliente = c.cliente

GROUP BY
	c.cliente;