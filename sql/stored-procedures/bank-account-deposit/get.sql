DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_account_deposits`$$

CREATE PROCEDURE `get_user_bank_account_deposits` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED)
BEGIN
	SELECT BankAccountDeposit.id, BankAccount.id AS bankAccountId, description, 
			BankAccountDeposit.amount AS amount, dt AS date
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountDeposit ON BankAccountDeposit.bank_account_id = BankAccount.id
		WHERE Bank.user_id = user_id AND BankAccount.id = bank_account_id
		ORDER BY date DESC;
END$$

DELIMITER ;