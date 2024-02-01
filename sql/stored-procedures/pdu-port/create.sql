DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_pdu_port`$$

CREATE PROCEDURE `create_user_pdu_port` (IN param_userId INT UNSIGNED, param_pduId INT UNSIGNED, 
											param_portNumber TINYINT UNSIGNED, param_name VARCHAR(255))
BEGIN
	SET @pdu_user_id = (SELECT user_id FROM Pdu WHERE id = param_pduId);

	-- If the power distribution unit doesn't exist
	IF (ISNULL(@pdu_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a port on a power distribution unit that doesn't exist";
	END IF;

	-- If the power distribution unit doesn't belong to the user
	IF (@pdu_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a port on a power distribution unit you don't own";
	END IF;

	INSERT INTO PduPort (pdu_id, port_number, name) VALUES (param_pduId, param_portNumber, param_name);

	CALL get_pdu_port(LAST_INSERT_ID());
END$$
DELIMITER ;