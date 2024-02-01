DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_server_machine`$$

CREATE PROCEDURE `delete_user_server_machine` (IN param_userId INT UNSIGNED, param_serverMachineId INT UNSIGNED)
BEGIN
	SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = param_serverMachineId);

	-- If the server machine doesn't exist
	IF (ISNULL(@server_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a server machine that doesn't exist";
	END IF;

	-- If the server machine doesn't belong to the user
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a server machine you don't own";
	END IF;

	DELETE FROM ServerMachine WHERE id = param_serverMachineId AND user_id = param_userId;
END$$
DELIMITER ;