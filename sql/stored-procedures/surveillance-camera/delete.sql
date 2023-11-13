DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_surveillance_camera`$$

CREATE PROCEDURE `delete_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED)
BEGIN
	DELETE FROM SurveillanceCamera WHERE id = param_surveillanceCameraId AND user_id = param_userId;
END$$
DELIMITER ;