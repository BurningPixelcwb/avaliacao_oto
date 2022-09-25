delimiter $$;
CREATE FUNCTION `new_client`(cli int, dt_comp DATE) RETURNS int(11)
BEGIN

RETURN (SELECT IF(MIN(data_compra) != dt_comp, NULL, data_compra) FROM compras WHERE cliente = cli);
END$$
delimiter ;