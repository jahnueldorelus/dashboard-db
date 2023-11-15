DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_external_app`$$

CREATE PROCEDURE `delete_user_external_app` (IN param_userId INT UNSIGNED, param_externalAppId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete an external app the user doesn't have";
	SET @appUserId = (SELECT user_id FROM ExternalApp WHERE id = param_externalAppId);

	-- If the external app doesn't exist
	IF ISNULL(@appUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the external app doesn't belong to the user
	IF @appUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM ExternalApp WHERE id = param_externalAppId AND user_id = param_userId;
END$$
DELIMITER ;