DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_network_switch_port`$$

CREATE PROCEDURE `get_network_switch_port` (IN param_switchPortId INT UNSIGNED)
BEGIN
	SELECT id, switch_id as switchId, port_number as portNumber, name, pvid, mode
		FROM NetworkSwitchPort
		WHERE id = param_switchPortId;
END$$
DELIMITER ;