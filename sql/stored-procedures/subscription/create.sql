DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_subscription`$$

CREATE PROCEDURE `create_user_subscription` (IN param_userId INT UNSIGNED, param_occurenceId INT UNSIGNED, 
										param_occursEvery INT UNSIGNED, param_company VARCHAR(155), 
										param_amount DECIMAL(10,2), param_website VARCHAR(155), 
										param_dueDate DATE)
BEGIN
	INSERT INTO Subscription (user_id, occurence_id, occurs_every, company, amount, website, due_date) 
		VALUES (param_userId, param_occurenceId, param_occursEvery, param_company, param_amount, 
				param_website, param_dueDate);

	CALL get_subscription(LAST_INSERT_ID());
END$$
DELIMITER ;