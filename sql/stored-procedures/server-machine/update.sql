DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_server_machine`$$

CREATE PROCEDURE `update_user_server_machine` (IN param_userId INT UNSIGNED, param_serverMachineId INT UNSIGNED,
										param_name VARCHAR(255), param_usedStorageInGB INT UNSIGNED, 
										param_totalStorageInGB INT UNSIGNED, param_usedMemoryInGB INT UNSIGNED, 
										param_totalMemoryInGB INT UNSIGNED, param_cpuSockets TINYINT UNSIGNED)
BEGIN
	SET @errorMessage = "Cannot update a server machine the user doesn't have";
	SET @serverUserId = (SELECT user_id FROM ServerMachine WHERE id = param_serverMachineId);

	-- If the server machine doesn't exist
	IF ISNULL(@serverUserId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
	END IF;

	-- If the server machine doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMessage;
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