DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_pdu`$$

CREATE PROCEDURE `delete_user_pdu` (IN param_userId INT UNSIGNED, param_pduId INT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot delete a power distribution unit the user doesn't have";
	SET @pduUserId = (SELECT user_id FROM Pdu WHERE id = param_pduId);

	-- If the power distribution unit doesn't exist
	IF ISNULL(@pduUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the power distribution unit doesn't belong to the user
	IF @pduUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	DELETE FROM Pdu WHERE id = param_pduId AND user_id = param_userId;
END$$
DELIMITER ;