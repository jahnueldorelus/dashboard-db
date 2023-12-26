DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_pdu_port`$$

CREATE PROCEDURE `get_pdu_port` (IN param_pduPortId INT UNSIGNED)
BEGIN
	SELECT id, pdu_id AS pduId, port_number as portNumber, name
		FROM PduPort
		WHERE PduPort.id = param_pduPortId;
END$$
DELIMITER ;