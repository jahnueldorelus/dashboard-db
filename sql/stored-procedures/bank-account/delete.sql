DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank_account`$$

CREATE PROCEDURE `delete_user_bank_account` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a bank account that the user doesn't have";
	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = param_bankAccountId);

	-- If the bank account doesn't exist
	IF ISNULL(@bankId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank account doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @numOfTransfers = (
		SELECT COUNT(id) FROM BankAccountTransfer
			WHERE BankAccountTransfer.from_bank_account_id = param_bankAccountId OR 
					BankAccountTransfer.to_bank_account_id = param_bankAccountId
	);

	-- If the bank account has transfers between other accounts (cannot be deleted but will be inactive)
	IF @numOfTransfers > 0 THEN
		UPDATE BankAccount SET active = FALSE WHERE id = param_bankAccountId;
	ELSE
		DELETE FROM BankAccount WHERE id = param_bankAccountId;
	END IF;

END$$
DELIMITER ;