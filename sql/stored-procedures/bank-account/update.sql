DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `update_bank_account`$$

CREATE PROCEDURE `update_bank_account` (IN user_id INT UNSIGNED, bank_account_id INT UNSIGNED, 
										type_id INT UNSIGNED, amount INT UNSIGNED,
										active BOOLEAN)
BEGIN
	DECLARE bankId INT UNSIGNED;
	DECLARE bankUserId INT UNSIGNED;

	SET bankId = (SELECT bank_id FROM BankAccount WHERE id = bank_account_id);
	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bank_id);

	-- If the bank account doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a bank account the user doesn't have";
	END IF;

	UPDATE BankAccount SET type_id = type_id, amount = amount, active = active
						WHERE id = bank_account_id;
END$$

DELIMITER ;