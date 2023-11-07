DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_bank_account`$$

CREATE PROCEDURE `create_bank_account` (IN user_id INT UNSIGNED, bank_id INT UNSIGNED, 
										type_id INT UNSIGNED, amount INT UNSIGNED,
										active BOOLEAN)
BEGIN
	DECLARE bankUserId INT UNSIGNED;

	SET bankUserId = (SELECT user_id FROM Bank WHERE id = bank_id);

	-- If the bank doesn't belong to the user
	IF bankUserId != user_id THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a bank account in a bank the user doesn't have";
	END IF;

	INSERT INTO BankAccount (bank_id, type_id, amount, active) 
		VALUES (bank_id, type_id, amount, active);
END$$

DELIMITER ;