--Populate tables that will not be edited by a single event
-- Users that will be admins
INSERT INTO USERS VALUES ('45678910111213141516', 'Amy', 'LHeureux', '123456789', '4567891234', 'ajlheureux@wpi.edu');
INSERT INTO USERS VALUES ('56789101112131415161', 'Hannah', 'Poirier', 'Password123', '5678912345', 'hpoirier@wpi.edu');
INSERT INTO USERS VALUES ('N/A', NULL, NULL, Null, Null, Null);

-- Make those users Admins
INSERT INTO Admins VALUES ('45678910111213141516', 'Senior Event Planner');
INSERT INTO Admins VALUES ('56789101112131415161', 'Event Scheduling Administrator');

--Task_Type;
INSERT INTO Task_Type VALUES  (NEXTVAL('Task_Type_seq'), 'Form');
INSERT INTO Task_Type VALUES (NEXTVAL('Task_Type_seq'), 'Request');

--Company;
INSERT INTO Company VALUES  (NEXTVAL('Company_seq'), 'Chartwells', '100 Institute Rd', 'Worcester', 'MA', '01609', 'WPI Dining Company');
INSERT INTO Company VALUES  (NEXTVAL('Company_seq'), 'Creedon', ' 39 Jolma Rd', 'Worcester', 'MA', '01604', 'Tables and Chairs');

--Vendor
INSERT INTO Vendor VALUES (1, 'Tables');

--Caterer
INSERT INTO Caterer VALUES (2, 'Dining hall food');

--Business_Contacts;
INSERT INTO Business_Contacts VALUES (NEXTVAL('Business_Contacts_seq'), 'Denis',  'Brown', '5088315685', 'dbrown5@wpi.edu', 'Resident District Manager', 1);
INSERT INTO Business_Contacts VALUES (NEXTVAL('Business_Contacts_seq'), 'John',  'Smith', '5087923100', 'inquiries@creedonandco.com', 'District Manager', 2);

--Feature_Inventory;
INSERT INTO Feature_Inventory VALUES (NEXTVAL('Feature_Inventory_seq'), 'Round Tables',  10);
INSERT INTO Feature_Inventory VALUES (NEXTVAL('Feature_Inventory_seq'), 'Folding Chairs',  50);

--Event_Types;
INSERT INTO Event_Types VALUES(NEXTVAL('Event_Type_seq'), 'Presentation');
INSERT INTO Event_Types VALUES(NEXTVAL('Event_Type_seq'), 'Banquet');

--Location_types;
INSERT INTO Location_types VALUES(NEXTVAL('Location_Type_seq'), 'Auditorium');
INSERT INTO Location_types VALUES(NEXTVAL('Location_Type_seq'), 'Room');
INSERT INTO Location_types VALUES(NEXTVAL('Location_Type_seq'), 'Outdoors');

--Locations;
INSERT INTO Locations VALUES(NEXTVAL('Location_seq'), 'Fuller Upper', 'Theater Seating', 100, 1);
INSERT INTO Locations VALUES(NEXTVAL('Location_seq'), 'CC Odeums', 'Open room, need to book chairs and tables', 150, 2);
INSERT INTO Locations VALUES(NEXTVAL('Location_seq'), 'Quad', 'Outdoors, would need to book tables', 200, 3);


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Now we create a specific event start to finish
-- User: Anne
INSERT INTO USERS VALUES ('12345678910111213141', 'Anne', 'Lapsley', 'password', '1234567891', 'aalapsley@wpi.edu');

-- Assign Anne as a host
INSERT INTO Event_Hosts VALUES ('12345678910111213141', '123456789');

-- Event: Guest Speaker
INSERT INTO Events VALUES (NEXTVAL('Event_seq'), 'Guest Speaker', 75,  TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 'A guest speaker will be coming');

-- Assign Anne as the host
INSERT INTO Hosts VALUES ('12345678910111213141', 1);

-- Assign an Admin
INSERT INTO Administrates VALUES ('45678910111213141516', 1);

-- Create event Features
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Room', 'Room booked', NULL, NULL);
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Speaker', 'Speaker Booked', NULL, NULL);

-- Associate event feature with inventory
-- None

-- Associate them with event
INSERT INTO Associated_With VALUES (1, 1);
INSERT INTO Associated_With VALUES (1, 2);

-- Create Tasks
INSERT INTO Tasks VALUES ('45678910111213141516','12345678910111213141', NEXTVAL('Task_seq'), 'Request Room', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Request Room for Event', 2,TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'),  NULL, NULL);
INSERT INTO Tasks VALUES ('45678910111213141516', '12345678910111213141', NEXTVAL('Task_seq'), 'Speaker Booked', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Request Speaker', 2,TO_TIMESTAMP('2024-03-10', 'YYYY-MM-DD'),  TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), NULL);

-- Associate them with an Event Feature
INSERT INTO Satisfies VALUES (1, 1);
INSERT INTO Satisfies VALUES (2, 1);

-- Associate tasks with business contacts
-- None

-- Host sign in
INSERT INTO Is_Present_at VALUES ('12345678910111213141', 1, TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'));



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- User: Dylan
INSERT INTO USERS VALUES ('23456789101112131415', 'Dylan', 'Phillips', '123456', '2345678912', 'drphillips@wpi.edu');

-- Assign Dylan as a host
INSERT INTO Event_Hosts VALUES ('23456789101112131415', '23456789');

-- Event: Food On Quad
INSERT INTO Events VALUES (NEXTVAL('Event_seq'), 'Food On The Quad', 175,  TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 3, 'Food will be served');

-- Assign Dylan as the host
INSERT INTO Hosts VALUES ('23456789101112131415', 2);

-- Assign an Admin
INSERT INTO Administrates VALUES ('56789101112131415161', 2);

-- Create event Features
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Get Food Form', 'Relating to Event Food', NULL, NULL);
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Return Food Form', 'Relating to Event Food', NULL, NULL);
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Book Space', 'Space booked', NULL, NULL);

-- Associate event feature with inventory
-- None

-- Associate them with event
INSERT INTO Associated_With VALUES (2, 3);
INSERT INTO Associated_With VALUES (2, 4);
INSERT INTO Associated_With VALUES (2, 5);

-- Create Tasks
INSERT INTO Tasks VALUES ('56789101112131415161', '23456789101112131415', NEXTVAL('Task_seq'), 'Return Food Form', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Return Food Form to chartwells office', 1, TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), NULL, NULL);
INSERT INTO Tasks VALUES ('56789101112131415161', '23456789101112131415', NEXTVAL('Task_seq'), 'Space Booked', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Request Room for Event', 2,TO_TIMESTAMP('2024-03-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), NULL);
INSERT INTO Tasks VALUES ('56789101112131415161', '23456789101112131415', NEXTVAL('Task_seq'), 'Form Picked up', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'retrieve Food Form from chartwells office', 1, TO_TIMESTAMP('2024-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), 3);

-- Associate them with an Event Feature
INSERT INTO Satisfies VALUES (3, 3);
INSERT INTO Satisfies VALUES (4, 4);
INSERT INTO Satisfies VALUES (5, 5);

-- Associate tasks with business contacts
INSERT INTO Is_Contacted VALUES (3, 1);
INSERT INTO Is_Contacted VALUES (5, 1);

-- Host sign in
INSERT INTO Is_Present_at VALUES ('23456789101112131415', 2, TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- User: Chad
INSERT INTO USERS VALUES ('34567891011121314151', 'Chad', 'Hucey', '123456789', '3456789123', 'chucey@wpi.edu');

-- Assign Chad as a host
INSERT INTO Event_Hosts VALUES ('34567891011121314151', '34567891');

-- Event: Gala
INSERT INTO Events VALUES (NEXTVAL('Event_seq'), 'Gala', 175,  TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 3, 'Food will be served');

-- Assign Chad as the host
INSERT INTO Hosts VALUES ('34567891011121314151', 3);

-- Assign an Admin
INSERT INTO Administrates VALUES ('56789101112131415161', 3);

-- Create event Features
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Book Credon Tables', 'Contact Credon about Tables', NULL, NULL);
INSERT INTO Event_Features VALUES (NEXTVAL('Event_Feature_seq'), 'Book Inventory Chairs', 'Using inventory chairs', 50, 2);

-- Associate them with event
INSERT INTO Associated_With VALUES (3, 6);
INSERT INTO Associated_With VALUES (3, 7);

-- Create Tasks
INSERT INTO Tasks VALUES ('56789101112131415161', '34567891011121314151', NEXTVAL('Task_seq'), 'Book Tables', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Contact Credon about Tables', 2, TO_TIMESTAMP('2024-03-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), NULL);
INSERT INTO Tasks VALUES ('56789101112131415161', '34567891011121314151', NEXTVAL('Task_seq'), 'Book Chairs', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Contact Events Office About Chairs', 2, TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'), NULL, NULL);

-- Associate them with an Event Feature
INSERT INTO Satisfies VALUES (6, 6);
INSERT INTO Satisfies VALUES (7, 7);

-- Associate tasks with business contacts
INSERT INTO Is_Contacted VALUES (6, 2);

-- Host sign in
INSERT INTO Is_Present_at VALUES ('34567891011121314151', 3, TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'));

