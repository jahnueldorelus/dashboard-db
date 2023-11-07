DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_bank`$$

CREATE PROCEDURE `delete_bank` (IN bank_user_id INT UNSIGNED, bank_id INT UNSIGNED)
BEGIN
	DELETE FROM Bank WHERE id = bank_id AND user_id = bank_user_id;
END$$

DELIMITER ;