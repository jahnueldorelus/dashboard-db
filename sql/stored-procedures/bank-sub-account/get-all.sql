-- Gets the user's sub bank accounts
DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_bank_accounts_sub_accounts`$$

CREATE PROCEDURE `get_user_bank_accounts_sub_accounts` (IN param_userId INT UNSIGNED, param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT BankSubAccount.id, BankAccount.id as bankAccountId, 
			BankSubAccount.name, BankSubAccount.amount as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			INNER JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = param_userId AND BankSubAccount.bank_account_id = param_bankAccountId;
END$$
DELIMITER ;


-- Gets the total sum of the user's sub accounts for each account bank account
DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_accounts_sub_accounts_sum`$$

CREATE PROCEDURE `get_user_bank_accounts_sub_accounts_sum` (IN param_userId INT UNSIGNED, 
															param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT SUM(BankSubAccount.amount) as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			INNER JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = param_userId AND BankAccount.id = param_bankAccountId
		GROUP BY BankAccount.id;
END$$
DELIMITER ;