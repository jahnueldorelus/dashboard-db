DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_emby_server`$$

CREATE PROCEDURE `create_emby_server` (IN user_id INT UNSIGNED, host VARCHAR(255), 
										host_name VARCHAR(255), api_key VARCHAR(255))
BEGIN
	INSERT INTO EmbyServer (user_id, host, host_name, api_key) 
		VALUES (user_id, host, host_name, api_key);
END$$

DELIMITER ;