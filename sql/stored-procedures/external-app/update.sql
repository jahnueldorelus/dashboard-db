DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_external_app`$$

CREATE PROCEDURE `update_user_external_app` (IN param_userId INT UNSIGNED, param_externalAppId INT UNSIGNED,
										param_name VARCHAR(255), param_link VARCHAR(255))
BEGIN
	UPDATE ExternalApp SET name = param_name, link = param_link
						WHERE user_id = param_userId AND id = param_externalAppId;
	
	CALL get_external_app(param_externalAppId);
END$$

DELIMITER ;