DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank_account_withdrawal`$$

CREATE PROCEDURE `get_bank_account_withdrawal` (IN param_withdrawalId INT UNSIGNED)
BEGIN
	SELECT id, bank_account_id AS bankAccountId, description, amount, dt AS date
		FROM BankAccountWithdrawal
		WHERE id = param_withdrawalId;
END$$
DELIMITER ;