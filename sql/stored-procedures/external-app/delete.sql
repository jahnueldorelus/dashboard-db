DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_external_app`$$

CREATE PROCEDURE `delete_external_app` (IN external_app_user_id INT UNSIGNED, external_app_id INT UNSIGNED)
BEGIN
	DELETE FROM ExternalApp WHERE id = external_app_id AND user_id = external_app_user_id;
END$$

DELIMITER ;