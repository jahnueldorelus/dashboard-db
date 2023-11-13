DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank_account_sub_account`$$

CREATE PROCEDURE `get_bank_account_sub_account` (IN param_subAccountId INT UNSIGNED)
BEGIN
	SELECT id, bank_account_id AS bankAccountId, name, amount
		FROM BankSubAccount
		WHERE id = param_subAccountId;
END$$
DELIMITER ;