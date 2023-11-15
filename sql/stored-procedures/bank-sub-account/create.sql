DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bank_sub_account`$$

CREATE PROCEDURE `create_user_bank_sub_account` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED, 
											param_name VARCHAR(100), param_amount DECIMAL(10,2))
BEGIN
	SET @errorMessage = "Cannot create a bank sub account for an account the user doesn't have";
	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = param_bankAccountId);

	-- If the bank account doesn't exist
	IF ISNULL(@bankId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	INSERT INTO BankSubAccount (bank_account_id, name, amount) 
		VALUES (param_bankAccountId, param_name, param_amount);

	CALL get_bank_account_sub_account(LAST_INSERT_ID());
END$$
DELIMITER ;