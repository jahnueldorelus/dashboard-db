DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_network_switch`$$

CREATE trigger `update_network_switch` BEFORE UPDATE ON NetworkSwitch
	FOR EACH ROW	
		BEGIN
			SET @highest_port_number_in_use = (SELECT MAX(port_number) FROM NetworkSwitchPort WHERE switch_id = NEW.id);
			SET @num_of_vlans_on_switch = (SELECT COUNT(id) FROM NetworkSwitchVlan WHERE switch_id = NEW.id);

			-- Makes sure the new number of ports isn't less than the highest port number that exists
			IF (NEW.num_of_ports < @highest_port_number_in_use) THEN
				SET @error_message = CONCAT("Cannot update the number of ports to less than what's currently in use. The highest port in use is Port #", @highest_port_number_in_use);
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
			END IF;

			-- Makes sure the network switch is vlan capable if it has any registered vlans
			IF ((OLD.vlan_capable = 1) AND (NEW.vlan_capable = 0) AND (@num_of_vlans_on_switch > 0)) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update the network switch as incapable of VLANs when there are VLANs registered to it";
			END IF;
		END$$
DELIMITER ;
