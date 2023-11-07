DELIMITER $$
USE `dashboard`$$
DROP procedure IF EXISTS `create_user`$$

CREATE PROCEDURE `create_user` (IN new_mongo_id VARCHAR(24))
BEGIN
	INSERT INTO User (mongo_id) VALUES (new_mongo_id);
END$$

DELIMITER ;