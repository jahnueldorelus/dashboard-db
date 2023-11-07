DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_bank`$$

CREATE PROCEDURE `create_bank` (IN user_id INT UNSIGNED, name VARCHAR(100),
								address_one VARCHAR(200), address_two VARCHAR(200),
								city VARCHAR(85), state VARCHAR(30),
								zipcode VARCHAR(10))
BEGIN
	INSERT INTO Bank (user_id, name, address_one, address_two, city, state, zipcode) 
		VALUES (user_id, name, address_one, address_two, city, state, zipcode);
END$$

DELIMITER ;