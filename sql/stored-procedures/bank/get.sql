DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_banks`$$

CREATE PROCEDURE `get_user_banks` (IN user_id INT UNSIGNED)
BEGIN
	SELECT id, name, address_one AS addressOne, address_two AS addressTwo, city, state, zipcode FROM Bank
		WHERE user_id = user_id;
END$$

DELIMITER ;