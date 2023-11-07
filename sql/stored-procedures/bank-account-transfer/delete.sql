DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_bank_account_transfer`$$

CREATE PROCEDURE `delete_bank_account_transfer` (IN user_id INT UNSIGNED, bank_account_transfer_id INT UNSIGNED)
BEGIN
	DECLARE bankAccountId INT UNSIGNED;
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot delete a bank account transfer between accounts the user doesn't own";
	SET bankAccountId = (SELECT from_bank_account_id FROM BankAccountTransfer WHERE id = bank_account_transfer_id);

	-- If the bank account transfer doesn't exist
	IF bankAccountId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = bankAccountId);
	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bankAccountId);

	-- If the bank doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	DELETE FROM BankAccountTransfer WHERE id = bank_account_transfer_id;
END$$

DELIMITER ;