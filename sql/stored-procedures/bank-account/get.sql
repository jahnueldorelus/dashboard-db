DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_accounts`$$

CREATE PROCEDURE `get_user_bank_accounts` (IN user_id INT UNSIGNED)
BEGIN
	SELECT BankAccount.id, BankAccount.bank_id AS bankId, BankAccountType.type, 
		BankAccount.active, BankAccount.amount 
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
		WHERE Bank.user_id = user_id
		ORDER BY bankId, BankAccountType.type, BankAccount.active;
END$$
DELIMITER ;