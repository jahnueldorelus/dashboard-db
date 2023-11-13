DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_emby_server`$$

CREATE PROCEDURE `get_emby_server` (IN param_embyServerId INT UNSIGNED)
BEGIN
	SELECT id, host_name AS hostName, host, api_key AS apiKey 
		FROM EmbyServer
		WHERE id = param_embyServerId;
END$$
DELIMITER ;