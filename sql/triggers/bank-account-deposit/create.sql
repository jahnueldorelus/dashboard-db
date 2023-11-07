DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `create_bank_account_deposit`$$

-- Updates the associated bank account amount after the deposit is created
CREATE trigger `create_bank_account_deposit` AFTER INSERT ON BankAccountDeposit
	FOR EACH ROW	
		BEGIN
			DECLARE bankAccountPreviousAmount DECIMAL(10,2);
			DECLARE bankAccountType VARCHAR(50);

			-- Sets the bank account info
			SELECT BankAccount.amount, BankAccountType.type INTO bankAccountPreviousAmount, bankAccountType  
				FROM BankAccount 
					LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
				WHERE BankAccount.id = NEW.bank_account_id;

			-- If the bank account is a credit card account
			IF bankAccountType = "Credit Card" THEN 
				UPDATE BankAccount SET amount = (bankAccountPreviousAmount - NEW.amount) WHERE id = NEW.bank_account_id;
			
			-- If the bank account is a non-credit card account
			ELSE
				UPDATE BankAccount SET amount = (bankAccountPreviousAmount + NEW.amount) WHERE id = NEW.bank_account_id;
			END IF;
		END$$
DELIMITER ;
