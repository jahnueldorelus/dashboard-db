DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `delete_bank_account`$$

-- Sets bank account as inactive instead of deleting it if the account has any transfers with another account
CREATE trigger `delete_bank_account` BEFORE DELETE ON BankAccount
	FOR EACH ROW	
		BEGIN
			DECLARE numOfTransfers INT UNSIGNED;

			SET numOfTransfers = (
				SELECT COUNT(id) FROM BankAccountTransfer
					WHERE BankAccountTransfer.from_bank_account_id = OLD.id OR BankAccountTransfer.to_bank_account_id = OLD.id
			);

			IF numOfTransfers > 0 THEN
				UPDATE BankAccount SET active = FALSE WHERE id = OLD.id;
			END IF;
		END$$
DELIMITER ;
