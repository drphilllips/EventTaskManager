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

--Task_Type;
INSERT INTO Task_Type VALUES  (Task_Type_seq.NEXTVAL, 'Form');
INSERT INTO Task_Type VALUES (Task_Type_seq.NEXTVAL, 'Request');

--Assigned_Tasks;
INSERT INTO Assigned_Tasks VALUES ('45678910111213141516', Task_seq.NEXTVAL, 'Request Room', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Request Room for Event', 2, '23456789101112131415', TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));
INSERT INTO Assigned_Tasks VALUES ('56789101112131415161', Task_seq.NEXTVAL, 'Fill out Chartwells form', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'Form can be turned in at chartwells office', 'Fill out Chartwells form', 1, '23456789101112131415',TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));
INSERT INTO Assigned_Tasks VALUES ('56789101112131415161', Task_seq.NEXTVAL, 'Get out Chartwells form', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'Form can be picked up at the chartwells office', 'Fill out Chartwells form', 1, '12345678910111213141',TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));
INSERT INTO Assigned_Tasks VALUES ('45678910111213141516', Task_seq.NEXTVAL, 'Reserve Tables', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'Need 10 Tables', 'Request Tables', 1, '23456789101112131415',TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));
INSERT INTO Assigned_Tasks VALUES ('45678910111213141516', Task_seq.NEXTVAL, 'Reserve Chairs', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'Need 50 Tables', 'Request Chairs', 1, '23456789101112131415',TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));

--Completed_Tasks;
INSERT INTO Completed_Tasks VALUES ('45678910111213141516', Task_seq.NEXTVAL, 'Request Room', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'N/A', 'Request Room for Event', 2, TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));
INSERT INTO Completed_Tasks VALUES ('56789101112131415161', Task_seq.NEXTVAL, 'Request Room', TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD'),'Form can be turned in at chartwells office', 'Fill out Chartwells form', 1, TO_TIMESTAMP('2024-03-16', 'YYYY-MM-DD'));

--Subtask_of;
INSERT INTO Subtask_of VALUES(2,3);

--Company;
INSERT INTO Company VALUES  (Company_seq.NEXTVAL, 'Chartwells', '100 Institute Rd', 'Worcester', 'MA', '01609', 'WPI Dining Company');
INSERT INTO Company VALUES  (Company_seq.NEXTVAL, 'Creedon', ' 39 Jolma Rd', 'Worcester', 'MA', '01604', 'Tables and Chairs');

--Business_Contacts;
INSERT INTO Business_Contacts VALUES (Business_Contacts_seq.NEXTVAL, 'Denis',  'Brown', '5088315685', 'dbrown5@wpi.edu', 'Resident District Manager', 1);
INSERT INTO Business_Contacts VALUES (Business_Contacts_seq.NEXTVAL, 'John',  'Smith', '5087923100', 'inquiries@creedonandco.com', 'District Manager', 2);

--Is_Contacted;
INSERT INTO Is_Contacted VALUES (2, 1);
INSERT INTO Is_Contacted VALUES (3, 1);
INSERT INTO Is_Contacted VALUES (1, 2);
INSERT INTO Is_Contacted VALUES (4, 2);
INSERT INTO Is_Contacted VALUES (5, 2);



--Feature_Inventory;
INSERT INTO Feature_Inventory VALUES (Feature_Inventory_seq.NEXTVAL, 'Round Tables',  10);
INSERT INTO Feature_Inventory VALUES (Feature_Inventory_seq.NEXTVAL, 'Folding Chairs',  50);

--Event_Features;
INSERT INTO Event_Features VALUES (Event_Feature_seq.NEXTVAL, 'Tables', 'Round tables',  5, 1);
INSERT INTO Event_Features VALUES (Event_Feature_seq.NEXTVAL, 'Chairs', 'Folding chairs',  25, 2);

--Satisfies;
INSERT INTO Satisfies VALUES(4, 1);
INSERT INTO Satisfies VALUES(5, 2);

--Event_Types;
INSERT INTO Event_Types VALUES(Event_Type_seq.NEXTVAL, 'Presentation');
INSERT INTO Event_Types VALUES(Event_Type_seq.NEXTVAL, 'Banquet');

--Location_types;
INSERT INTO Location_types VALUES(Location_Type_seq.NEXTVAL, 'Auditorium');
INSERT INTO Location_types VALUES(Location_Type_seq.NEXTVAL, 'Room');
INSERT INTO Location_types VALUES(Location_Type_seq.NEXTVAL, 'Outdoors');

--Locations;
INSERT INTO Locations VALUES(Location_seq.NEXTVAL, 'Fuller Upper', 'Theater Seating', 100, 1);
INSERT INTO Locations VALUES(Location_seq.NEXTVAL, 'CC Odeums', 'Open room, need to book chairs and tables', 150, 2);
INSERT INTO Locations VALUES(Location_seq.NEXTVAL, 'Quad', 'Outdoors, would need to book tables', 200, 3);

--EVENTS;
INSERT INTO Events VALUES (Event_seq.NEXTVAL, 'Guest Speaker', 75,  TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 'A guest speaker will be coming');
INSERT INTO Events VALUES (Event_seq.NEXTVAL, 'Food On The Quad', 175,  TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 3, 'Food will be served');
INSERT INTO Events VALUES (Event_seq.NEXTVAL, 'Gala', 100,  TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2, 'A Gala to benefit something');

--Associated_With;
INSERT INTO Associated_With VALUES (3, 1);
INSERT INTO Associated_With VALUES (3, 2);



-- Administrates;
INSERT INTO Administrates VALUES ('45678910111213141516', 1);
INSERT INTO Administrates VALUES ('56789101112131415161', 2);
INSERT INTO Administrates VALUES ('45678910111213141516', 3);

-- Hosts;
INSERT INTO Hosts VALUES ('12345678910111213141', 1);
INSERT INTO Hosts VALUES ('23456789101112131415', 2);
INSERT INTO Hosts VALUES ('34567891011121314151', 3);

--Is_Present_at;
INSERT INTO Is_Present_at VALUES ('12345678910111213141', 1, TO_TIMESTAMP('2024-03-24 1:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 3:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Is_Present_at VALUES ('23456789101112131415', 2, TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Is_Present_at VALUES ('34567891011121314151', 3, TO_TIMESTAMP('2024-03-24 6:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-24 8:00:00', 'YYYY-MM-DD HH24:MI:SS'));





