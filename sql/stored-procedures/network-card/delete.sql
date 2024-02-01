DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_network_card`$$

CREATE PROCEDURE `delete_user_network_card` (IN param_userId INT UNSIGNED, param_networkCardId INT UNSIGNED)
BEGIN
	SET @server_id = (SELECT server_id FROM NetworkCard WHERE id = param_networkCardId);

	-- If the network card doesn't exist
	IF (ISNULL(@server_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a network card that doesn't exist";
	END IF;


	-- If the network card doesn't belong to the user
	SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = @server_id);
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a network card you don't own";
	END IF;

	DELETE FROM NetworkCard WHERE id = param_networkCardId;
END$$
DELIMITER ;