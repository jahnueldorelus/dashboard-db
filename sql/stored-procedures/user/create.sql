DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user`$$

CREATE PROCEDURE `create_user` (IN param_mongoId VARCHAR(24))
BEGIN
	INSERT INTO User (mongo_id) VALUES (param_mongoId);

	CALL get_user(param_mongoId);
END$$
DELIMITER ;