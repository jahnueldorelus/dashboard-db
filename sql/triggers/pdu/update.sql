DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_pdu`$$

CREATE trigger `update_pdu` BEFORE UPDATE ON Pdu
	FOR EACH ROW	
		BEGIN
			SET @highest_port_number_in_use = (SELECT MAX(port_number) FROM PduPort WHERE pdu_id = NEW.id);

			-- Makes sure the new number of ports isn't less than the highest port number that exists
			IF (NEW.num_of_ports < @highest_port_number_in_use) THEN
				SET @error_message = CONCAT("Cannot update the number of ports to less than what's currently in use. The highest port in use is Port #", @highest_port_number_in_use);
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
			END IF;
		END$$
DELIMITER ;
