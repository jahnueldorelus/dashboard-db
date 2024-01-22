DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch`$$

CREATE PROCEDURE `update_user_network_switch` (IN param_userId INT UNSIGNED, param_switchId INT UNSIGNED,
												param_name VARCHAR(255), param_numOfPorts TINYINT UNSIGNED,
												param_location VARCHAR(255))
BEGIN
	SET @errorMessage = "Cannot update a network switch the user doesn't have";
	SET @switchUserId = (SELECT user_id FROM NetworkSwitch WHERE id = param_switchId);

	-- If the network switch doesn't exist
	IF ISNULL(@switchUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch doesn't belong to the user
	IF @switchUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;


	UPDATE NetworkSwitch SET name = param_name, num_of_ports = param_numOfPorts, location = param_location
				WHERE user_id = param_userId AND id = param_switchId;
	
	CALL get_network_switch(param_switchId);
END$$
DELIMITER ;