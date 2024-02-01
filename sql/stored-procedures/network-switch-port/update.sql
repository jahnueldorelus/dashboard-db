DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_port`$$

CREATE PROCEDURE `update_user_network_switch_port` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED,
													param_portNumber TINYINT UNSIGNED, param_name VARCHAR(255), 
													param_pvid SMALLINT UNSIGNED, param_mode ENUM("access", "trunk", "general"))
BEGIN
	SET @switch_id = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);

	-- If the network switch port doesn't exist
	IF (ISNULL(@switch_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a network switch port that doesn't exist";
	END IF;

	-- If the network switch port doesn't belong to the user
	SET @switch_port_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id);
	IF (@switch_port_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a network switch port you don't own";
	END IF;


	UPDATE NetworkSwitchPort SET port_number = param_portNumber, name = param_name, pvid = param_pvid, mode = param_mode
				WHERE id = param_switchPortId;
	
	CALL get_network_switch_port(param_switchPortId);
END$$
DELIMITER ;