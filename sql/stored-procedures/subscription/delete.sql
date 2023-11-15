DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_subscription`$$

CREATE PROCEDURE `delete_user_subscription` (IN param_userId INT UNSIGNED, param_subscriptionId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a subscription the user doesn't have";
	SET @subscriptionUserId = (SELECT user_id FROM Subscription WHERE id = param_subscriptionId);

	-- If the subscription doesn't exist
	IF ISNULL(@subscriptionUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the subscription doesn't belong to the user
	IF @subscriptionUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM Subscription WHERE id = param_subscriptionId AND user_id = param_userId;
END$$
DELIMITER ;