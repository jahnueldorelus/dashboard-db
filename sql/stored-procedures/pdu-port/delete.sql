DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_pdu_port`$$

CREATE PROCEDURE `delete_user_pdu_port` (IN param_userId INT UNSIGNED, param_pduPortId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a power distribution unit port that the user doesn't have";
	SET @pduId = (SELECT pdu_id FROM PduPort WHERE id = param_pduPortId);

	-- If the power distribution unit doesn't exist
	IF ISNULL(@pduId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	SET @pduUserId = (SELECT user_id FROM Pdu WHERE id = @pduId);

	-- If the power distribution unit doesn't belong to the user
	IF @pduUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM PduPort WHERE id = param_pduPortId;

END$$
DELIMITER ;