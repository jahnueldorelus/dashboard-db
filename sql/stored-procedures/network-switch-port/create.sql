DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch_port`$$

CREATE PROCEDURE `create_user_network_switch_port` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED, 
													param_portNumber TINYINT UNSIGNED, param_name VARCHAR(255), 
													param_pvid SMALLINT UNSIGNED, param_mode ENUM("access", "trunk", "general"))
BEGIN
	SET @errorMessage = "Cannot create a port in a network switch the user doesn't have";
	SET @switchUserId = (SELECT user_id FROM NetworkSwitch  
							WHERE NetworkSwitch.id = param_switchId);

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	INSERT INTO NetworkSwitchPort (switch_id, port_number, name, pvid, mode) 
		VALUES (param_switchId, param_portNumber, param_name, param_pvid, param_mode);

	CALL get_network_switch_port(LAST_INSERT_ID());
END$$
DELIMITER ;