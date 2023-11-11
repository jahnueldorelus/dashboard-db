DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_external_app`$$

CREATE PROCEDURE `update_external_app` (IN user_id INT UNSIGNED, external_app_id INT UNSIGNED,
										name VARCHAR(255), link VARCHAR(255))
BEGIN
	UPDATE ExternalApp SET name = name, link = link
						WHERE user_id = user_id AND id = external_app_id;
END$$

DELIMITER ;