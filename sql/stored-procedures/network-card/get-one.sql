DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `get_network_card`$$

CREATE PROCEDURE `get_network_card` (IN param_virtualMachineId INT UNSIGNED, param_networkCardId INT UNSIGNED)
BEGIN
	-- Retrieves a network card of a server
	IF ISNULL(param_virtualMachineId) THEN
		SELECT NetworkCard.id, NetworkCard.server_id AS serverId, NetworkCard.name, 
				NetworkCard.ipv4, NetworkCard.ipv4_subnet as ipv4Subnet,
				NetworkCard.ipv6, NetworkCard.ipv6_subnet AS ipv6Subnet,
				NetworkCard.vlan_id AS vlanId, NetworkCard.mac_address AS macAddress
		FROM NetworkCard
		WHERE NetworkCard.id = param_networkCardId;

	-- Retrieves a network card of a virtual machine
	ELSE
		SELECT NetworkCard.id, NetworkCard.vm_id AS vmId, NetworkCard.server_id AS serverId, NetworkCard.name, 
				NetworkCard.ipv4, NetworkCard.ipv4_subnet as ipv4Subnet,
				NetworkCard.ipv6, NetworkCard.ipv6_subnet AS ipv6Subnet,
				NetworkCard.vlan_id AS vlanId, NetworkCard.mac_address AS macAddress
		FROM NetworkCard
		WHERE NetworkCard.id = param_networkCardId AND NetworkCard.vm_id = param_virtualMachineId;
	END IF;
END$$
DELIMITER ;