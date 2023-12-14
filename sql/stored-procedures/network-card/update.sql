DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_card`$$

CREATE PROCEDURE `update_user_network_card` (IN param_userId INT UNSIGNED, param_networkCardId INT UNSIGNED,
											param_virtualMachineId INT UNSIGNED, param_serverId INT UNSIGNED, 
											param_name VARCHAR(255), param_ipv4 CHAR(15), 
											param_ipv4Subnet TINYINT UNSIGNED, param_ipv6 CHAR(39), 
											param_ipv6Subnet TINYINT UNSIGNED, param_vlanId SMALLINT UNSIGNED, 
											param_macAddress CHAR(17))
BEGIN
	-- If the virtual machine doesn't belong to the user
	IF NOT(ISNULL(param_virtualMachineId)) THEN
		SET @serverId = (SELECT server_id FROM VirtualMachine WHERE id = param_virtualMachineId);

		IF ISNULL(@serverId) OR @serverId != param_serverId THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a network card for a virtual machine the user doesn't have";
		END IF;
	END IF;

	SET @serverUserId = (SELECT user_id FROM ServerMachine WHERE id = param_serverId);

	-- If the server machine doesn't belong to the user
	IF @serverUserId != param_userId THEN
		IF ISNULL(param_virtualMachineId) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a network card for a server the user doesn't have";
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot update a network card for a virtual machine in a server the user doesn't have";
		END IF;
	END IF;

	UPDATE NetworkCard SET vm_id = param_virtualMachineId, server_id = param_serverId, name = param_name,
								ipv4 = param_ipv4, ipv4_subnet = param_ipv4Subnet, ipv6 = param_ipv6,
								ipv6_subnet = param_ipv6Subnet, vlan_id = param_vlanId, mac_address = param_macAddress
						WHERE id = param_networkCardId;

	CALL get_network_card(param_virtualMachineId, param_networkCardId);
END$$
DELIMITER ;