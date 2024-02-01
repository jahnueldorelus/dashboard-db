DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_emby_server`$$

CREATE PROCEDURE `update_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED, 
											param_host VARCHAR(255), param_hostName VARCHAR(255),
											param_apiKey VARCHAR(255), param_secure BOOLEAN)
BEGIN
	SET @server_user_id = (SELECT user_id FROM EmbyServer WHERE id = param_embyServerId);

	-- If the emby server doesn't exist
	IF (ISNULL(@server_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update an emby server that doesn't exist";
	END IF;

	-- If the emby server doesn't belong to the user
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update an emby server you don't own";
	END IF;


	UPDATE EmbyServer SET host = param_host, host_name = param_hostName, api_key = param_apiKey, secure = param_secure
						WHERE user_id = param_userId AND id = param_embyServerId;
	
	CALL get_emby_server(param_embyServerId);
END$$
DELIMITER ;