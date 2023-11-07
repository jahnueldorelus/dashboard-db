DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bill`$$

CREATE PROCEDURE `update_bill` (IN user_id INT UNSIGNED, bill_id INT UNSIGNED, 
								occurence_id INT UNSIGNED, occurs_every INT UNSIGNED,
								recurring BOOLEAN, company VARCHAR(155),
								amount DECIMAL(10,2), website VARCHAR(155), 
								due_date DATE)
BEGIN
	UPDATE BILL 
		SET occurence_id = occurence_id, occurs_every = occurs_every, recurring = recurring, company = company, amount = amount, 
			website = website, due_date = due_date
		WHERE user_id = user_id AND id = bill_id;
END$$

DELIMITER ;