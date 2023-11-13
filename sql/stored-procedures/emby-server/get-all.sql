DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_emby_servers`$$

CREATE PROCEDURE `get_user_emby_servers` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, host_name AS hostName, host, api_key AS apiKey 
		FROM EmbyServer
		WHERE user_id = param_userId
		ORDER BY host_name DESC;
END$$
DELIMITER ;