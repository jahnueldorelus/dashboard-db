DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_external_app`$$

CREATE PROCEDURE `delete_user_external_app` (IN param_userId INT UNSIGNED, param_externalAppId INT UNSIGNED)
BEGIN
	DELETE FROM ExternalApp WHERE id = param_externalAppId AND user_id = param_userId;
END$$
DELIMITER ;