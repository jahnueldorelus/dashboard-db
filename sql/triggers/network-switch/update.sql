DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_network_switch`$$

-- Makes sure the new number of ports isn't less than the current amount of ports that exists
CREATE trigger `update_network_switch` BEFORE UPDATE ON NetworkSwitch
	FOR EACH ROW	
		BEGIN
			SET @numOfUsedPorts = (SELECT COUNT(id) FROM NetworkSwitchPort WHERE switch_id = NEW.id);
			
			IF NEW.num_of_ports < @numOfUsedPorts  THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update the number of ports for the network switch to less than what currently exists";
			END IF;
		END$$
DELIMITER ;
