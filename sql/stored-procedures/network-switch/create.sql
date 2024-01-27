DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch`$$

CREATE PROCEDURE `create_user_network_switch` (IN param_userId INT UNSIGNED, param_name VARCHAR(255), 
												param_numOfPorts TINYINT UNSIGNED, param_location VARCHAR(255),
												param_managed BOOLEAN, param_vlanCapable BOOLEAN,
												param_poeCapable BOOLEAN)
BEGIN
	INSERT INTO NetworkSwitch (user_id, name, num_of_ports, location, managed, vlan_capable, poe_capable) 
		VALUES (param_userId, param_name, param_numOfPorts, param_location, param_managed, param_vlanCapable, param_poeCapable);

	CALL get_network_switch(LAST_INSERT_ID());
END$$
DELIMITER ;