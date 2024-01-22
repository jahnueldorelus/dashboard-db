DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_port`$$

CREATE PROCEDURE `update_user_network_switch_port` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED,
													param_portNumber TINYINT UNSIGNED, param_name VARCHAR(255), 
													param_pvid SMALLINT UNSIGNED, param_mode ENUM("access", "trunk", "general"))
BEGIN
	SET @errorMessage = "Cannot update a port in a network switch the user doesn't have";
	SET @switchPortUserId = (SELECT user_id FROM NetworkSwitchPort 
								LEFT JOIN NetworkSwitch  
									ON NetworkSwitchPort.switch_id = NetworkSwitch.id
								WHERE NetworkSwitchPort.id = param_switchPortId);

	-- If the network switch port doesn't exist
	IF ISNULL(@switchPortUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch port doesn't belong to the user
	IF @switchPortUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;


	UPDATE NetworkSwitchPort SET port_number = param_portNumber, name = param_name, pvid = param_pvid, mode = param_mode
				WHERE id = param_switchPortId;
	
	CALL get_network_switch_port(param_switchPortId);
END$$
DELIMITER ;