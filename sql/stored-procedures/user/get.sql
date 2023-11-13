DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user`$$

CREATE PROCEDURE `get_user` (IN param_mongoId VARCHAR(24))
BEGIN
	SELECT id
		FROM User
		WHERE mongo_id = param_mongoId;
END$$
DELIMITER ;