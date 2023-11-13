DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_emby_server`$$

CREATE PROCEDURE `update_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED, 
											param_host VARCHAR(255), param_hostName VARCHAR(255),
											param_apiKey VARCHAR(255))
BEGIN
	UPDATE EmbyServer SET host = param_host, host_name = param_hostName, api_key = param_apiKey
						WHERE user_id = param_userId AND id = param_embyServerId;
	
	CALL get_emby_server(param_embyServerId);
END$$
DELIMITER ;