delimiter $$
CREATE DEFINER=`root`@`localhost` FUNCTION `lost_client`(cli int, dt_comp DATE) RETURNS int(11)
BEGIN

RETURN (SELECT SUM(IF(DATEDIFF(CURRENT_DATE(), dt_comp) > 730, 1, NULL)) FROM compras WHERE cliente = cli);
END $$
delimiter ;