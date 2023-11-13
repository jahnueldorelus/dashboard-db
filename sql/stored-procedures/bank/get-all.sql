DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_banks`$$

CREATE PROCEDURE `get_user_banks` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, address_one AS addressOne, address_two AS addressTwo, city, state, zipcode FROM Bank
		WHERE user_id = param_userId;
END$$
DELIMITER ;