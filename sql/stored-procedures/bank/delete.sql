DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank`$$

CREATE PROCEDURE `delete_user_bank` (IN param_userId INT UNSIGNED, param_bankId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a bank that the user doesn't have";
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = param_bankId);

	-- If the bank doesn't exist
	IF ISNULL(@bankUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM Bank WHERE id = param_bankId AND user_id = param_userId;
END$$
DELIMITER ;