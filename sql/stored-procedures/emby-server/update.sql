DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_emby_server`$$

CREATE PROCEDURE `update_user_emby_server` (IN param_userId INT UNSIGNED, param_embyServerId INT UNSIGNED, 
											param_host VARCHAR(255), param_hostName VARCHAR(255),
											param_apiKey VARCHAR(255))
BEGIN
	SET @errorMessage = "Cannot update an emby server the user doesn't have";
	SET @serverUserId = (SELECT user_id FROM EmbyServer WHERE id = param_embyServerId);

	-- If the emby server doesn't exist
	IF ISNULL(@serverUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the emby server doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;


	UPDATE EmbyServer SET host = param_host, host_name = param_hostName, api_key = param_apiKey
						WHERE user_id = param_userId AND id = param_embyServerId;
	
	CALL get_emby_server(param_embyServerId);
END$$
DELIMITER ;