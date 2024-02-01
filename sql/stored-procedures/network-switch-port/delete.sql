DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_switch_port`$$

CREATE PROCEDURE `delete_user_network_switch_port` (IN param_userId INT UNSIGNED, param_switchPortId INT UNSIGNED)
BEGIN
	SET @switch_id = (SELECT switch_id FROM NetworkSwitchPort WHERE id = param_switchPortId);

	-- If the network switch port doesn't exist
	IF (ISNULL(@switch_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a network switch port that doesn't exist";
	END IF;

	-- If the network switch port doesn't belong to the user
	SET @switch_port_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id);
	IF (@switch_port_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a port on a network switch you don't own";
	END IF;

	DELETE FROM NetworkSwitchPort WHERE id = param_switchPortId;
END$$
DELIMITER ;