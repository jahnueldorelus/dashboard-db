DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank_account_transfer`$$

CREATE PROCEDURE `delete_user_bank_account_transfer` (IN param_userId INT UNSIGNED, param_transferId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a bank account transfer between accounts the user doesn't have";
	SET @bankAccountId = (SELECT from_bank_account_id FROM BankAccountTransfer WHERE id = param_transferId);

	-- If the bank account transfer doesn't exist
	IF ISNULL(@bankAccountId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = @bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM BankAccountTransfer WHERE id = param_transferId;
END$$
DELIMITER ;