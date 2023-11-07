DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_account_transfers`$$

CREATE PROCEDURE `get_user_bank_account_transfers` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED)
BEGIN
	SELECT BankAccountTransfer.from_bank_account_id AS from_bank_account, BankAccountTransfer.to_bank_account_id AS to_bank_account, 
			description, BankAccountTransfer.amount AS amount, dt AS date
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountTransfer ON 
				(BankAccountTransfer.from_bank_account_id = BankAccount.id OR BankAccountTransfer.to_bank_account_id = BankAccount.id)
		WHERE Bank.user_id = user_id 
			AND (BankAccountTransfer.from_bank_account_id = bank_account_id OR BankAccountTransfer.to_bank_account_id = bank_account_id)
		ORDER BY date DESC;
END$$

DELIMITER ;