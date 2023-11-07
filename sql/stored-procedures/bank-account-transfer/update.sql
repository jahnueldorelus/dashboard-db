DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bank_account_transfer`$$

CREATE PROCEDURE `update_bank_account_transfer` (IN user_id INT UNSIGNED, bank_account_transfer_id INT UNSIGNED,
												amount DECIMAL(10,2), description VARCHAR(100),
												transfer_date DATE)
BEGIN
	DECLARE fromBankAccountId INT UNSIGNED;
	DECLARE toBankAccountId INT UNSIGNED;
	DECLARE fromBankAccountBankId INT UNSIGNED;
	DECLARE toBankAccountBankId INT UNSIGNED;
	DECLARE fromBankUserId INT UNSIGNED;
	DECLARE toBankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	
	SET errorMessage = "Cannot update a bank account transfer between accounts the user doesn't have";
	SELECT from_bank_account_id, to_bank_account_id INTO fromBankAccountId, toBankAccountId 
		FROM BankAccountTransfer WHERE id = bank_account_transfer_id;

	-- If any of the bank accounts don't exist
	IF fromBankAccountId = NULL OR toBankAccountId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;
	
	SET fromBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = fromBankAccountId);
	SET toBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = toBankAccountId);

	SET fromBankUserId = (SELECT user_id FROM Bank WHERE id = fromBankAccountBankId);
	SET toBankUserId = (SELECT user_id FROM Bank WHERE id = toBankAccountBankId);

	-- If the bank accounts do not belong to the same user
	IF fromBankUserId != toBankUserId OR fromBankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	UPDATE BankAccountTransfer SET amount = amount, description = description, dt = transfer_date
								WHERE id = bank_account_transfer_id;
END$$

DELIMITER ;