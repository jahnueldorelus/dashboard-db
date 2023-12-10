DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_server_machine`$$

CREATE PROCEDURE `create_user_server_machine` (IN param_userId INT UNSIGNED, param_name VARCHAR(255), 
										param_usedStorageInGB INT UNSIGNED, param_totalStorageInGB INT UNSIGNED,
										param_usedMemoryInGB INT UNSIGNED, param_totalMemoryInGB INT UNSIGNED,
										param_cpuSockets TINYINT UNSIGNED)
BEGIN
	INSERT INTO ServerMachine (user_id, name, used_storage_in_gb, total_storage_in_gb, used_memory_in_gb, 
						total_memory_in_gb, cpu_sockets) 
		VALUES (param_userId, param_name, param_usedStorageInGB, param_totalStorageInGB,
				param_usedMemoryInGB, param_totalMemoryInGB, param_cpuSockets);

	CALL get_server_machine(LAST_INSERT_ID());
END$$
DELIMITER ;