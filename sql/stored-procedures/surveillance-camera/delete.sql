DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_surveillance_camera`$$

CREATE PROCEDURE `delete_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_surveillanceCameraId INT UNSIGNED)
BEGIN
	SET @camera_user_id = (SELECT user_id FROM SurveillanceCamera WHERE id = param_surveillanceCameraId);

	-- If the surveillance camera doesn't exist
	IF (ISNULL(@camera_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a surveillance camera that doesn't exist";
	END IF;

	-- If the surveillance camera doesn't belong to the user
	IF (@camera_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a surveillance camera you don't own";
	END IF;

	DELETE FROM SurveillanceCamera WHERE id = param_surveillanceCameraId AND user_id = param_userId;
END$$
DELIMITER ;