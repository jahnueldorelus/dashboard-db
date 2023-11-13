DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_banks_accounts`$$

CREATE PROCEDURE `get_user_banks_accounts` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT BankAccount.id, BankAccount.bank_id AS bankId, BankAccountType.type, 
		BankAccount.active, BankAccount.amount 
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
		WHERE Bank.user_id = param_userId
		ORDER BY bankId, BankAccountType.type, BankAccount.active;
END$$
DELIMITER ;