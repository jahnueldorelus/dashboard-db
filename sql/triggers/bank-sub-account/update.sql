DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_bank_sub_account`$$

-- Before sub account is updated, a check is made to make sure its amount doesn't exceed the amount
-- of money available from the main account
CREATE trigger `update_bank_sub_account` BEFORE UPDATE ON BankSubAccount
	FOR EACH ROW	
		BEGIN
			DECLARE amountInBankAccount DECIMAL(10,2);
			DECLARE amountInBankSubAccounts DECIMAL(10,2);
			DECLARE moneyLeftForSubAccount DECIMAL(10,2);

			SET amountInBankAccount = (SELECT amount FROM BankAccount WHERE id = NEW.bank_account_id);
			SET amountInBankSubAccounts = (SELECT SUM(amount) FROM BankSubAccount WHERE bank_account_id = NEW.bank_account_id AND id != NEW.id);
			SET moneyLeftForSubAccount = amountInBankAccount - amountInBankSubAccounts;

			IF NEW.amount > moneyLeftForSubAccount THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Can't update the bank sub account with more money than what can be allocated to it";
			END IF;
		END$$
DELIMITER ;
