DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_switch_port_vlans`$$

CREATE PROCEDURE `get_user_network_switch_port_vlans` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED,
														param_switchPortId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot retrieve the vlans of a port for a network switch the user doesn't have";
	SET @switchIdFromVlan = (SELECT switch_id FROM NetworkSwitchVlan WHERE id = param_switchVlanId);
	SET @switchIdFromPort = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);
	SET @switchUserId = (SELECT user_id FROM NetworkSwitchVlan
							LEFT JOIN NetworkSwitch
								ON NetworkSwitchVlan.switch_id = NetworkSwitch.id
							WHERE NetworkSwitchVlan.id = param_switchVlanId);

	-- If the network switch vlan and network switch port doesn't belong to the same switch
	IF @switchIdFromVlan != @switchIdFromPort THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot retrieve the vlans of a port where the vlan & port are not from the same network switch";
	END IF;

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SELECT id, switch_vlan_id as switchVlanId, switch_port_id as switchPortId, mode
		FROM NetworkSwitchPortVlan
		WHERE switch_port_id = param_switchPortId
		ORDER BY switchVlanId DESC;
END$$
DELIMITER ;