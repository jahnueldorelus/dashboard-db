DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_port_vlan`$$

CREATE PROCEDURE `update_user_network_switch_port_vlan` (IN param_userId INT UNSIGNED, param_switchPortVlanId INT UNSIGNED,
														param_mode ENUM("forbidden", "excluded", "untagged", "tagged", "none"))
BEGIN
	SET @switch_port_id = (SELECT switch_port_id FROM NetworkSwitchPortVlan WHERE id = param_switchPortVlanId);
	SET @switch_port_user_id = (SELECT user_id FROM NetworkSwitchPort
									LEFT JOIN NetworkSwitch
										ON NetworkSwitchPort.switch_id = NetworkSwitch.id
									WHERE NetworkSwitchPort.id = @switch_port_id);

	-- If the network switch port vlan doesn't exist
	IF (ISNULL(@switch_port_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a VLAN that doesn't exist on a network switch port";
	END IF;

	-- If the network switch port vlan doesn't belong to the user
	IF (@switch_port_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a VLAN on a network switch port that you don't own";
	END IF;


	UPDATE NetworkSwitchPortVlan SET mode = param_mode
			WHERE id = param_switchPortVlanId;
	
	CALL get_network_switch_port_vlan(param_switchPortVlanId);
END$$
DELIMITER ;