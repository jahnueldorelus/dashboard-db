DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `create_pdu_port`$$

CREATE trigger `create_pdu_port` BEFORE INSERT ON PduPort
	FOR EACH ROW	
		BEGIN
			SET @num_of_ports = (SELECT num_of_ports FROM Pdu WHERE id = NEW.pdu_id);
			SET @num_of_used_ports = (SELECT COUNT(id) FROM PduPort WHERE pdu_id = NEW.pdu_id);
			
			-- Makes sure the number of pdu ports doesn't exceed the maximum amount available
			IF (@num_of_used_ports >= @num_of_ports)  THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "There are no more ports availble on the power distribution unit";
			END IF;
		END$$
DELIMITER ;
