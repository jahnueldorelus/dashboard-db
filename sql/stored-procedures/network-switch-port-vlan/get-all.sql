DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_switch_port_vlans`$$

CREATE PROCEDURE `get_user_network_switch_port_vlans` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot retrieve the vlans of a port for a network switch the user doesn't have";
	SET @switchIdFromPort = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);
	SET @switchUserId = (SELECT user_id FROM NetworkSwitchPort
							LEFT JOIN NetworkSwitch
								ON NetworkSwitchPort.switch_id = NetworkSwitch.id
							WHERE NetworkSwitchPort.id = param_switchPortId);

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