DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_pdu`$$

CREATE PROCEDURE `create_user_pdu` (IN param_userId INT UNSIGNED, param_name VARCHAR(255), 
									param_numOfPorts TINYINT UNSIGNED, param_location VARCHAR(255),
									param_type ENUM("Rackmount", "Floor-Mounted", "Cabinet", "Portable"),
									param_minFreqInMhz DECIMAL(13,6), param_maxFreqInMhz DECIMAL(13,6),
									param_minVolts SMALLINT UNSIGNED, param_maxVolts SMALLINT UNSIGNED,
									param_amps TINYINT UNSIGNED)
BEGIN
	INSERT INTO Pdu (user_id, name, num_of_ports, location, type, min_freq_in_mhz, max_freq_in_mhz,
					min_volts, max_volts, amps) 
		VALUES (param_userId, param_name, param_numOfPorts, param_location, param_type, param_minFreqInMhz, 
				param_maxFreqInMhz, param_minVolts, param_maxVolts, param_amps);

	CALL get_pdu(LAST_INSERT_ID());
END$$
DELIMITER ;