DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_pdu`$$

CREATE PROCEDURE `get_pdu` (IN param_pduId INT UNSIGNED)
BEGIN
	SELECT id, name, num_of_ports AS numOfPorts, location, type, min_freq_in_mhz AS minFreqInMhz,
			max_freq_in_mhz AS maxFreqInMhz, min_volts AS minVolts, max_volts AS maxVolts, amps
		FROM Pdu
		WHERE id = param_pduId;
END$$
DELIMITER ;