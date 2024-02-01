DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch`$$

CREATE PROCEDURE `delete_user_network_switch` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED)
BEGIN
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = param_switchId);

	-- If the network switch doesn't exist
	IF (ISNULL(@switch_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a network switch that doesn't exist";
	END IF;

	-- If the network switch doesn't belong to the user
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a network switch you don't own";
	END IF;

	DELETE FROM NetworkSwitch WHERE id = param_switchId AND user_id = param_userId;
END$$
DELIMITER ;