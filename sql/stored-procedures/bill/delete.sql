DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_bill`$$

CREATE PROCEDURE `delete_bill` (IN bill_user_id INT UNSIGNED, bill_id INT UNSIGNED)
BEGIN
	DELETE FROM Bill WHERE id = bill_id AND user_id = bill_user_id;
END$$

DELIMITER ;