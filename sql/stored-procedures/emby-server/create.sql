DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_emby_server`$$

CREATE PROCEDURE `create_user_emby_server` (IN param_userId INT UNSIGNED, param_host VARCHAR(255), 
											param_hostName VARCHAR(255), param_apiKey VARCHAR(255),
											param_secure BOOLEAN)
BEGIN
	INSERT INTO EmbyServer (user_id, host, host_name, api_key, secure) 
		VALUES (param_userId, param_host, param_hostName, param_apiKey, param_secure);

	CALL get_emby_server(LAST_INSERT_ID());
END$$
DELIMITER ;