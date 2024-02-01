DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_pdu`$$

CREATE PROCEDURE `delete_user_pdu` (IN param_userId INT UNSIGNED, param_pduId INT UNSIGNED)
BEGIN
	SET @pdu_user_id = (SELECT user_id FROM Pdu WHERE id = param_pduId);

	-- If the power distribution unit doesn't exist
	IF (ISNULL(@pdu_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a power distribution unit that doesn't exist";
	END IF;

	-- If the power distribution unit doesn't belong to the user
	IF (@pdu_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a power distribution unit you don't own";
	END IF;

	DELETE FROM Pdu WHERE id = param_pduId AND user_id = param_userId;
END$$
DELIMITER ;