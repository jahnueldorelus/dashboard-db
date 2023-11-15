DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_surveillance_camera`$$

CREATE PROCEDURE `update_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED, 
												param_name VARCHAR(255), param_link VARCHAR(255))
BEGIN
	SET @errorMessage = "Cannot update a surveillance camera the user doesn't have";
	SET @cameraUserId = (SELECT user_id FROM SurveillanceCamera WHERE id = param_surveillanceCameraId);

	-- If the surveillance camera doesn't exist
	IF ISNULL(@cameraUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the surveillance camera doesn't belong to the user
	IF @cameraUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	UPDATE SurveillanceCamera SET name = param_name, link = param_link
								WHERE user_id = param_userId AND id = param_surveillanceCameraId;

	CALL get_surveillance_camera(param_surveillanceCameraId);
END$$
DELIMITER ;