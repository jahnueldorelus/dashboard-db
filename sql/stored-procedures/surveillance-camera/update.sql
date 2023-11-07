DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_surveillance_camera`$$

CREATE PROCEDURE `update_surveillance_camera` (IN user_id INT UNSIGNED, surveillance_camera_id INT UNSIGNED, 
												name VARCHAR(255), link VARCHAR(255))
BEGIN
	UPDATE SurveillanceCamera SET name = name, link = link
								WHERE user_id = user_id AND id = surveillance_camera_id;
END$$

DELIMITER ;