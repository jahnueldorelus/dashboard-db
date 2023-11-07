DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_external_app`$$

CREATE PROCEDURE `create_external_app` (IN user_id INT UNSIGNED, icon VARCHAR(255), 
										name VARCHAR(255), link VARCHAR(255))
BEGIN
	INSERT INTO ExternalApp (user_id, icon, name, link) 
		VALUES (user_id, icon, name, link) ;
END$$

DELIMITER ;