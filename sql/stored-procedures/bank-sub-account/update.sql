DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bank_sub_account`$$

CREATE PROCEDURE `update_user_bank_sub_account` (IN param_userId INT UNSIGNED, param_subAccountId INT UNSIGNED, 
											param_name VARCHAR(100), param_amount DECIMAL(10,2))
BEGIN
	SET @errorMessage = "Cannot update a bank sub account the user doesn't have";
	SET @bankAccountId = (SELECT bank_account_id FROM BankSubAccount WHERE id = param_subAccountId);

	-- If the bank account doesn't exist
	IF ISNULL(@bankAccountId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankAccountBankId = (SELECT bank_id FROM BankAccount WHERE id = @bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankAccountBankId);

	-- If the bank account doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	UPDATE BankSubAccount SET name = param_name, amount = param_amount
							WHERE id = param_subAccountId;

	CALL get_bank_account_sub_account(param_subAccountId);
END$$
DELIMITER ;