DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_bank`$$

CREATE PROCEDURE `get_bank` (IN param_bankId INT UNSIGNED)
BEGIN
	SELECT id, name, address_one AS addressOne, address_two AS addressTwo, city, state, zipcode FROM Bank
		WHERE id = param_bankId;
END$$
DELIMITER ;