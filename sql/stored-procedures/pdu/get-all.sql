DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_pdus`$$

CREATE PROCEDURE `get_user_pdus` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location, type, min_freq_in_mhz AS minFreqInMhz,
			max_freq_in_mhz AS maxFreqInMhz, min_volts AS minVolts, max_volts AS maxVolts, amps
		FROM Pdu
		WHERE user_id = param_userId
		ORDER BY name DESC;
END$$
DELIMITER ;