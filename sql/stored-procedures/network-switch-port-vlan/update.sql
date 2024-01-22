DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_port_vlan`$$

CREATE PROCEDURE `update_user_network_switch_port_vlan` (IN param_userId INT UNSIGNED, param_switchPortVlanId INT UNSIGNED,
														param_mode ENUM("forbidden", "excluded", "untagged", "tagged", "none"))
BEGIN
	SET @errorMessage = "Cannot update a vlan for a port in a network switch the user doesn't have";
	SET @switchPortVlanUserId = (SELECT user_id FROM NetworkSwitchPortVlan 
									LEFT JOIN NetworkSwitchPort
										ON NetworkSwitchPortVlan.switch_port_id = NetworkSwitchPort.id
									LEFT JOIN NetworkSwitch
										ON NetworkSwitchPort.switch_id = NetworkSwitch.id
								WHERE NetworkSwitchPortVlan.id = param_switchPortVlanId);

	-- If the network switch port vlan doesn't exist
	IF ISNULL(@switchPortVlanUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch port vlan doesn't belong to the user
	IF @switchPortVlanUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;


	UPDATE NetworkSwitchPortVlan SET mode = param_mode
			WHERE id = param_switchPortVlanId;
	
	CALL get_network_switch_port_vlan(param_switchPortVlanId);
END$$
DELIMITER ;