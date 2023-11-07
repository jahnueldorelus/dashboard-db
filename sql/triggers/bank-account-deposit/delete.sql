DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `delete_bank_account_deposit`$$

-- Updates the associated bank account amount after the deposit is deleted
CREATE trigger `delete_bank_account_deposit` AFTER DELETE ON BankAccountDeposit
	FOR EACH ROW	
		BEGIN
			DECLARE bankAccountPreviousAmount DECIMAL(10,2);
			DECLARE bankAccountType VARCHAR(50);

			-- Sets the bank account info
			SELECT BankAccount.amount, BankAccountType.type INTO bankAccountPreviousAmount, bankAccountType  
				FROM BankAccount 
					LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
				WHERE BankAccount.id = OLD.bank_account_id;

			-- If the bank account is for a credit card, the balance increases
			IF bankAccountType = "Credit Card" THEN 
				UPDATE BankAccount SET amount = (bankAccountPreviousAmount + OLD.amount) WHERE id = OLD.bank_account_id;
			
			-- If the bank account is for a non-credit card, the balance decreases
			ELSE
				UPDATE BankAccount SET amount = (bankAccountPreviousAmount - OLD.amount) WHERE id = OLD.bank_account_id;
			END IF;
		END$$
DELIMITER ;