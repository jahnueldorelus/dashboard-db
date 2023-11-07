DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_bank_account_transfer`$$

CREATE PROCEDURE `create_bank_account_transfer` (IN user_id INT UNSIGNED, from_bank_account_id INT UNSIGNED, 
												to_bank_account_id INT UNSIGNED, amount DECIMAL(10,2), 
												description VARCHAR(100), transfer_date DATE)
BEGIN
	DECLARE fromBankAccountBankId INT UNSIGNED;
	DECLARE toBankAccountBankId INT UNSIGNED;
	DECLARE fromBankUserId INT UNSIGNED;
	DECLARE toBankUserId INT UNSIGNED;
	DECLARE errorMessage VARCHAR(100);

	
	SET fromBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = from_bank_account_id);
	SET toBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = to_bank_account_id);

	-- If the bank accounts are not part of the same bank
	IF fromBankAccountBankId != toBankAccountBankId THEN
		SET errorMessage = "Cannot create a bank account transfer between accounts from different banks";
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	SET fromBankUserId = (SELECT bank_id FROM BankAccount WHERE id = from_bank_account_id);
	SET toBankUserId = (SELECT bank_id FROM BankAccount WHERE id = to_bank_account_id);

	SET errorMessage = "Cannot create a bank account transfer between accounts the user doesn't own";

	-- If the bank accounts do not belong to the same user
	IF fromBankUserId != toBankUserId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	-- If the bank accounts do not belong to the user given
	IF fromBankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
	END IF;

	INSERT INTO BankAccountTransfer (from_bank_account_id, to_bank_account_id, amount, description, dt) 
		VALUES (from_bank_account_id, to_bank_account_id, amount, description, transfer_date);
END$$

DELIMITER ;