DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_bank_account`$$

CREATE PROCEDURE `create_user_bank_account` (IN param_userId INT UNSIGNED, param_bankId INT UNSIGNED, 
										param_typeId INT UNSIGNED, param_amount DECIMAL(10,2),
										param_active BOOLEAN)
BEGIN
	SET @bankUserId = (SELECT user_id FROM Bank WHERE id = param_bankId);

	-- If the bank doesn't belong to the user
	IF @bankUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a bank account in a bank the user doesn't have";
	END IF;

	INSERT INTO BankAccount (bank_id, type_id, amount, active) 
		VALUES (param_bankId, param_typeId, param_amount, param_active);

	CALL get_bank_account(LAST_INSERT_ID());
END$$
DELIMITER ;