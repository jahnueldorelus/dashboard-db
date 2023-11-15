DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bill`$$

CREATE PROCEDURE `delete_user_bill` (IN param_userId INT UNSIGNED, param_billId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a bill the user doesn't have";
	SET @billUserId = (SELECT user_id FROM Bill WHERE id = param_billId);

	-- If the bill doesn't exist
	IF ISNULL(@billUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the bill doesn't belong to the user
	IF @billUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM Bill WHERE id = param_billId AND user_id = param_userId;
END$$
DELIMITER ;