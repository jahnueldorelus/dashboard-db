DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `create_user_network_card`$$

CREATE PROCEDURE `create_user_network_card` (IN param_userId INT UNSIGNED, param_virtualMachineId INT UNSIGNED, 
											param_serverId INT UNSIGNED, param_name VARCHAR(255),
											param_ipv4 CHAR(15), param_ipv4Subnet TINYINT UNSIGNED,
											param_ipv6 CHAR(39), param_ipv6Subnet TINYINT UNSIGNED,
											param_vlanId SMALLINT UNSIGNED, param_macAddress CHAR(17))
BEGIN
	-- If the virtual machine info is given (aka create a network card for a virtual machine)
	IF (NOT(ISNULL(param_virtualMachineId))) THEN
		SET @server_id = (SELECT server_id FROM VirtualMachine WHERE id = param_virtualMachineId);
		
		-- If the virtual machine doesn't exist
		IF (ISNULL(@server_id)) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a network card for a virtual machine that doesn't exist";
		END IF;

		-- If the virtual machine's server id isn't the same as the server id provided
		IF (@server_id != param_serverId) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a network card for a virtual machine that doesn't exist on the given server";
		END IF;

		-- If the virtual machine doesn't belong to the user
		SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = @server_id);
		IF (@server_user_id != param_userId) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a network card for a virtual machine you don't own";
		END IF;
	
	-- If only the server machine info is given (aka create a network card for a server machine)
	ELSE
		-- If the server machine doesn't exist
		SET @server_machine = (SELECT id FROM ServerMachine WHERE id = param_serverId);
		IF (ISNULL(@server_machine)) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a network card for a server that doesn't exist";
		END IF;

		-- If the server machine doesn't belong to the user
		SET @server_user_id = (SELECT user_id FROM ServerMachine WHERE id = param_serverId);
		IF (@server_user_id != param_userId) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot create a network card for a server you don't own";
		END IF;
	END IF;

	INSERT INTO NetworkCard (vm_id, server_id, name, ipv4, ipv4_subnet, ipv6, ipv6_subnet, vlan_id, mac_address) 
		VALUES (param_virtualMachineId, param_serverId, param_name, param_ipv4, param_ipv4Subnet, param_ipv6, param_ipv6Subnet,
				param_vlanId, param_macAddress);

	CALL get_network_card(param_virtualMachineId, LAST_INSERT_ID());
END$$
DELIMITER ;