DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_external_app`$$

CREATE PROCEDURE `create_external_app` (IN user_id INT UNSIGNED, name VARCHAR(255), 
										link VARCHAR(255))
BEGIN
	INSERT INTO ExternalApp (user_id, name, link) 
		VALUES (user_id, name, link);
END$$

DELIMITER ;