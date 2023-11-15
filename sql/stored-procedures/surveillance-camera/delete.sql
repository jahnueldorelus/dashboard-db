DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_surveillance_camera`$$

CREATE PROCEDURE `delete_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a surveillance camera the user doesn't have";
	SET @cameraUserId = (SELECT user_id FROM SurveillanceCamera WHERE id = param_surveillanceCameraId);

	-- If the surveillance camera doesn't exist
	IF ISNULL(@cameraUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the surveillance camera doesn't belong to the user
	IF @cameraUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM SurveillanceCamera WHERE id = param_surveillanceCameraId AND user_id = param_userId;
END$$
DELIMITER ;