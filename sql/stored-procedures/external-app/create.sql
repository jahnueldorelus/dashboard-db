DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_external_app`$$

CREATE PROCEDURE `create_user_external_app` (IN param_userId INT UNSIGNED, param_name VARCHAR(255), 
										param_link VARCHAR(255))
BEGIN
	INSERT INTO ExternalApp (user_id, name, link) 
		VALUES (param_userId, param_name, param_link);

	CALL get_external_app(LAST_INSERT_ID());
END$$
DELIMITER ;