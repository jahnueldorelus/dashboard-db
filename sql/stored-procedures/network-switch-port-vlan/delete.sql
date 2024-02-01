DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch_port_vlan`$$

CREATE PROCEDURE `delete_user_network_switch_port_vlan` (IN param_userId INT UNSIGNED, param_switchPortVlanId INT UNSIGNED)
BEGIN
	SET @switch_port_id = (SELECT switch_port_id FROM NetworkSwitchPortVlan WHERE id = param_switchPortVlanId);

	-- If the network switch port vlan doesn't exist
	IF (ISNULL(@switch_port_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a VLAN for a network switch port that doesn't exist";
	END IF;

	-- If the network switch port vlan doesn't belong to the user
	SET @switch_port_vlan_user_id = (SELECT user_id FROM NetworkSwitchPort
										LEFT JOIN NetworkSwitch
											ON NetworkSwitchPort.switch_id = NetworkSwitch.id
										WHERE NetworkSwitchPort.id = @switch_port_id);
	IF (@switch_port_vlan_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a VLAN on a network switch port you don't own";
	END IF;

	DELETE FROM NetworkSwitchPortVlan WHERE id = param_switchPortVlanId;
END$$
DELIMITER ;