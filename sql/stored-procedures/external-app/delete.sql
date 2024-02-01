DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_external_app`$$

CREATE PROCEDURE `delete_user_external_app` (IN param_userId INT UNSIGNED, param_externalAppId INT UNSIGNED)
BEGIN
	SET @app_user_id = (SELECT user_id FROM ExternalApp WHERE id = param_externalAppId);

	-- If the external app doesn't exist
	IF (ISNULL(@app_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete an external app that doesn't exist";
	END IF;

	-- If the external app doesn't belong to the user
	IF (@app_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete an external app you don't own";
	END IF;

	DELETE FROM ExternalApp WHERE id = param_externalAppId AND user_id = param_userId;
END$$
DELIMITER ;