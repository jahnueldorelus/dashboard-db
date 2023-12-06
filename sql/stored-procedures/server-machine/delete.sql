DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_server_machine`$$

CREATE PROCEDURE `delete_user_server_machine` (IN param_userId INT UNSIGNED, param_serverMachineId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a server machine the user doesn't have";
	SET @serverUserId = (SELECT user_id FROM ServerMachine WHERE id = param_serverMachineId);

	-- If the server machine doesn't exist
	IF ISNULL(@serverUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the server machine doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM ServerMachine WHERE id = param_serverMachineId AND user_id = param_userId;
END$$
DELIMITER ;