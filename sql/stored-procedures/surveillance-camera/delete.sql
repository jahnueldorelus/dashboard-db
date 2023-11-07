DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_surveillance_camera`$$

CREATE PROCEDURE `delete_surveillance_camera` (IN surveillance_camera_user_id INT UNSIGNED, surveillance_camera_id INT UNSIGNED)
BEGIN
	DELETE FROM SurveillanceCamera WHERE id = surveillance_camera_id AND user_id = surveillance_camera_user_id;
END$$

DELIMITER ;