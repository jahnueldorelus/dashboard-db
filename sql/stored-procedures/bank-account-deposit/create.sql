DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bank_account_deposit`$$

CREATE PROCEDURE `create_user_bank_account_deposit` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED, 
													param_amount DECIMAL(10,2), param_description VARCHAR(100),
													param_date DATE)
BEGIN
	SET @errorMessage = "Cannot create a bank account deposit for an account the user doesn't own";
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

	INSERT INTO BankAccountDeposit (bank_account_id, amount, description, dt) 
		VALUES (param_bankAccountId, param_amount, param_description, param_date);

	CALL get_bank_account_deposit(LAST_INSERT_ID());
END$$
DELIMITER ;