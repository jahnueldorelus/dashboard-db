DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_virtual_machine`$$

CREATE PROCEDURE `create_user_virtual_machine` (IN param_userId INT UNSIGNED, param_serverId INT UNSIGNED, 
											param_name VARCHAR(255), param_cpuCores SMALLINT UNSIGNED,
											param_cpuSockets TINYINT UNSIGNED, param_storageInGB DECIMAL(16,6),
											param_memoryInGB DECIMAL(16,6), param_type ENUM('UEFI', 'Legacy'))
BEGIN
	SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = param_serverId);

	-- If the server machine doesn't exist
	IF (ISNULL(@server_user_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a virtual machine on a server that doesn't exist";
	END IF;

	-- If the server machine doesn't belong to the user
	IF (@server_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a virtual machine on a server you don't own";
	END IF;

	INSERT INTO VirtualMachine (server_id, name, cpu_cores, cpu_sockets, storage_in_gb, memory_in_gb, type) 
		VALUES (param_serverId, param_name, param_cpuCores, param_cpuSockets, param_storageInGB, param_memoryInGB,
				param_type);

	CALL get_virtual_machine(LAST_INSERT_ID());
END$$
DELIMITER ;