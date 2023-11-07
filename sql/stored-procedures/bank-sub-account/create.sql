DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_bank_sub_account`$$

CREATE PROCEDURE `create_bank_sub_account` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED, 
											name VARCHAR(100), amount INT UNSIGNED)
BEGIN
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot create a bank sub account for an account the user doesn't own";
	SET bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = bank_account_id);

	-- If the bank account doesn't exist
	IF bankAccountBankId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bankAccountBankId);

	-- If the bank doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	INSERT INTO BankSubAccount (bank_account_id, name, amount) 
		VALUES (bank_account_id, name, amount);
END$$

DELIMITER ;