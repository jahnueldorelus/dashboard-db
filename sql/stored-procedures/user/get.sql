DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `get_user`$$

CREATE PROCEDURE `get_user` (IN mongo_id VARCHAR(24))
BEGIN
	SELECT id
		FROM User
		WHERE mongo_id = mongo_id;
END$$
DELIMITER ;