DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_virtual_machines`$$

CREATE PROCEDURE `get_user_virtual_machines` (IN param_userId INT UNSIGNED, param_serverMachineId INT UNSIGNED)
BEGIN
	SELECT VirtualMachine.id, VirtualMachine.server_id AS serverId, VirtualMachine.name, 
			VirtualMachine.cpu_cores AS cpuCores, VirtualMachine.cpu_sockets as cpuSockets,
			VirtualMachine.storage_in_gb AS storageInGB, VirtualMachine.memory_in_gb AS memoryInGB,
			VirtualMachine.type 
		FROM ServerMachine
			INNER JOIN VirtualMachine ON ServerMachine.id = VirtualMachine.server_id
		WHERE ServerMachine.user_id = param_userId AND ServerMachine.id = param_serverMachineId
		ORDER BY VirtualMachine.name;
END$$
DELIMITER ;