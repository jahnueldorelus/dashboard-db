DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user`$$

CREATE PROCEDURE `delete_user` (IN param_userId INT UNSIGNED)
BEGIN
	DELETE FROM User WHERE id = param_userId;
END$$
DELIMITER ;