DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_virtual_machine`$$

CREATE PROCEDURE `get_virtual_machine` (IN param_virtualMachineId INT UNSIGNED)
BEGIN
	SELECT VirtualMachine.id, VirtualMachine.server_id AS serverId, VirtualMachine.name, 
			VirtualMachine.cpu_cores AS cpuCores, VirtualMachine.cpu_sockets as cpuSockets,
			VirtualMachine.storage_in_gb AS storageInGB, VirtualMachine.memory_in_gb AS memoryInGB,
			VirtualMachine.type  
		FROM VirtualMachine
		WHERE VirtualMachine.id = param_virtualMachineId;
END$$
DELIMITER ;