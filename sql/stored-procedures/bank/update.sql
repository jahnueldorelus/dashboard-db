DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bank`$$

CREATE PROCEDURE `update_bank` (IN user_id INT UNSIGNED, bank_id INT UNSIGNED, 
								name VARCHAR(100), address_one VARCHAR(200), 
								address_two VARCHAR(200), city VARCHAR(85), 
								state VARCHAR(30), zipcode VARCHAR(10))
BEGIN
	UPDATE Bank SET name = name, address_one = address_one, address_two = address_two,
					city = city, state = state, zipcode = zipcode
				WHERE user_id = user_id AND id = bank_id;
END$$

DELIMITER ;