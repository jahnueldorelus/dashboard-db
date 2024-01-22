DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch_vlan`$$

CREATE PROCEDURE `create_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED, 
													param_name VARCHAR(255), param_vid SMALLINT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot create a vlan in a network switch the user doesn't have";
	SET @switchUserId = (SELECT user_id FROM NetworkSwitch
							WHERE NetworkSwitch.id = param_switchId);

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	INSERT INTO NetworkSwitchVlan (switch_id, name, vid) 
		VALUES (param_switchId, param_name, param_vid);

	CALL get_network_switch_vlan(LAST_INSERT_ID());
END$$
DELIMITER ;