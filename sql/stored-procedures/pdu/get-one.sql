DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_pdu`$$

CREATE PROCEDURE `get_pdu` (IN param_pduId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location
		FROM Pdu
		WHERE id = param_pduId;
END$$
DELIMITER ;