DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `create_bank_sub_account`$$

-- Before sub account is created, a check is made to make sure its amount doesn't exceed the amount
-- of money available from the main account
CREATE trigger `create_bank_sub_account` BEFORE INSERT ON BankSubAccount
	FOR EACH ROW	
		BEGIN
			DECLARE amountInBankAccount DECIMAL(10,2);
			DECLARE amountInBankSubAccounts DECIMAL(10,2);
			DECLARE moneyLeftForNewSubAccount DECIMAL(10,2);

			SET amountInBankAccount = (SELECT amount FROM BankAccount WHERE id = NEW.bank_account_id);
			SET amountInBankSubAccounts = (SELECT SUM(amount) FROM BankSubAccount WHERE bank_account_id = NEW.bank_account_id);
			SET moneyLeftForNewSubAccount = amountInBankAccount - amountInBankSubAccounts;

			IF NEW.amount > moneyLeftForNewSubAccount THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Can't create a new sub bank account with more money than what the main account (minus previous sub accounts) has";
			END IF;
		END$$
DELIMITER ;
