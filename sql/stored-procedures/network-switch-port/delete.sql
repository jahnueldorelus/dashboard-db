DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch_port`$$

CREATE PROCEDURE `delete_user_network_switch_port` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a port in a network switch the user doesn't have";
	SET @switchPortUserId = (SELECT user_id FROM NetworkSwitchPort 
								LEFT JOIN NetworkSwitch  
									ON NetworkSwitchPort.switch_id = NetworkSwitch.id
								WHERE NetworkSwitchPort.id = param_switchPortId);

	-- If the network switch port doesn't exist
	IF ISNULL(@switchPortUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the network switch port doesn't belong to the user
	IF @switchPortUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM NetworkSwitchPort WHERE id = param_switchPortId;
END$$
DELIMITER ;