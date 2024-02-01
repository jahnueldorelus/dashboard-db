DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_server_machine`$$

CREATE PROCEDURE `update_user_server_machine` (IN param_userId INT UNSIGNED, param_serverMachineId INT UNSIGNED,
												param_name VARCHAR(255), param_usedStorageInGB DECIMAL(16,6), 
												param_totalStorageInGB DECIMAL(16,6), param_usedMemoryInGB DECIMAL(16,6), 
												param_totalMemoryInGB DECIMAL(16,6), param_cpuSockets TINYINT UNSIGNED)
BEGIN
	SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = param_serverMachineId);

	-- If the server machine doesn't exist
	IF (ISNULL(@server_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a server machine that doesn't exist";
	END IF;

	-- If the server machine doesn't belong to the user
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a server machine you don't own";
	END IF;


	UPDATE ServerMachine SET name = param_name, used_storage_in_gb = param_usedStorageInGB, 
									total_storage_in_gb = param_totalStorageInGB,
									used_memory_in_gb = param_usedMemoryInGB,
									total_memory_in_gb = param_totalMemoryInGB,
									cpu_sockets = param_cpuSockets
						WHERE user_id = param_userId AND id = param_serverMachineId;
	
	CALL get_server_machine(param_serverMachineId);
END$$
DELIMITER ;