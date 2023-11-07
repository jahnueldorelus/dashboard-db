DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bank_sub_account`$$

CREATE PROCEDURE `update_bank_sub_account` (IN user_id INT UNSIGNED, bank_sub_account_id INT UNSIGNED, 
											name VARCHAR(100), amount INT UNSIGNED)
BEGIN
	DECLARE bankAccountId INT UNSIGNED;
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot update a bank sub account the user doesn't have";
	SET bankAccountId = (SELECT bank_account_id FROM BankSubAccount WHERE id = bank_sub_account_id);

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

	UPDATE BankSubAccount SET name = name, amount = amount
							WHERE id = bank_sub_account_id;
END$$

DELIMITER ;