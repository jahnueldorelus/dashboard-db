DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_server_machine`$$

CREATE PROCEDURE `get_server_machine` (IN param_serverMachineId INT UNSIGNED)
BEGIN
	SELECT id, name, used_storage_in_gb AS usedStorageInGB, total_storage_in_gb AS totalStorageInGB,
			used_memory_in_gb AS usedMemoryInGB, total_memory_in_gb AS totalMemoryInGB,
			cpu_sockets AS cpuSockets  
		FROM ServerMachine
		WHERE id = param_serverMachineId;
END$$
DELIMITER ;