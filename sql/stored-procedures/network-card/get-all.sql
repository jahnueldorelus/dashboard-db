DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_user_network_cards`$$

CREATE PROCEDURE `get_user_network_cards` (IN param_userId INT UNSIGNED, param_virtualMachineId INT UNSIGNED,
												param_serverMachineId INT UNSIGNED)
BEGIN
	-- Retrieves network cards of a server
	IF (ISNULL(param_virtualMachineId)) THEN
		SELECT NetworkCard.id, NetworkCard.server_id AS serverId, NetworkCard.name, 
				NetworkCard.ipv4, NetworkCard.ipv4_subnet as ipv4Subnet,
				NetworkCard.ipv6, NetworkCard.ipv6_subnet AS ipv6Subnet,
				NetworkCard.vlan_id AS vlanId, NetworkCard.mac_address AS macAddress
		FROM ServerMachine
			INNER JOIN NetworkCard ON NetworkCard.server_id = ServerMachine.id
		WHERE ServerMachine.user_id = param_userId AND ServerMachine.id = param_serverMachineId AND 
				ISNULL(NetworkCard.vm_id)
		ORDER BY NetworkCard.name;

	-- Retrieves network cards of a virtual machine
	ELSE
		SELECT NetworkCard.id, NetworkCard.vm_id AS vmId, NetworkCard.server_id AS serverId, NetworkCard.name, 
				NetworkCard.ipv4, NetworkCard.ipv4_subnet as ipv4Subnet,
				NetworkCard.ipv6, NetworkCard.ipv6_subnet AS ipv6Subnet,
				NetworkCard.vlan_id AS vlanId, NetworkCard.mac_address AS macAddress
		FROM ServerMachine
			INNER JOIN VirtualMachine ON ServerMachine.id = VirtualMachine.server_id
			INNER JOIN NetworkCard ON ServerMachine.id = NetworkCard.server_id AND VirtualMachine.id = NetworkCard.vm_id
		WHERE ServerMachine.user_id = param_userId AND ServerMachine.id = param_serverMachineId AND 
				VirtualMachine.id = param_virtualMachineId
		ORDER BY NetworkCard.name;
	END IF;
END$$
DELIMITER ;