DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_emby_server`$$

CREATE PROCEDURE `delete_emby_server` (IN emby_server_user_id INT UNSIGNED, emby_server_id INT UNSIGNED)
BEGIN
	DELETE FROM EmbyServer WHERE id = emby_server_id AND user_id = emby_server_user_id;
END$$

DELIMITER ;