DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_accounts`$$

CREATE PROCEDURE `get_user_bank_accounts` (IN user_id INT UNSIGNED)
BEGIN
	SELECT Bank.id AS bank_id, BankAccount.id as account_id, type AS account_type, active, amount 
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
		WHERE user_id = user_id;
END$$

DELIMITER ;