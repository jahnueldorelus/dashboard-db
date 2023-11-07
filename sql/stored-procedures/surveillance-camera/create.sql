DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_surveillance_camera`$$

CREATE PROCEDURE `create_surveillance_camera` (IN user_id INT UNSIGNED, name VARCHAR(255),
												link VARCHAR(255))
BEGIN
	INSERT INTO SurveillanceCamera (user_id, name, link) 
		VALUES (user_id, name, link) ;
END$$

DELIMITER ;