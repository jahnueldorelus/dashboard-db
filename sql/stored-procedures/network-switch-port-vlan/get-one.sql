DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_network_switch_port_vlan`$$

CREATE PROCEDURE `get_network_switch_port_vlan` (IN param_switchPortVlanId INT UNSIGNED)
BEGIN
	SELECT id, switch_vlan_id as switchVlanId, switch_port_id as switchPortId, mode
		FROM NetworkSwitchPortVlan
		WHERE id = param_switchPortVlanId;
END$$
DELIMITER ;