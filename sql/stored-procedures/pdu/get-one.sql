DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_pdu`$$

CREATE PROCEDURE `get_pdu` (IN param_pduId INT UNSIGNED)
BEGIN
	SELECT id, name, location
		FROM Pdu
		WHERE id = param_pduId;
END$$
DELIMITER ;