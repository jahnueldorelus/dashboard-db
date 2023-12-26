DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_pdu_ports`$$

CREATE PROCEDURE `get_user_pdu_ports` (IN param_userId INT UNSIGNED, param_pduId INT UNSIGNED)
BEGIN
	SELECT PduPort.id, PduPort.pdu_id AS pduId, PduPort.port_number AS portNumber, PduPort.name 
		FROM Pdu
			INNER JOIN PduPort ON Pdu.id = PduPort.pdu_id
		WHERE Pdu.user_id = param_userId AND Pdu.id = param_pduId
		ORDER BY PduPort.port_number;
END$$
DELIMITER ;