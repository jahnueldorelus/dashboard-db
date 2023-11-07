DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_bank_account`$$

CREATE PROCEDURE `delete_bank_account` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED)
BEGIN
	DECLARE bankAccountBankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	SET errorMessage = "Cannot delete a bank account that the user doesn't own";
	SET bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = bank_account_id);

	-- If the bank account doesn't exist
	IF bankAccountBankId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bankAccountBankId);

	-- If the bank account doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	DELETE FROM BankAccount WHERE id = bank_account_id;
END$$

DELIMITER ;