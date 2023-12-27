DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_pdu`$$

CREATE PROCEDURE `create_user_pdu` (IN param_userId INT UNSIGNED, param_name VARCHAR(255), 
									param_numOfPorts TINYINT UNSIGNED, param_location VARCHAR(255))
BEGIN
	INSERT INTO Pdu (user_id, name, num_of_ports, location) 
		VALUES (param_userId, param_name, param_numOfPorts, param_location);

	CALL get_pdu(LAST_INSERT_ID());
END$$
DELIMITER ;