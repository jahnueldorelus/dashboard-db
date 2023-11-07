DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_accounts`$$

CREATE PROCEDURE `get_user_bank_accounts` (IN user_id INT UNSIGNED)
BEGIN
	SELECT name, address_one, address_two, city, state, zipcode FROM Bank
		WHERE user_id = user_id;
END$$

DELIMITER ;