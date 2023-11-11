-- Gets the user's sub bank accounts
DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_account_sub_accounts`$$

CREATE PROCEDURE `get_user_bank_account_sub_accounts` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED)
BEGIN
	SELECT BankSubAccount.id, BankAccount.id as bankAccountId, 
			BankSubAccount.name, BankSubAccount.amount as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			INNER JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = user_id AND BankSubAccount.bank_account_id = bank_account_id;
END$$
DELIMITER ;


-- Gets the total sum of the user's sub accounts for each account bank account
DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_account_sub_accounts_sum`$$

CREATE PROCEDURE `get_user_bank_account_sub_accounts_sum` (IN user_id INT UNSIGNED, 
															bank_account_id INT UNSIGNED)
BEGIN
	SELECT SUM(BankSubAccount.amount) as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			INNER JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = 1 AND BankAccount.id = bank_account_id
		GROUP BY BankAccount.id;
END$$
DELIMITER ;