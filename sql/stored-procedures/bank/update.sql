DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bank`$$

CREATE PROCEDURE `update_user_bank` (IN param_userId INT UNSIGNED, param_bankId INT UNSIGNED, 
								param_name VARCHAR(100), param_addressOne VARCHAR(200), 
								param_addressTwo VARCHAR(200), param_city VARCHAR(85), 
								param_state VARCHAR(30), param_zipcode VARCHAR(10))
BEGIN
	UPDATE Bank SET name = param_name, address_one = param_addressOne, address_two = param_addressTwo,
					city = param_city, state = param_state, zipcode = param_zipcode
				WHERE user_id = param_userId AND id = param_bankId;

	CALL get_bank(param_bankId);
END$$
DELIMITER ;