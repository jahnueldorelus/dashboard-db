DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_switch_port_vlans`$$

CREATE PROCEDURE `get_user_network_switch_port_vlans` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED)
BEGIN
	SET @switch_id = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);

	-- If the network switch port doesn't exist
	IF (ISNULL(@switch_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot retrieve the VLANs of a network switch port that doesn't exist";
	END IF;

	-- If the network switch port doesn't belong to the user
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id);
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot retrieve the VLANs of a network switch port that you don't own";
	END IF;

	SELECT id, switch_vlan_id as switchVlanId, switch_port_id as switchPortId, mode
		FROM NetworkSwitchPortVlan
		WHERE switch_port_id = param_switchPortId
		ORDER BY switchVlanId DESC;
END$$
DELIMITER ;