DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_pdu`$$

CREATE PROCEDURE `update_user_pdu` (IN param_userId INT UNSIGNED, param_pduId INT UNSIGNED,
										param_name VARCHAR(255), param_numOfPorts TINYINT UNSIGNED,
										param_location VARCHAR(255), 
										param_type ENUM("Rackmount", "Floor-Mounted", "Cabinet", "Portable"),
										param_minFreqInMhz DECIMAL(13,6), param_maxFreqInMhz DECIMAL(13,6),
										param_minVolts SMALLINT UNSIGNED, param_maxVolts SMALLINT UNSIGNED,
										param_amps TINYINT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot update a power distribution unit the user doesn't have";
	SET @pduUserId = (SELECT user_id FROM Pdu WHERE id = param_pduId);

	-- If the power distribution unit doesn't exist
	IF ISNULL(@pduUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the power distribution unit doesn't belong to the user
	IF @pduUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;


	UPDATE Pdu SET name = param_name, num_of_ports = param_numOfPorts, location = param_location,
					type = param_type, min_freq_in_mhz = param_minFreqInMhz, max_freq_in_mhz = param_maxFreqInMhz,
					min_volts = param_minVolts, max_volts = param_maxVolts, amps = param_amps
				WHERE user_id = param_userId AND id = param_pduId;
	
	CALL get_pdu(param_pduId);
END$$
DELIMITER ;