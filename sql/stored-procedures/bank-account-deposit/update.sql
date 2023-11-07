DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bank_account_deposit`$$

CREATE PROCEDURE `update_bank_account_deposit` (IN user_id INT UNSIGNED, bank_account_deposit_id INT UNSIGNED, 
												amount DECIMAL(10,2), description VARCHAR(100),
												deposit_date DATE)
BEGIN
	DECLARE bankAccountId INT UNSIGNED;
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot update a bank account deposit for an account the user doesn't have";
	SET bankAccountId = (SELECT bank_account_id FROM BankAccountDeposit WHERE id = bank_account_deposit_id);

	-- If the bank account doesn't exist
	IF bankAccountId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = bankAccountId);
	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bankAccountBankId);

	-- If the bank account doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	UPDATE BankAccountDeposit SET amount = amount, description = description, dt = deposit_date
								WHERE id = bank_account_deposit_id;
END$$

DELIMITER ;