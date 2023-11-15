DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank_account_deposit`$$

CREATE PROCEDURE `delete_user_bank_account_deposit` (IN param_userId INT UNSIGNED, param_depositId INT UNSIGNED)
BEGIN
	DECLARE bankUserId INT UNSIGNED;

	SET @errorMessage = "Cannot delete a bank account deposit for an account the user doesn't own";
	SET @bankAccountId = (SELECT bank_account_id FROM BankAccountDeposit WHERE id = param_depositId);

	-- If the bank account deposit doesn't exist
	IF ISNULL(@bankAccountId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = @bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM BankAccountDeposit WHERE id = param_depositId;
END$$
DELIMITER ;