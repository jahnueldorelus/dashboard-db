DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_bank_account_transfers`$$

CREATE PROCEDURE `get_user_bank_account_transfers` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT DISTINCT BankAccountTransfer.id, BankAccountTransfer.from_bank_account_id AS fromBankAccountId, 
			BankAccountTransfer.to_bank_account_id AS toBankAccountId, 
			description, BankAccountTransfer.amount, dt AS date
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountTransfer ON 
				(BankAccountTransfer.from_bank_account_id = BankAccount.id OR BankAccountTransfer.to_bank_account_id = BankAccount.id)
		WHERE Bank.user_id = param_userId 
			AND (BankAccountTransfer.from_bank_account_id = param_bankAccountId OR BankAccountTransfer.to_bank_account_id = param_bankAccountId)
		ORDER BY date DESC;
END$$
DELIMITER ;