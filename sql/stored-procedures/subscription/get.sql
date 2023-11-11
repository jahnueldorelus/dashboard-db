DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_subscriptions`$$

CREATE PROCEDURE `get_user_subscriptions` (IN user_id INT UNSIGNED)
BEGIN
	SELECT Subscription.id, PaymentOccurence.type AS occurence, Subscription.occurs_every AS occurenceFrequency, 
		Subscription.company, Subscription.website, Subscription.amount, Subscription.due_date AS date
		FROM Subscription
			LEFT JOIN PaymentOccurence ON PaymentOccurence.id = Subscription.occurence_id
		WHERE Subscription.user_id = user_id
		ORDER BY Subscription.company;
END$$
DELIMITER ;