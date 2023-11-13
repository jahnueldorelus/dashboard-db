DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bank`$$

CREATE PROCEDURE `delete_user_bank` (IN param_userId INT UNSIGNED, param_bankId INT UNSIGNED)
BEGIN
	DELETE FROM Bank WHERE id = param_bankId AND user_id = param_userId;
END$$
DELIMITER ;