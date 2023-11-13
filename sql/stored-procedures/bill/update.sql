DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bill`$$

CREATE PROCEDURE `update_user_bill` (IN param_userId INT UNSIGNED, param_billId INT UNSIGNED, 
									param_occurenceId INT UNSIGNED, param_occursEvery INT UNSIGNED,
									param_recurring BOOLEAN, param_company VARCHAR(155),
									param_amount DECIMAL(10,2), param_website VARCHAR(155), 
									param_dueDate DATE)
BEGIN
	UPDATE BILL 
		SET occurence_id = param_occurenceId, occurs_every = param_occursEvery, recurring = param_recurring, 
		company = param_company, amount = param_amount, website = param_website, due_date = param_dueDate
		WHERE user_id = param_userId AND id = param_billId;

	CALL get_bill(param_billId);
END$$
DELIMITER ;