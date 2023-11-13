DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bank_account_transfer`$$

CREATE PROCEDURE `create_user_bank_account_transfer` (IN param_userId INT UNSIGNED, param_fromBankAccountId INT UNSIGNED, 
												param_toBankAccountId INT UNSIGNED, param_amount DECIMAL(10,2), 
												param_description VARCHAR(100), param_date DATE)
BEGIN
	SET @fromBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = param_fromBankAccountId);
	SET @toBankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = param_toBankAccountId);

	-- If the bank accounts are not part of the same bank
	IF @fromBankAccountBankId != @toBankAccountBankId THEN
		SET @errorMessage = "Cannot create a bank account transfer between accounts from different banks";
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @fromBankUserId = (SELECT bank_id FROM BankAccount WHERE id = param_fromBankAccountId);
	SET @toBankUserId = (SELECT bank_id FROM BankAccount WHERE id = param_toBankAccountId);

	SET @errorMessage = "Cannot create a bank account transfer between accounts the user doesn't own";

	-- If the bank accounts do not belong to the same user OR the user given
	IF @fromBankUserId != @toBankUserId OR @fromBankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	INSERT INTO BankAccountTransfer (from_bank_account_id, to_bank_account_id, amount, description, dt) 
		VALUES (param_fromBankAccountId, param_toBankAccountId, param_amount, param_description, param_date);

	CALL get_bank_account_transfer(LAST_INSERT_ID());
END$$
DELIMITER ;