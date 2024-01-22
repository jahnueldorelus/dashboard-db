DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch_vlan`$$

CREATE PROCEDURE `delete_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a vlan in a network switch the user doesn't have";
	SET @switchVlanUserId = (SELECT user_id FROM NetworkSwitchVlan 
								LEFT JOIN NetworkSwitch  
									ON NetworkSwitchVlan.switch_id = NetworkSwitch.id
								WHERE NetworkSwitchVlan.id = param_switchVlanId);

	-- If the network switch vlan doesn't exist
	IF ISNULL(@switchVlanUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch vlan doesn't belong to the user
	IF @switchVlanUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM NetworkSwitchVlan WHERE id = param_switchVlanId;
END$$
DELIMITER ;