DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_subscription`$$

CREATE PROCEDURE `create_subscription` (IN user_id INT UNSIGNED, occurence_id INT UNSIGNED, 
										company VARCHAR(155), amount DECIMAL(10,2),
										website VARCHAR(155), due_date DATE)
BEGIN
	INSERT INTO Subscription (user_id, occurence_id, company, amount, website, due_date) 
		VALUES (user_id, occurence_id, company, amount, website, due_date);
END$$

DELIMITER ;