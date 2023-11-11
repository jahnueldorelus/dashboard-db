DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_surveillance_cameras`$$

CREATE PROCEDURE `get_user_surveillance_cameras` (IN user_id INT UNSIGNED)
BEGIN
	SELECT id, name, link
		FROM SurveillanceCamera
		WHERE user_id = user_id
		ORDER BY name;
END$$
DELIMITER ;