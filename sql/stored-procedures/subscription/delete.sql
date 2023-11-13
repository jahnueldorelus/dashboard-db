DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_subscription`$$

CREATE PROCEDURE `delete_user_subscription` (IN param_userId INT UNSIGNED, param_subscriptionId INT UNSIGNED)
BEGIN
	DELETE FROM Subscription WHERE id = param_subscriptionId AND user_id = param_userId;
END$$
DELIMITER ;