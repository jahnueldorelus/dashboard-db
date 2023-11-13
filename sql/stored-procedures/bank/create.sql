DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bank`$$

CREATE PROCEDURE `create_user_bank` (IN param_userId INT UNSIGNED, param_name VARCHAR(100),
									param_addressOne VARCHAR(200), param_addressTwo VARCHAR(200),
									param_city VARCHAR(85), param_state VARCHAR(30),
									param_zipcode VARCHAR(10))
BEGIN
	INSERT INTO Bank (user_id, name, address_one, address_two, city, state, zipcode) 
		VALUES (param_userId, param_name, param_addressOne, param_addressTwo, param_city, 
				param_state, param_zipcode);

	CALL get_bank(LAST_INSERT_ID());
END$$
DELIMITER ;