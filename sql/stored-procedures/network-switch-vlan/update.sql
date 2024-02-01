DELIMITER $$
USE `dashboard`$$
DROP PROCEDURE IF EXISTS `update_user_network_switch_vlan`$$

CREATE PROCEDURE `update_user_network_switch_vlan` (IN param_userId INT UNSIGNED, param_switchVlanId INT UNSIGNED,
													param_name VARCHAR(255), param_vid SMALLINT UNSIGNED)
BEGIN
	SET @switch_id = (SELECT switch_id FROM NetworkSwitchVlan WHERE id = param_switchVlanId);

	-- If the network switch vlan doesn't exist
	IF (ISNULL(@switch_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  "Cannot update a network switch's VLAN that doesn't exist";
	END IF;

	-- If the network switch vlan doesn't belong to the user
	SET @switch_user_id = (SELECT user_id FROM NetworkSwitch WHERE id = @switch_id);
	IF (@switch_user_id != param_userId) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  "Cannot update a network switch's VLAN you don't own";
	END IF;


	UPDATE NetworkSwitchVlan SET name = param_name, vid = param_vid WHERE id = param_switchVlanId;
	
	CALL get_network_switch_vlan(param_switchVlanId);
END$$
DELIMITER ;