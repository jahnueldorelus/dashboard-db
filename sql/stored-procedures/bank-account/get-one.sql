DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank_account`$$

CREATE PROCEDURE `get_bank_account` (IN param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT BankAccount.id, BankAccount.bank_id AS bankId, BankAccountType.type, 
		BankAccount.active, BankAccount.amount 
		FROM BankAccount
			INNER JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
		WHERE BankAccount.id = param_bankAccountId;
END$$
DELIMITER ;