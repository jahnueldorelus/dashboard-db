DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_bank_account_withdrawals`$$

CREATE PROCEDURE `get_user_bank_account_withdrawals` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT BankAccountWithdrawal.id, BankAccount.id AS bankAccountId, description, 
			BankAccountWithdrawal.amount AS amount, dt AS date
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountWithdrawal ON BankAccountWithdrawal.bank_account_id = BankAccount.id
		WHERE Bank.user_id = param_userId AND BankAccount.id = param_bankAccountId
		ORDER BY date DESC;
END$$
DELIMITER ;