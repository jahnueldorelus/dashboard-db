-- Gets the user's sub bank accounts
DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_sub_accounts`$$

CREATE PROCEDURE `get_user_bank_sub_accounts` (IN user_id INT UNSIGNED)
BEGIN
	SELECT BankAccount.id as bank_account_id, BankSubAccount.name as sub_account_name, BankSubAccount.amount as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = user_id;
END$$

DELIMITER ;


-- Gets the total sum of the user's sub accounts for each account bank account
DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user_bank_sub_accounts_sum`$$

CREATE PROCEDURE `get_user_bank_sub_accounts_sum` (IN user_id INT UNSIGNED)
BEGIN
	SELECT BankAccount.id AS bank_account_id, SUM(BankSubAccount.amount) as amount
		FROM Bank
			LEFT JOIN BankAccount ON Bank.id = BankAccount.bank_id
			LEFT JOIN BankSubAccount ON BankSubAccount.bank_account_id = BankAccount.id
		WHERE Bank.user_id = 1
		GROUP BY BankAccount.id;
END$$

DELIMITER ;