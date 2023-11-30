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
	CONSTRAINT UC_External_App UNIQUE (user_id, name, link)
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
	CONSTRAINT UC_Emby_Server UNIQUE (user_id, host, host_name)
);

CREATE TABLE dashboard.PaymentOccurence (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	type ENUM('week', 'month', 'year') NOT NULL,

	PRIMARY KEY (id),
	UNIQUE (type)
);
INSERT INTO dashboard.PaymentOccurence (type) VALUES ("week");
INSERT INTO dashboard.PaymentOccurence (type) VALUES ("month");
INSERT INTO dashboard.PaymentOccurence (type) VALUES ("year");

CREATE TABLE dashboard.Subscription (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	occurence_id INT UNSIGNED NOT NULL,
	occurs_every INT UNSIGNED NOT NULL,
	company VARCHAR(155) NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	website VARCHAR(155) NOT NULL,
	due_date DATE NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (occurence_id) REFERENCES PaymentOccurence(id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Subscription UNIQUE (user_id, company)
);

CREATE TABLE dashboard.Bill (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	occurence_id INT UNSIGNED,
	occurs_every INT UNSIGNED,
	recurring BOOLEAN NOT NULL,
	company VARCHAR(155) NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	website VARCHAR(155) NOT NULL,
	due_date DATE NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (occurence_id) REFERENCES PaymentOccurence(id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Bill UNIQUE (user_id, company)
);

CREATE TABLE dashboard.Bank (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	user_id INT UNSIGNED NOT NULL,
	name VARCHAR(100) NOT NULL,
	address_one VARCHAR(200) NOT NULL,
	address_two VARCHAR(200),
	city VARCHAR(85) NOT NULL,
	state VARCHAR(30) NOT NULL,
	zipcode VARCHAR(10) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
	CONSTRAINT UC_Bank UNIQUE (user_id, name)
);

CREATE TABLE dashboard.BankAccountType (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	type ENUM('Checking', 'Savings', 'Money Market', 'Certificate of Deposit', 'Credit Card') NOT NULL, 

	PRIMARY KEY (id),
	UNIQUE (type)
);
INSERT INTO dashboard.BankAccountType (type) VALUES ("Checking");
INSERT INTO dashboard.BankAccountType (type) VALUES ("Savings");
INSERT INTO dashboard.BankAccountType (type) VALUES ("Money Market");
INSERT INTO dashboard.BankAccountType (type) VALUES ("Certificate of Deposit");
INSERT INTO dashboard.BankAccountType (type) VALUES ("Credit Card");

CREATE TABLE dashboard.BankAccount (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	bank_id INT UNSIGNED NOT NULL,
	type_id INT UNSIGNED NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	active BOOLEAN NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (bank_id) REFERENCES Bank(id) ON DELETE CASCADE,
	FOREIGN KEY (type_id) REFERENCES BankAccountType(id)
);

CREATE TABLE dashboard.BankSubAccount (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	bank_account_id INT UNSIGNED NOT NULL,
	name VARCHAR(100) NOT NULL,
	amount DECIMAL(10,2) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (bank_account_id) REFERENCES BankAccount(id) ON DELETE CASCADE,
	CONSTRAINT UC_Bank_Sub_Account UNIQUE (bank_account_id, name)
);

CREATE TABLE dashboard.BankAccountDeposit (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	bank_account_id INT UNSIGNED NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	description VARCHAR(100) NOT NULL,
	dt DATE NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (bank_account_id) REFERENCES BankAccount(id) ON DELETE CASCADE
);

CREATE TABLE dashboard.BankAccountWithdrawal (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	bank_account_id INT UNSIGNED NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	description VARCHAR(100) NOT NULL,
	dt DATE NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (bank_account_id) REFERENCES BankAccount(id) ON DELETE CASCADE
);

CREATE TABLE dashboard.BankAccountTransfer (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	from_bank_account_id INT UNSIGNED NOT NULL,
	to_bank_account_id INT UNSIGNED NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	description VARCHAR(100) NOT NULL,
	dt DATE NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (from_bank_account_id) REFERENCES BankAccount(id) ON DELETE CASCADE,
	FOREIGN KEY (to_bank_account_id) REFERENCES BankAccount(id) ON DELETE CASCADE
);