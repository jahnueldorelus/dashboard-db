DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank_sub_account`$$

CREATE PROCEDURE `delete_user_bank_sub_account` (IN param_userId INT UNSIGNED, param_subAccountId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a bank sub account the user doesn't own";
	SET @bankAccountId = (SELECT bank_account_id FROM BankSubAccount WHERE id = param_subAccountId);

	-- If the bank sub account doesn't exist
	IF ISNULL(@bankAccountId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = @bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM BankSubAccount WHERE id = param_subAccountId;
END$$
DELIMITER ;