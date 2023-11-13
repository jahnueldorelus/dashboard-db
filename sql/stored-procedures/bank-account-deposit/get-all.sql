DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_bank_account_deposits`$$

CREATE PROCEDURE `get_user_bank_account_deposits` (IN param_userId INT UNSIGNED, param_accountId INT UNSIGNED)
BEGIN
	SELECT BankAccountDeposit.id, BankAccount.id AS bankAccountId, description, 
			BankAccountDeposit.amount AS amount, dt AS date
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountDeposit ON BankAccountDeposit.bank_account_id = BankAccount.id
		WHERE Bank.user_id = param_userId AND BankAccount.id = param_accountId
		ORDER BY date DESC;
END$$
DELIMITER ;