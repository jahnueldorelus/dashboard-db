DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_surveillance_camera`$$

CREATE PROCEDURE `update_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED, 
												param_name VARCHAR(255), param_link VARCHAR(255))
BEGIN
	UPDATE SurveillanceCamera SET name = param_name, link = param_link
								WHERE user_id = param_userId AND id = param_surveillanceCameraId;

	CALL get_surveillance_camera(param_surveillanceCameraId);
END$$
DELIMITER ;