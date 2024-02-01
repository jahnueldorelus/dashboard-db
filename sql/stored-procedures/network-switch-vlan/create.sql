DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_switch_vlan`$$

CREATE PROCEDURE `create_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED, 
													param_name VARCHAR(255), param_vid SMALLINT UNSIGNED)
BEGIN
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE NetworkSwitch.id = param_switchId);

	-- If the network switch doesn't exist
	IF (ISNULL(@switch_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a VLAN on a network switch that doesn't exist";
	END IF;

	-- If the network switch doesn't belong to the user
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a VLAN on a network switch you don't own";
	END IF;

	INSERT INTO NetworkSwitchVlan (switch_id, name, vid) 
		VALUES (param_switchId, param_name, param_vid);

	CALL get_network_switch_vlan(LAST_INSERT_ID());
END$$
DELIMITER ;