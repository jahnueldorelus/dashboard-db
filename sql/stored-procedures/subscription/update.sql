DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_subscription`$$

CREATE PROCEDURE `update_subscription` (IN user_id INT UNSIGNED, subscription_id INT UNSIGNED,
										occurence_id INT UNSIGNED, occurs_every INT UNSIGNED,
										company VARCHAR(155), amount DECIMAL(10,2), 
										website VARCHAR(155), due_date DATE)
BEGIN
	UPDATE Subscription SET occurence_id = occurence_id, occurs_every = occurs_every,
							company = company, amount = amount, website = website, due_date = due_date
						WHERE user_id = user_id AND id = subscription_id;
END$$

DELIMITER ;