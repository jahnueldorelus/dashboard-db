DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch_vlan`$$

CREATE PROCEDURE `delete_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED)
BEGIN
	SET @switch_id = (SELECT switch_id FROM NetworkSwitchVlan WHERE id = param_switchVlanId);

	-- If the network switch vlan doesn't exist
	IF (ISNULL(@switch_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a VLAN that doesn't exist";
	END IF;

	-- If the network switch vlan doesn't belong to the user
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id);
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a VLAN you don't own";
	END IF;

	DELETE FROM NetworkSwitchVlan WHERE id = param_switchVlanId;
END$$
DELIMITER ;