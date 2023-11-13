DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_surveillance_camera`$$

CREATE PROCEDURE `get_surveillance_camera` (IN param_surveillanceCameraId INT UNSIGNED)
BEGIN
	SELECT id, name, link
		FROM SurveillanceCamera
		WHERE id = param_surveillanceCameraId;
END$$
DELIMITER ;