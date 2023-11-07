DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `delete_bank_account_transfer`$$

-- Updates the associated bank accounts' amounts after the transfer is deleted
CREATE trigger `delete_bank_account_transfer` AFTER DELETE ON BankAccountTransfer
	FOR EACH ROW	
		BEGIN
			DECLARE fromBankOldAmount DECIMAL(10,2);
			DECLARE toBankOldAmount DECIMAL(10,2);

			DECLARE fromBankAccountType VARCHAR(50);
			DECLARE toBankAccountType VARCHAR(50);

			DECLARE creditCardBankAccount VARCHAR(11);
			SET creditCardBankAccount = "Credit Card";

			SET fromBankOldAmount = (SELECT amount FROM BankAccount WHERE id = OLD.from_bank_account_id);
			SET toBankOldAmount = (SELECT amount FROM BankAccount WHERE id = OLD.to_bank_account_id);

			-- Gets "from" bank account info
			SELECT BankAccount.amount, BankAccountType.type 
				INTO fromBankOldAmount, fromBankAccountType
				FROM BankAccount
					LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
				WHERE BankAccount.id = OLD.from_bank_account_id;

			-- Gets "to" bank account info
			SELECT BankAccount.amount, BankAccountType.type 
				INTO toBankOldAmount, toBankAccountType
				FROM BankAccount
					LEFT JOIN BankAccountType ON BankAccountType.id = BankAccount.type_id
				WHERE BankAccount.id = OLD.to_bank_account_id;

			-- Sets the "from" bank account balance back to its original amount before the transfer
			IF fromBankAccountType = creditCardBankAccount THEN 
				UPDATE BankAccount SET amount = fromBankOldAmount - OLD.amount WHERE id = OLD.from_bank_account_id;
			ELSE
				UPDATE BankAccount SET amount = fromBankOldAmount + OLD.amount WHERE id = OLD.from_bank_account_id;
			END IF;

			-- Sets the "to" bank account balance back to its original amount before the transfer
			IF toBankAccountType = creditCardBankAccount THEN 
				UPDATE BankAccount SET amount = toBankOldAmount + OLD.amount WHERE id = OLD.to_bank_account_id;
			ELSE
				UPDATE BankAccount SET amount = toBankOldAmount - OLD.amount WHERE id = OLD.to_bank_account_id;
			END IF;
		END$$
DELIMITER ;
