DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_subscriptions`$$

CREATE PROCEDURE `get_user_subscriptions` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT Subscription.id, PaymentOccurence.type AS occurence, Subscription.occurs_every AS occurenceFrequency, 
		Subscription.company, Subscription.website, Subscription.amount, Subscription.due_date AS date
		FROM Subscription
			LEFT JOIN PaymentOccurence ON PaymentOccurence.id = Subscription.occurence_id
		WHERE Subscription.user_id = param_userId
		ORDER BY Subscription.company;
END$$
DELIMITER ;