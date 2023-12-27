DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_pdus`$$

CREATE PROCEDURE `get_user_pdus` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location
		FROM Pdu
		WHERE user_id = param_userId
		ORDER BY name DESC;
END$$
DELIMITER ;