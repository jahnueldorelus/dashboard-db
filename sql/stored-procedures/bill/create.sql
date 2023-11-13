DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bill`$$

CREATE PROCEDURE `create_user_bill` (IN param_userId INT UNSIGNED, param_occurenceId INT UNSIGNED, 
									param_occursEvery INT UNSIGNED, param_recurring BOOLEAN, 
									param_company VARCHAR(155), param_amount DECIMAL(10,2), 
									param_website VARCHAR(155), param_dueDate DATE)
BEGIN
	INSERT INTO Bill (user_id, occurence_id, occurs_every, recurring, company, amount, website, due_date) 
		VALUES (param_userId, param_occurenceId, param_occursEvery, param_recurring, param_company, 
				param_amount, param_website, param_dueDate);

	CALL get_bill(LAST_INSERT_ID());
END$$
DELIMITER ;