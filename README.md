# Dashboard Database

SQL commands to setup a new Dashboard database with tables and their resepective triggers/stored procedures.

## Tech Stack

**Database:** MySQL

## Database Warning

The database is setup where all changes should be done using the stored procedures given. Otherwise, there may be a glitch in the data. This is due to the complexity of the triggers. For example, if a change were to be made in a record where an "update" trigger updates the data in a table not belonging to the record, the data changed may cause a miscalculation.

- Real Example: If the bank account id for a deposit is changed, the trigger that handles updating the user's bank account balance will not correctly update the old and new account balances. It can only handle changes made within the same account.

Therefore, for some records, not all attributes can be updated. If a mistake was made, the record has to be deleted and a new one created. The stored procedures are central to prevent errors such as these from occuring within the database.

To add, update, or delete tables, stored procedures, and triggers, **make sure** to review the database functionality section to understand if your change to the database requires other changes to be made.

## Database Tables

    1.  Bank
    2.  BankAccount
    3.  BankAccountDeposit
    4.  BankAccountTransfer
    5.  BankAccountType
    6.  BankAccountWithdrawal
    7.  BankSubAccount
    8.  Bill
    9.  EmbyServer
    10. ExternalApp
    11. PaymentOccurence
    12. Subscription
    13. SurveillanceCamera
    14. User

## Database Functionality

    NOTE: Most tables are associated with a user

### User

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete, but will delete **ALL** data associated with the user in the database.

### Bank

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete, but will delete **ALL** bank accounts associated with the bank.

### BankAccount

- **CREATE:** Can only be created when its associated bank exists.
- **UPDATE:** Can update all attributes.
- **DELETE:** Can only delete if the account is not a part of any transfers with other bank accounts. If it is, the bank account will not be deleted, but will be set as inactive. Otherwise, **ALL** data associated with the bank account (deposits, withdrawals, and sub accounts) will be deleted.

### BankAccountDeposit

- **CREATE:** Can only be created when its associated bank account exists. A new deposit will trigger the associated bank account to update it's balance.
- **UPDATE:** Can update all attributes **except** the bank account the deposit was made in, and will trigger the associated bank account to update it's balance.
- **DELETE:** Can delete, and will trigger the associated bank account to update it's balance.

### BankAccountTransfer

- **CREATE:** Can only be created when its associated bank accounts exists. A new transfer will trigger the associated bank accounts to update their balance.
- **UPDATE:** Can update all attributes **except** the bank accounts the transfer was made between, and will trigger the associated bank accounts to update their balance.
- **DELETE:** Can delete, and will trigger the associated bank accounts to update their balance.

### BankAccountType

- **CREATE:** Cannot create a new type as all types will have already been created if the SQL within this repository was used to create this table.
- **UPDATE:** Cannot update account types.
- **DELETE:** Cannot delete any account type as it's needed to create a bank account.

### BankAccountWithdrawal

- **CREATE:** Can only be created when its associated bank account exists. A new withdrawal will trigger the associated bank account to update it's balance.
- **UPDATE:** Can update all attributes **except** the bank account the withdrawal was made in, and will trigger the associated bank account to update it's balance.
- **DELETE:** Can delete, and will trigger the associated bank account to update it's balance.

### BankSubAccount

- **CREATE:** Can only be created when its associated bank account exists (aka the main bank account). The new sub bank account balance cannot exceed the maximum balance available.
  `Max Balance Available = (main account balance) - (the sum of the existing sub bank accounts' balance)`
- **UPDATE:** Can update all attributes **except** the main bank account the sub bank account was made in. However, if a new balance for the sub bank account is given, the new balance cannot exceed the maximum balance available.
  `Max Balance Available = (main account balance) - (the sum of the existing sub bank accounts' balance except the one being updated)`
- **DELETE:** Can delete.

### Bill

- **CREATE:** Can be created only if the bill is recurring and an occurence frequency is given **OR** the bill is not recurring and an occurence frequency is not given. Otherwise, an error will occur.
- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete.

### EmbyServer

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete.

### ExternalApp

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete.

### PaymentOccurence

- **CREATE:** Cannot create a new payment occurence as all occurences will have already been created if the SQL within this repository was used to create this table.
- **UPDATE:** Cannot update payment occurences.
- **DELETE:** Cannot delete any payment occurence as it's needed to create a recurring bill or subscription.

### Subscription

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete.

### SurveillanceCamera

- **UPDATE:** Can update all attributes.
- **DELETE:** Can delete.

## Stored Procedure Structure

When creating a stored procedure, make sure to follow the following syntax to keep consistency between the other stored procedures.

- Delimiter: Use "**$$**" as the delimiter for the procedure and restore it back to "**;**" once the procedure completes
- Database: Call "**use your_database_name**" before creating the procedure to ensure the correct database is used when creating the procedure.
- Drop previous procedure: To prevent an error when creating a procedure, drop any procedure with the same name as the procedure you will create before creating it.
- Name: "my_custom_procedure_name" (Use underscores to seperate words)
- Paremeters: "param*userId" \*\*(First "param*" follow by camel-casing of the paremeter name)\*\*
- Spacing: Do your best to keep proper spacing betweem special MySQL syntax to make it easier to read the code.
- Capitalization: Use all capital letters when using MySQL syntax to make it easy to differentiate between MySQL syntax, paremeters, variables, etc.

Here's an example of how a stored procedure should look like. All stored procedures should look similar to this:

```
DELIMITER $$
USE `fake_database`$$
DROP PROCEDURE IF EXISTS `create_fake_user`$$

CREATE PROCEDURE `create_fake_user` (IN param_name VARCHAR(255), param_age INT UNSIGNED,
									param_heightInFeet DECIMAL(2,2))
BEGIN
	INSERT INTO FakeUser (name, age, height_in_feet)
				VALUES (param_name, param_age, param_heightInFeet);

	SELECT * FROM FakeUser WHERE id = LAST_INSERT_ID();
END$$
DELIMITER ;
```
