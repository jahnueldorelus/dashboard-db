DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_pdu_port`$$

CREATE PROCEDURE `update_user_pdu_port` (IN param_userId INT UNSIGNED, param_pduPortId INT UNSIGNED, 
											param_portNumber TINYINT UNSIGNED, param_name VARCHAR(255))
BEGIN
	SET @pduId = (SELECT pdu_id FROM PduPort WHERE id = param_pduPortId);
	SET @pduUserId = (SELECT user_id FROM Pdu WHERE id = @pduId);

	-- If the power distribution unit port doesn't belong to the user
	IF @pduUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a power distribution unit port the user doesn't have";
	END IF;

	UPDATE PduPort SET port_number = param_portNumber, name = param_name
					WHERE id = param_pduPortId;

	CALL get_pdu_port(param_pduPortId);
END$$
DELIMITER ;