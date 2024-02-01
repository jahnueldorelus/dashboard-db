DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_pdu_port`$$

CREATE PROCEDURE `delete_user_pdu_port` (IN param_userId INT UNSIGNED, param_pduPortId INT UNSIGNED)
BEGIN
	SET @pdu_id = (SELECT pdu_id FROM PduPort WHERE id = param_pduPortId);

	-- If the power distribution unit doesn't exist
	IF (ISNULL(@pdu_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a power distribution unit port that doesn't exist";
	END IF;


	-- If the power distribution unit doesn't belong to the user
	SET @pdu_user_id = (SELECT user_id FROM Pdu WHERE id = @pdu_id);
	IF (@pdu_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a power distribution unit port you don't own";
	END IF;

	DELETE FROM PduPort WHERE id = param_pduPortId;

END$$
DELIMITER ;