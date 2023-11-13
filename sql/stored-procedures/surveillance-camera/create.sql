DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_surveillance_camera`$$

CREATE PROCEDURE `create_user_surveillance_camera` (IN param_userId INT UNSIGNED, param_name VARCHAR(255),
												param_link VARCHAR(255))
BEGIN
	INSERT INTO SurveillanceCamera (user_id, name, link) 
		VALUES (param_userId, param_name, param_link);

	CALL get_surveillance_camera(LAST_INSERT_ID());
END$$
DELIMITER ;