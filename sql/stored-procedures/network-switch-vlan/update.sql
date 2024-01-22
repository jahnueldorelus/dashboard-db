DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_vlan`$$

CREATE PROCEDURE `update_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED,
													param_name VARCHAR(255), param_vid SMALLINT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot update a vlan in a network switch the user doesn't have";
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


	UPDATE NetworkSwitchVlan SET name = param_name, vid = param_vid
				WHERE id = param_switchVlanId;
	
	CALL get_network_switch_vlan(param_switchVlanId);
END$$
DELIMITER ;