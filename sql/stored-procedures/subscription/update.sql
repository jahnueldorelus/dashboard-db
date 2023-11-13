DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_subscription`$$

CREATE PROCEDURE `update_user_subscription` (IN param_userId INT UNSIGNED, param_subscriptionId INT UNSIGNED,
											param_occurenceId INT UNSIGNED, param_occursEvery INT UNSIGNED,
											param_company VARCHAR(155), param_amount DECIMAL(10,2), 
											param_website VARCHAR(155), param_dueDate DATE)
BEGIN
	UPDATE Subscription SET occurence_id = param_occurenceId, occurs_every = param_occursEvery,
							company = param_company, amount = param_amount, website = param_website,
							due_date = param_dueDate
						WHERE user_id = param_userId AND id = param_subscriptionId;

	CALL get_subscription(param_subscriptionId);
END$$
DELIMITER ;