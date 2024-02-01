DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `create_network_switch_port`$$

CREATE trigger `create_network_switch_port` BEFORE INSERT ON NetworkSwitchPort
	FOR EACH ROW	
		BEGIN
			SET @num_of_ports = (SELECT num_of_ports FROM NetworkSwitch WHERE id = NEW.switch_id);
			SET @num_of_used_ports = (SELECT COUNT(id) FROM NetworkSwitchPort WHERE switch_id = NEW.switch_id);
			
			-- Makes sure the number of ports doesn't exceed the maximum amount available on the network switch
			IF (@num_of_used_ports >= @num_of_ports) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "There are no more ports availble on the network switch";
			END IF;

			-- Makes sure the new port number doesn't exceed the amount of ports available on the network switch
			IF (NEW.port_number > @num_of_ports) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "The port number given exceeds the maximum port number available on the network switch";
			END IF;
		END$$
DELIMITER ;
