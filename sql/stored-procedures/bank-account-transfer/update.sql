DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bank_account_transfer`$$

CREATE PROCEDURE `update_user_bank_account_transfer` (IN param_userId INT UNSIGNED, param_transferId INT UNSIGNED,
												param_amount DECIMAL(10,2), param_description VARCHAR(100),
												param_date DATE)
BEGIN
	SET @errorMessage = "Cannot update a bank account transfer between accounts the user doesn't have";
	SELECT from_bank_account_id, to_bank_account_id INTO @fromBankAccountId, @toBankAccountId 
		FROM BankAccountTransfer WHERE id = param_transferId;

	-- If any of the bank accounts don't exist
	IF @fromBankAccountId = NULL OR @toBankAccountId = NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;
	
	SET @fromBankId = (SELECT bank_id FROM BankAccount WHERE id = @fromBankAccountId);
	SET @toBankId = (SELECT bank_id FROM BankAccount WHERE id = @toBankAccountId);

	SET @fromBankUserId = (SELECT user_id FROM Bank WHERE id = @fromBankId);
	SET @toBankUserId = (SELECT user_id FROM Bank WHERE id = @toBankId);

	-- If the bank accounts do not belong to the same user OR the user given
	IF @fromBankUserId != @toBankUserId OR @fromBankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	UPDATE BankAccountTransfer SET amount = param_amount, description = param_description, dt = param_date
								WHERE id = param_transferId;

	CALL get_bank_account_transfer(param_transferId);
END$$
DELIMITER ;