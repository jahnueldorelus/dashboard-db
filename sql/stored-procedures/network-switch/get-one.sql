DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_network_switch`$$

CREATE PROCEDURE `get_network_switch` (IN param_switchId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location, managed, vlan_capable AS vlanCapable,
			poe_capable AS poeCapable
		FROM NetworkSwitch
		WHERE id = param_switchId;
END$$
DELIMITER ;