DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_bills`$$

CREATE PROCEDURE `get_user_bills` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT Bill.id, PaymentOccurence.type AS occurence, Bill.occurs_every AS occurenceFrequency, 
		Bill.recurring, Bill.company, Bill.website, Bill.amount, Bill.due_date AS date
		FROM Bill
			LEFT JOIN PaymentOccurence ON PaymentOccurence.id = Bill.occurence_id
		WHERE Bill.user_id = param_userId
		ORDER BY Bill.company DESC;
END$$
DELIMITER ;