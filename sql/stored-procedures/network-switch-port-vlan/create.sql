DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch_port_vlan`$$

CREATE PROCEDURE `create_user_network_switch_port_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED, 
														param_switchPortId INT UNSIGNED, 
														param_mode ENUM("forbidden", "excluded", "untagged", "tagged", "none"))
BEGIN
	SET @switch_id_from_vlan = (SELECT switch_id FROM NetworkSwitchVlan WHERE id = param_switchVlanId);
	SET @switch_id_from_port = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id_from_vlan);

	-- If the network switch vlan or network switch port doesn't exist
	IF ((ISNULL(@switch_id_from_vlan)) OR (ISNULL(@switch_id_from_port))) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot add a VLAN to a network switch port when the VLAN or port doesn't exist";
	END IF;

	-- If the network switch vlan and network switch port doesn't belong to the same network switch
	IF (@switch_id_from_vlan != @switch_id_from_port) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot add a VLAN to a network switch port when the VLAN and port are not from the same network switch";
	END IF;

	-- If the network switch doesn't exist
	IF (ISNULL(@switch_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot add a VLAN to a network switch port on a network switch that doesn't exist";
	END IF;

	-- If the network switch doesn't belong to the user
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot add a VLAN to a network switch port on a network switch you don't own";
	END IF;

	INSERT INTO NetworkSwitchPortVlan (switch_vlan_id, switch_port_id, mode) 
		VALUES (param_switchVlanId, param_switchPortId, param_mode);

	CALL get_network_switch_port_vlan(LAST_INSERT_ID());
END$$
DELIMITER ;