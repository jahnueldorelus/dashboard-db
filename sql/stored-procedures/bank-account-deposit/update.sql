DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bank_account_deposit`$$

CREATE PROCEDURE `update_user_bank_account_deposit` (IN param_userId INT UNSIGNED, param_depositId INT UNSIGNED, 
												param_amount DECIMAL(10,2), param_description VARCHAR(100),
												param_date DATE)
BEGIN
	SET @errorMessage = "Cannot update a bank account deposit for an account the user doesn't have";
	SET @bankAccountId = (SELECT bank_account_id FROM BankAccountDeposit WHERE id = param_depositId);

	-- If the bank account deposit doesn't exist
	IF ISNULL(@bankAccountId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = @bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	UPDATE BankAccountDeposit SET amount = param_amount, description = param_description, dt = param_date
								WHERE id = param_depositId;

	CALL get_bank_account_deposit(param_depositId);
END$$
DELIMITER ;