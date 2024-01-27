DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_switches`$$

CREATE PROCEDURE `get_user_network_switches` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location, managed, vlan_capable AS vlanCapable,
			poe_capable AS poeCapable
		FROM NetworkSwitch
		WHERE user_id = param_userId
		ORDER BY name DESC;
END$$
DELIMITER ;