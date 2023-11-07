DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `delete_user`$$

CREATE PROCEDURE `delete_user` (IN user_id INT UNSIGNED)
BEGIN
	DELETE FROM User WHERE id = user_id;
END$$

DELIMITER ;