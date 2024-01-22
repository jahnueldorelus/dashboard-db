DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_network_switch_vlan`$$

CREATE PROCEDURE `get_network_switch_vlan` (IN param_switchVlanId INT UNSIGNED)
BEGIN
	SELECT id, switch_id as switchId, name, vid
		FROM NetworkSwitchVlan
		WHERE id = param_switchId;
END$$
DELIMITER ;