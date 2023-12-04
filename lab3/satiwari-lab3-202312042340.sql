-- Lab 3
-- satiwari
-- Dec 4, 2023

USE `satiwari`;
-- BAKERY-1
-- Using a single SQL statement, reduce the prices of Lemon Cake and Napoleon Cake by $2.
--;


USE `satiwari`;
-- BAKERY-2
-- Using a single SQL statement, increase by 15% the price of all Apricot or Chocolate flavored items with a current price below $5.95.
--;


USE `satiwari`;
-- BAKERY-3
-- Add the capability for the database to record payment information for each receipt in a new table named payments (see assignment PDF for task details)
DELETE FROM receipts WHERE RNumber = '99999';


USE `satiwari`;
-- BAKERY-4
-- Create a database trigger to prevent the sale of Meringues (any flavor) and all Almond-flavored items on Saturdays and Sundays.
--;


USE `satiwari`;
-- AIRLINES-1
-- Enforce the constraint that flights should never have the same airport as both source and destination (see assignment PDF)
CREATE TRIGGER airlines_trigger
BEFORE INSERT ON flights
FOR EACH ROW
BEGIN
    Declare MESSAGE_TEXT varchar(100);
    IF (NEW.SourceAirport = NEW.DestAirport) THEN
            SIGNAL SQLSTATE '45000';
            SET MESSAGE_TEXT = 'Insertion not allowed on weekends';
    END IF;
END;


USE `satiwari`;
-- AIRLINES-2
-- Add a "Partner" column to the airlines table to indicate optional corporate partnerships between airline companies (see assignment PDF)
CREATE TRIGGER insert_airlines_partner_trigger
BEFORE INSERT ON airlines
FOR EACH ROW
BEGIN
    Declare MESSAGE_TEXT varchar(100);
    Declare airlineName varchar(100);
    
    set airlineName = NULL;
    
    SELECT Airline into airlineName from airlines where Abbreviation = New.Partner;
    
    IF (airlineName IS NULL AND NEW.Partner is NOT NULL) THEN
        SIGNAL SQLSTATE '45000';
        SET MESSAGE_TEXT = 'Insertion not allowed in this manner';
    END IF;
    
    IF (NEW.Abbreviation = NEW.Partner) THEN
        SIGNAL SQLSTATE '45000';
        SET MESSAGE_TEXT = 'Insertion not allowed in this manner';
    END IF;

END;


USE `satiwari`;
-- KATZENJAMMER-1
-- Change the name of two instruments: 'bass balalaika' should become 'awesome bass balalaika', and 'guitar' should become 'acoustic guitar'. This will require several steps. You may need to change the length of the instrument name field to avoid data truncation. Make this change using a schema modification command, rather than a full DROP/CREATE of the table.
select * from goods;


USE `satiwari`;
-- KATZENJAMMER-2
-- Keep in the Vocals table only those rows where Solveig (id 1 -- you may use this numeric value directly) sang, but did not sing lead.
Alter Table Vocals 
Change VocalType Type varchar(100) not null;


