DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_surveillance_camera`$$

CREATE PROCEDURE `update_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED, 
													param_name VARCHAR(255), param_link VARCHAR(255))
BEGIN
	SET @camera_user_id = (SELECT user_id FROM SurveillanceCamera WHERE id = param_surveillanceCameraId);

	-- If the surveillance camera doesn't exist
	IF (ISNULL(@camera_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a surveillance camera that doesn't exist";
	END IF;

	-- If the surveillance camera doesn't belong to the user
	IF (@camera_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a surveillance camera you don't own";
	END IF;

	UPDATE SurveillanceCamera SET name = param_name, link = param_link
								WHERE id = param_surveillanceCameraId;

	CALL get_surveillance_camera(param_surveillanceCameraId);
END$$
DELIMITER ;