DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bill`$$

CREATE PROCEDURE `get_bill` (IN param_billId INT UNSIGNED)
BEGIN
	SELECT Bill.id, PaymentOccurence.type AS occurence, Bill.occurs_every AS occurenceFrequency, 
		Bill.recurring, Bill.company, Bill.website, Bill.amount, Bill.due_date AS date
		FROM Bill
			LEFT JOIN PaymentOccurence ON PaymentOccurence.id = Bill.occurence_id
		WHERE Bill.id = param_billId;
END$$
DELIMITER ;