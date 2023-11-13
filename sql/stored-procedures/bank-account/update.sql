DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_bank_account`$$

CREATE PROCEDURE `update_user_bank_account` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED, 
										param_accountType VARCHAR(50), param_amount DECIMAL(10,2),
										param_active BOOLEAN)
BEGIN
	SET @bankId = (SELECT bank_id FROM BankAccount WHERE id = param_bankAccountId);
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = @bankId);
	SET @typeId = (SELECT id from BankAccountType where type = param_accountType);

	-- If the account type given doesn't exist
	IF ISNULL(@typeId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "The account type given doesn't exist";
	END IF;

	-- If the bank account doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a bank account the user doesn't have";
	END IF;

	UPDATE BankAccount SET type_id = @typeId, amount = param_amount, active = param_active
						WHERE id = param_bankAccountId;

	CALL get_bank_account(param_bankAccountId);
END$$
DELIMITER ;