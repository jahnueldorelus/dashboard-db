DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank_account_deposit`$$

CREATE PROCEDURE `get_bank_account_deposit` (IN param_bankAccountId INT UNSIGNED)
BEGIN
	SELECT id, bank_account_id AS bankAccountId, description, amount, dt AS date
		FROM BankAccountDeposit
		WHERE id = param_bankAccountId;
END$$
DELIMITER ;