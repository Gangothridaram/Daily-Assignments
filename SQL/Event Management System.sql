-- Create Database
CREATE DATABASE EventManagement;

-- Use Database
USE EventManagement;

-- Create Tables
CREATE TABLE Organizer (
    OrganizerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    ContactEmail VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Venue (
    VenueID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Location VARCHAR(200),
    Capacity INT
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    Description TEXT,
    Date DATE,
    VenueID INT,
    OrganizerID INT,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID),
    FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Attendee (
    AttendeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    AttendeeID INT,
    RegistrationDate DATE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendee(AttendeeID)
);

-- Alter: Add Column
ALTER TABLE Event ADD COLUMN TicketPrice DECIMAL(10,2);

-- Insert into Tables
INSERT INTO Organizer (Name, ContactEmail, Phone) VALUES
('charan teja', 'teja@0928', '7981833915'),
('gangothri', 'ganga@7785', '7675898379');

INSERT INTO Venue (Name, Location, Capacity) VALUES
('City Hall', 'Main Road, Hyderabad', 500),
('Green Park', 'Sector 7, Delhi', 300);

INSERT INTO Event (Title, Description, Date, VenueID, OrganizerID, TicketPrice) VALUES
('Tech Conference', 'Annual technology conference', '2025-09-20', 1, 1, 999.99),
('Music Fest', 'Live music performances', '2025-10-10', 2, 2, 499.50);

INSERT INTO Attendee (Name, Email, Phone) VALUES
('Amit Sharma', 'amit@gmail.com', '9876112233'),
('Sara Ali', 'sara@gmail.com', '9876223344');

INSERT INTO Registration (EventID, AttendeeID, RegistrationDate) VALUES
(1, 1, '2025-08-18'),
(2, 2, '2025-08-19');

-- Update
UPDATE Venue SET Capacity = 600 WHERE VenueID = 1;

-- Delete
DELETE FROM Registration WHERE AttendeeID = 2;
DELETE FROM Attendee WHERE AttendeeID = 2;

-- Where
SELECT * FROM Event WHERE TicketPrice > 500;

-- Aggregate Functions
SELECT COUNT(*) AS TotalEvents FROM Event;
SELECT AVG(TicketPrice) AS AveragePrice FROM Event;

-- Group By
SELECT VenueID, COUNT(*) AS EventCount FROM Event GROUP BY VenueID;

-- Having
SELECT VenueID, COUNT(*) AS EventCount 
FROM Event 
GROUP BY VenueID 
HAVING EventCount > 1;

-- Like
SELECT * FROM Attendee WHERE Name LIKE 'A%';

-- Sub Queries
SELECT * FROM Event 
WHERE OrganizerID = (SELECT OrganizerID FROM Organizer WHERE Name = 'Priya Kumar');

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE GetEventDetails(IN event_id INT)
BEGIN
    SELECT * FROM Event WHERE EventID = event_id;
END //
DELIMITER ;

-- Trigger
DELIMITER //
CREATE TRIGGER before_registration_insert
BEFORE INSERT ON Registration
FOR EACH ROW
BEGIN
    DECLARE event_capacity INT;
    DECLARE reg_count INT;
    SELECT Capacity INTO event_capacity FROM Venue v
    JOIN Event e ON v.VenueID = e.VenueID
    WHERE e.EventID = NEW.EventID;
    
    SELECT COUNT(*) INTO reg_count FROM Registration WHERE EventID = NEW.EventID;
    
    IF reg_count >= event_capacity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Event capacity full!';
    END IF;
END //
DELIMITER ;
