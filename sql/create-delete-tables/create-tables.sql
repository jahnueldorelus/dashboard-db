CREATE TABLE dashboard.User (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	mongo_id VARCHAR(24) NOT NULL,

	PRIMARY KEY (id),
	CONSTRAINT UC_User UNIQUE (mongo_id)
);

CREATE TABLE dashboard.ExternalApp (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	link VARCHAR(255) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_External_App_Name UNIQUE (user_id, name),
	CONSTRAINT UC_External_App_Link UNIQUE (user_id, link)
);

CREATE TABLE dashboard.SurveillanceCamera (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	link VARCHAR(255) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Surveillance_Camera_Name UNIQUE (user_id, name),
	CONSTRAINT UC_Surveillance_Camera_Link UNIQUE (user_id, link)
);

CREATE TABLE dashboard.EmbyServer (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	host VARCHAR(255) NOT NULL,
	host_name VARCHAR(255) NOT NULL,
	api_key VARCHAR(255) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Emby_Server_Host UNIQUE (user_id, host),
	CONSTRAINT UC_Emby_Server_Host_Name UNIQUE (user_id, host_name)
);

CREATE TABLE dashboard.ServerMachine (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	used_storage_in_gb INT UNSIGNED NOT NULL,
	total_storage_in_gb INT UNSIGNED NOT NULL,
	used_memory_in_gb INT UNSIGNED NOT NULL,
	total_memory_in_gb INT UNSIGNED NOT NULL,
	cpu_sockets TINYINT UNSIGNED NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Server_Name UNIQUE (user_id, name)
);

CREATE TABLE dashboard.VirtualMachine (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	server_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	cpu_cores SMALLINT UNSIGNED NOT NULL,
	cpu_sockets TINYINT UNSIGNED NOT NULL,
	storage_in_gb INT UNSIGNED NOT NULL,
	memory_in_gb INT UNSIGNED NOT NULL,
	type ENUM('UEFI', 'Legacy') NOT NULL, 

	PRIMARY KEY (id),
	FOREIGN KEY (server_id) REFERENCES ServerMachine(id) ON DELETE CASCADE,
	CONSTRAINT UC_Server_Virtual_Machine_Name UNIQUE (server_id, name)
);

CREATE TABLE dashboard.NetworkCard (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	server_vm_id INT UNSIGNED,
	server_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	ipv4 CHAR(15) NOT NULL,
	ipv4_subnet TINYINT UNSIGNED NOT NULL,
	ipv6 CHAR(39) NOT NULL,
	ipv6_subnet TINYINT UNSIGNED NOT NULL,
	vlan_id SMALLINT UNSIGNED NOT NULL,
	mac_address CHAR(17) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (server_vm_id) REFERENCES VirtualMachine(id) ON DELETE CASCADE,
	FOREIGN KEY (server_id) REFERENCES ServerMachine(id) ON DELETE CASCADE,
	CONSTRAINT UC_Machine_Network_Name UNIQUE (server_vm_id, server_id, name)
);
