DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_subscription`$$

CREATE PROCEDURE `delete_subscription` (IN subscription_user_id INT UNSIGNED, subscription_id INT UNSIGNED)
BEGIN
	DELETE FROM Subscription WHERE id = subscription_id AND user_id = subscription_user_id;
END$$

DELIMITER ;