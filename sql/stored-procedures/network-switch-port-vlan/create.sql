DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch_port_vlan`$$

CREATE PROCEDURE `create_user_network_switch_port_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED, 
														param_switchPortId INT UNSIGNED, 
														param_mode ENUM("forbidden", "excluded", "untagged", "tagged", "none"))
BEGIN
	SET @errorMessage = "Cannot add a vlan to a port in a network switch the user doesn't have";
	SET @switchIdFromVlan = (SELECT switch_id FROM NetworkSwitchVlan WHERE id = param_switchVlanId);
	SET @switchIdFromPort = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);
	SET @switchUserId = (SELECT user_id FROM NetworkSwitchVlan
							LEFT JOIN NetworkSwitch
								ON NetworkSwitchVlan.switch_id = NetworkSwitch.id
							WHERE NetworkSwitchVlan.id = param_switchVlanId);

	-- If the network switch vlan and network switch port doesn't belong to the same switch
	IF @switchIdFromVlan != @switchIdFromPort THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot add a vlan to a port where the vlan & port are not from the same network switch";
	END IF;

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	INSERT INTO NetworkSwitchPortVlan (switch_vlan_id, switch_port_id, mode) 
		VALUES (param_switchVlanId, param_switchPortId, param_mode);

	CALL get_network_switch_port_vlan(LAST_INSERT_ID());
END$$
DELIMITER ;