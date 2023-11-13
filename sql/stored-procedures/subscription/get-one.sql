DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_subscription`$$

CREATE PROCEDURE `get_subscription` (IN param_subscriptionId INT UNSIGNED)
BEGIN
	SELECT Subscription.id, PaymentOccurence.type AS occurence, Subscription.occurs_every AS occurenceFrequency, 
		Subscription.company, Subscription.website, Subscription.amount, Subscription.due_date AS date
		FROM Subscription
			LEFT JOIN PaymentOccurence ON PaymentOccurence.id = Subscription.occurence_id
		WHERE Subscription.id = param_subscriptionId;
END$$
DELIMITER ;