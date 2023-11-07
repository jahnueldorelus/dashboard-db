DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_bill`$$

CREATE PROCEDURE `create_bill` (IN user_id INT UNSIGNED, occurence_id INT UNSIGNED, 
								occurs_every INT UNSIGNED, recurring BOOLEAN, 
								company VARCHAR(155), amount DECIMAL(10,2), 
								website VARCHAR(155), due_date DATE)
BEGIN
	INSERT INTO Bill (user_id, occurence_id, occurs_every, recurring, company, amount, website, due_date) 
		VALUES (user_id, occurence_id, occurs_every, recurring, company, amount, website, due_date);
END$$

DELIMITER ;