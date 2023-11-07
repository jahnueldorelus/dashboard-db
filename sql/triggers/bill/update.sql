DELIMITER $$
USE `dashboard`$$
DROP trigger IF EXISTS `update_bill`$$

-- Before a bill is updated, a check is made to make sure an occurence id is given if
-- the bill is recurring
CREATE trigger `update_bill` BEFORE UPDATE ON Bill
	FOR EACH ROW	
		BEGIN
			-- If the bill is recurring but no occurence frequency is given
			IF NEW.recurring = TRUE AND (ISNULL(NEW.occurence_id) OR ISNULL(NEW.occurs_every)) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Can't update a bill as recurring without adding an occurence frequency";
			END IF;

			-- If an occurence frequency is given but the bill is not recurring
			IF NEW.recurring = FALSE AND (NEW.occurence_id IS NOT NULL OR NEW.occurs_every IS NOT NULL) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Can't update a bill with an occurence frequency that's not recurring";
			END IF;
		END$$
DELIMITER ;