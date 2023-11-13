DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank_account_transfer`$$

CREATE PROCEDURE `get_bank_account_transfer` (IN param_transferId INT UNSIGNED)
BEGIN
	SELECT id, from_bank_account_id AS fromBankAccountId, to_bank_account_id AS toBankAccountId, 
			description, amount, dt AS date
		FROM BankAccountTransfer
		WHERE id = param_transferId;
END$$
DELIMITER ;