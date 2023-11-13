DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_surveillance_cameras`$$

CREATE PROCEDURE `get_user_surveillance_cameras` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, link
		FROM SurveillanceCamera
		WHERE user_id = param_userId
		ORDER BY name;
END$$
DELIMITER ;