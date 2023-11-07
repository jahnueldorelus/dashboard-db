DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_emby_server`$$

CREATE PROCEDURE `update_emby_server` (IN user_id INT UNSIGNED, emby_server_id INT UNSIGNED, 
										host VARCHAR(255), host_name VARCHAR(255),
										api_key VARCHAR(255))
BEGIN
	UPDATE EmbyServer SET host = host, host_name = host_name, api_key = api_key
						WHERE user_id = user_id AND id = emby_server_id;
END$$

DELIMITER ;