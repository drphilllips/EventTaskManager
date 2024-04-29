--USERS;
INSERT INTO USERS VALUES ('12345678910111213141', 'Anne', 'Lapsley', 'password', '1234567891', 'aalapsley@wpi.edu');
INSERT INTO USERS VALUES ('23456789101112131415', 'Dylan', 'Phillips', '123456', '2345678912', 'drphillips@wpi.edu');
INSERT INTO USERS VALUES ('34567891011121314151', 'Chad', 'Hucey', 'qwerty', '3456789123', 'chucey@wpi.edu');
INSERT INTO USERS VALUES ('45678910111213141516', 'Amy', 'LHeureux', '123456789', '4567891234', 'ajlheureux@wpi.edu');
INSERT INTO USERS VALUES ('56789101112131415161', 'Hannah', 'Poirier', 'Password123', '5678912345', 'hpoirier@wpi.edu');

--Event_Hosts;
INSERT INTO Event_Hosts VALUES ('12345678910111213141', '123456789');
INSERT INTO Event_Hosts VALUES ('23456789101112131415', '23456789');
INSERT INTO Event_Hosts VALUES ('34567891011121314151', '34567891');

--Admins;
INSERT INTO Admins VALUES ('45678910111213141516', 'Senior Event Planner');
INSERT INTO Admins VALUES ('56789101112131415161', 'Event Scheduling Administrator');

--Task Types
INSERT INTO Task_Type (Type_Name) VALUES
('Rental'),
('Obtain Permit'),
('Catering'),
('Book Entertainmnet');

--Location types: 
INSERT INTO Location_types (Loc_Type_Name, Available_Start, Available_End)
VALUES
('Outdoor', '08:00:00', '18:00:00'),
('Ball Room', '09:00:00', '21:00:00'),
('Classroom', '08:00:00', '17:00:00'),
('Lecture Hall', '08:00:00', '17:00:00'),
('Multi Purpose', '07:00:00', '19:00:00');

--Locations:
INSERT INTO Locations (Location_Name, DESCRIPTION, Capacity, Location_typeID)
VALUES
('AK219', Null, 75, 4),
('Odeum A', Null, 100, 2),
('Quad', Null, 120, 1),
('HL159', 'Classroom in Higgins Labs', 30, 3),
('Alden Hall', Null, 75, 2),
('UH420', Null, 40, 5);

--Features
INSERT INTO Features (Feature_Name, Description)
VALUES
('Chairs', NULL),
('tables', NULL),
('Permit', NULL),
('Food', NULL),
('Decorations', NULL),
('Speakers', NULL),
('Lighting', NULL),
('Keynote Speaker', NULL);

--Tasks
INSERT INTO Tasks 
(Task_Name, Assigned_by_UserID, Assigned_to_UserID, 
 Duedate, Notes, Description, TypeID, Completed_Date_Time, ParentTaskID)
VALUES
('Rent Chairs', '56789101112131415161', '34567891011121314151', 
'04/15/2024 09:00:00', Null, Null, 1, Null, Null),
('Rent Tables', '56789101112131415161', '12345678910111213141', 
'04/17/2024 10:00:00', 'Cannot contact the vendor', Null, 1, Null, Null),
('Book a speaker','56789101112131415161', '23456789101112131415',  
'04/22/2024 09:00:00', Null, Null, 4, CURRENT_TIMESTAMP, Null),
('Order catering', '56789101112131415161', '34567891011121314151', 
'04/30/2024 09:00:00', 'Got China Lantern', 'Get Chinese Food. Please note that dietary restrictiona apply', 3, CURRENT_TIMESTAMP, Null),
('Obtain a permit', '56789101112131415161', '34567891011121314151', 
'04/15/2024 09:00:00', 3, Null, 2, CURRENT_TIMESTAMP, Null),
('Rent Chairs', '56789101112131415161', '12345678910111213141', 
'04/29/2024 09:00:00', 1, Null, 1, '04/21/2024 12:30:00', Null);

--Inventory
INSERT INTO Feature_Inventory (Item_Name, Quantity, Available_Start, Available_End)
VALUES
('Folding Chairs', 30, '08:00:00', '17:00:00'),
('Tables', 50, '08:00:00', '18:00:00'),
('Sharpie Highlighters', 30, '09:00:00', '17:00:00');

--Company;
INSERT INTO Company VALUES  (NEXTVAL('Company_seq'), 'Chartwells', '100 Institute Rd', 'Worcester', 'MA', '01609', 'WPI Dining Company');
INSERT INTO Company VALUES  (NEXTVAL('Company_seq'), 'Creedon', ' 39 Jolma Rd', 'Worcester', 'MA', '01604', 'Tables and Chairs');

--Vendor
INSERT INTO Vendor VALUES (1, 'Tables');

--Caterer
INSERT INTO Caterer VALUES (2, 'Dining hall food');

-- Business_Contacts
INSERT INTO Business_Contacts VALUES 
(NEXTVAL('Business_Contacts_seq'), 'Denis',  'Brown', '5088315685', 'dbrown5@wpi.edu', 'Resident District Manager', 1, '09:30:00', '18:00:00'),
(NEXTVAL('Business_Contacts_seq'), 'John',  'Smith', '5087923100', 'inquiries@creedonandco.com', 'District Manager', 2, '09:30:00', '18:00:00');

INSERT Into Is_Contacted VALUES 
(1,1), 
(2,1), 
(4,2);

INSERT INTO Uses VALUES
(1,1),
(2,2);

INSERT INTO Satisfies VALUES
(1,1,10),
(2,2,7),
(3,7,Null),
(4,4,Null),
(5,3,Null),
(6,1,14);

INSERT Into Events
(Event_Name, Attendees_count, Start_Time_Date, End_Time_Date, Event_Status, LocID, Description)
VALUES
('Food on the Quad', 150, '04/04/2024 09:00:00', '04/04/2024 12:00:00', 'active', 3, 'Come get some delicious treats on the Quad!'),
('Comedy Night', 25, '04/21/2024 17:00:00', '04/21/2024 20:00:00', 'active', 2, 'have a laugh with WPI Comedy Club'),
('Snow WHite Rendition', 70, '04/19/2024 19:00:00', '04/19/2024 20:30:00', 'pending', 5, 'Brace from a riveting rendition of Snow White'),
('Robots Take over the World', 50, '04/25/2024 12:00:00', '04/25/2024 13:00:00', 'active', 3, 'Join us for a panel Discussion on how robots will rule us');

INSERT INTO Associated_With Values 
(1, 4), (1,1), (1,2), (3,6), (4,3), (1,5);

INSERT Into Administrates VALUES
('45678910111213141516',1),
('56789101112131415161', 2),
('56789101112131415161', 3),
('45678910111213141516',4);

INSERT INTO Hosts VALUES
('12345678910111213141', 1),
('23456789101112131415', 1),
('34567891011121314151', 1),
('12345678910111213141', 2),
('34567891011121314151', 3),
('12345678910111213141', 4),
('23456789101112131415', 4),
('34567891011121314151', 2);

INSERT Into Is_Present_at VALUES
('12345678910111213141', 1, '04/04/2024 08:57:32', '04/04/2024 12:05:32'),
('23456789101112131415', 1, '04/04/2024 08:57:32', '04/04/2024 12:05:32'),
('34567891011121314151', 1, '04/04/2024 08:59:32', '04/04/2024 12:03:32');

