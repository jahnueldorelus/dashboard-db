DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_emby_server`$$

CREATE PROCEDURE `delete_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete an emby server the user doesn't have";
	SET @serverUserId = (SELECT user_id FROM EmbyServer WHERE id = param_embyServerId);

	-- If the emby server doesn't exist
	IF ISNULL(@serverUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the emby server doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM EmbyServer WHERE id = param_embyServerId AND user_id = param_userId;
END$$
DELIMITER ;