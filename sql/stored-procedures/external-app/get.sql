DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_external_apps`$$

CREATE PROCEDURE `get_user_external_apps` (IN user_id INT UNSIGNED)
BEGIN
	SELECT id, name, link
		FROM ExternalApp
		WHERE user_id = user_id
		ORDER BY name;
END$$
DELIMITER ;