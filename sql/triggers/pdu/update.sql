DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_pdu`$$

-- Makes sure the new number of pdu ports isn't less than the current amount of ports that exists
CREATE trigger `update_pdu` BEFORE UPDATE ON Pdu
	FOR EACH ROW	
		BEGIN
			SET @numOfUsedPorts = (SELECT COUNT(id) FROM PduPort WHERE pdu_id = NEW.id);
			
			IF NEW.num_of_ports < @numOfUsedPorts  THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update the number of ports for the pdu to less than what currently exists";
			END IF;
		END$$
DELIMITER ;
