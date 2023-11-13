DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_bill`$$

CREATE PROCEDURE `delete_user_bill` (IN param_userId INT UNSIGNED, param_billId INT UNSIGNED)
BEGIN
	DELETE FROM Bill WHERE id = param_billId AND user_id = param_userId;
END$$
DELIMITER ;