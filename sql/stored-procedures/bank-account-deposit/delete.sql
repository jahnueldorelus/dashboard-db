DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_bank_account_deposit`$$

CREATE PROCEDURE `delete_bank_account_deposit` (IN user_id INT UNSIGNED, bank_account_deposit_id INT UNSIGNED)
BEGIN
	DECLARE bankAccountId INT UNSIGNED;
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot delete a bank account deposit for an account the user doesn't own";
	SET bankAccountId = (SELECT bank_account_id FROM BankAccountDeposit WHERE id = bank_account_deposit_id);

	-- If the bank account deposit doesn't exist
	IF bankAccountId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = bankAccountId);
	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bankAccountBankId);

	-- If the bank doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	DELETE FROM BankAccountDeposit WHERE id = bank_account_deposit_id;
END$$

DELIMITER ;