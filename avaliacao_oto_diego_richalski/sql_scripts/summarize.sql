SELECT
	data_compra
    , COUNT(new_client(cliente, data_compra)) AS NOVOS
    , COUNT(inativate_client(cliente, data_compra)) AS INATIVADOS
    , COUNT(lost_client(cliente, data_compra)) AS PERDIDOS
    , (COUNT(new_client(cliente, data_compra)) - COUNT(inativate_client(cliente, data_compra))) AS ATIVOS
FROM 
	compras
WHERE 
    data_compra BETWEEN '2022-08-01' AND '2022-08-05'

GROUP BY 
	data_compra
ORDER BY
	data_compra;