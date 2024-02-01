DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `delete_user_virtual_machine`$$

CREATE PROCEDURE `delete_user_virtual_machine` (IN param_userId INT UNSIGNED, param_virtualMachineId INT UNSIGNED)
BEGIN
	SET @server_id = (SELECT server_id FROM VirtualMachine WHERE id = param_virtualMachineId);

	-- If the server machine doesn't exist
	IF (ISNULL(@server_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a virtual machine that doesn't exist";
	END IF;

	-- If the server machine doesn't belong to the user
	SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = @server_id);
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot delete a virtual machine from a server you don't own";
	END IF;

	DELETE FROM VirtualMachine WHERE id = param_virtualMachineId;

END$$
DELIMITER ;