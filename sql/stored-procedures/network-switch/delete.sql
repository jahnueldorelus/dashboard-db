DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch`$$

CREATE PROCEDURE `delete_user_network_switch` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a network switch the user doesn't have";
	SET @switchUserId = (SELECT user_id FROM NetworkSwitch WHERE id = param_switchId);

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM NetworkSwitch WHERE id = param_switchId AND user_id = param_userId;
END$$
DELIMITER ;