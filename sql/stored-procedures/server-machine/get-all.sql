DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_server_machines`$$

CREATE PROCEDURE `get_user_server_machines` (IN param_userId INT UNSIGNED)
BEGIN
	SELECT id, name, used_storage_in_gb AS usedStorageInGB, total_storage_in_gb AS totalStorageInGB,
			used_memory_in_gb AS usedMemoryInGB, total_memory_in_gb AS totalMemoryInGB,
			cpu_sockets AS cpuSockets 
		FROM ServerMachine
		WHERE user_id = param_userId
		ORDER BY name DESC;
END$$
DELIMITER ;