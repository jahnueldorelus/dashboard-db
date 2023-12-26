DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_virtual_machine`$$

CREATE PROCEDURE `update_user_virtual_machine` (IN param_userId INT UNSIGNED, param_virtualMachineId INT UNSIGNED, 
												param_name VARCHAR(255), param_cpuCores SMALLINT UNSIGNED,
												param_cpuSockets TINYINT UNSIGNED, param_storageInGB DECIMAL(16,6),
												param_memoryInGB DECIMAL(16,6), param_type ENUM('UEFI', 'Legacy'))
BEGIN
	SET @serverId = (SELECT server_id FROM VirtualMachine WHERE id = param_virtualMachineId);
	SET @serverUserId = (SELECT user_id FROM ServerMachine WHERE id = @serverId);

	-- If the virtual machine doesn't belong to the user
	IF @serverUserId != param_userId THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a virtual machine the user doesn't have";
	END IF;

	UPDATE VirtualMachine SET name = param_name, cpu_cores = param_cpuCores, cpu_sockets = param_cpuSockets,
								storage_in_gb = param_storageInGB, memory_in_gb = param_memoryInGB,
								type = param_type
						WHERE id = param_virtualMachineId;

	CALL get_virtual_machine(param_virtualMachineId);
END$$
DELIMITER ;