DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_card`$$

CREATE PROCEDURE `delete_user_network_card` (IN param_userId INT UNSIGNED, param_networkCardId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a machine network that the user doesn't have";
	SET @serverId = (SELECT server_id FROM NetworkCard WHERE id = param_networkCardId);

	-- If the server machine doesn't exist
	IF ISNULL(@serverId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @serverUserId = (SELECT user_id FROM ServerMachine WHERE id = @serverId);

	-- If the server machine doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM NetworkCard WHERE id = param_networkCardId;
END$$
DELIMITER ;