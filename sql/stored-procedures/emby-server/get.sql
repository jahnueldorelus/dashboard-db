DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_emby_servers`$$

CREATE PROCEDURE `get_user_emby_servers` (IN user_id INT UNSIGNED)
BEGIN
	SELECT id, host_name AS hostName, host, api_key AS apiKey 
		FROM EmbyServer
		WHERE user_id = user_id
		ORDER BY host_name DESC;
END$$
DELIMITER ;