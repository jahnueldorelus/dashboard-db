DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `create_pdu_port`$$

-- Makes sure the number of pdu ports doesn't exceed that maximum amount available
CREATE trigger `create_pdu_port` BEFORE INSERT ON PduPort
	FOR EACH ROW	
		BEGIN
			SET @numOfPorts = (SELECT num_of_ports FROM Pdu WHERE id = NEW.pdu_id);
			SET @numOfUsedPorts = (SELECT COUNT(id) FROM PduPort WHERE pdu_id = NEW.pdu_id);
			
			IF @numOfUsedPorts >= @numOfPorts  THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "There are no more ports availble on the power distribution unit";
			END IF;
		END$$
DELIMITER ;
