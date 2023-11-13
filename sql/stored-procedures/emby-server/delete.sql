DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_emby_server`$$

CREATE PROCEDURE `delete_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED)
BEGIN
	DELETE FROM EmbyServer WHERE id = param_embyServerId AND user_id = param_userId;
END$$
DELIMITER ;