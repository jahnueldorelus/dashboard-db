DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_emby_server`$$

CREATE PROCEDURE `delete_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED)
BEGIN
	SET @server_user_id = (SELECT user_id FROM EmbyServer WHERE id = param_embyServerId);

	-- If the emby server doesn't exist
	IF (ISNULL(@server_user_id)) THEN
		SET @error_message = "Cannot delete an emby server that doesn't exist";
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	END IF;

	-- If the emby server doesn't belong to the user
	IF (@server_user_id != param_userId) THEN
		SET @error_message = "Cannot delete an emby server you don't own";
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	END IF;

	DELETE FROM EmbyServer WHERE id = param_embyServerId AND user_id = param_userId;
END$$
DELIMITER ;