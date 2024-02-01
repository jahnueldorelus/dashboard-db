DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_switch_vlans`$$

CREATE PROCEDURE `get_user_network_switch_vlans` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED)
BEGIN
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = param_switchId);

	-- If the network switch doesn't exist
	IF (ISNULL(@switch_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot retrieve the VLANs of a network switch that doesn't exist";
	END IF;

	-- If the network switch doesn't belong to the user
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot retrieve the VLANs of a network switch you don't own";
	END IF;

	SELECT id, switch_id as switchId, name, vid
		FROM NetworkSwitchVlan
		WHERE switch_id = param_switchId
		ORDER BY vid DESC;
END$$
DELIMITER ;