--DROP Tables

--Foreign Key
DROP TABLE if exists Is_Present_at ;
DROP TABLE if exists Administrates ;
DROP TABLE if exists Hosts ;
DROP TABLE if exists Event_Hosts ;
DROP TABLE if exists Admins ;
DROP TABLE if exists Satisfies ;
--DROP TABLE Subtask_of;
DROP TABLE if exists Is_Contacted ;
--DROP TABLE Assigned_Tasks;
--DROP TABLE Completed_Tasks;
DROP TABLE if exists Tasks ;
DROP TABLE if exists Business_Contacts;
DROP TABLE if exists Associated_With ;
DROP TABLE if exists Event_Features ;
DROP TABLE if exists EVENTS ;
DROP TABLE if exists Locations ;
DROP TABLE if exists Vendor ;
DROP TABLE if exists Caterer ;
--DROP TABLE Tasks;

--No Foriegn Key
DROP TABLE if exists Company ;
DROP TABLE if exists Feature_Inventory ;
DROP TABLE if exists Event_Types ;
DROP TABLE if exists Location_types ;
DROP TABLE if exists USERS ;
DROP TABLE if exists Task_Type ;

-- Sequences used to generate automatic primary keys (in oracle)
DROP SEQUENCE if exists Task_Type_seq ;
DROP SEQUENCE if exists Task_seq ;
DROP SEQUENCE if exists Company_seq ;
DROP SEQUENCE if exists Business_Contacts_seq ;
DROP SEQUENCE if exists Feature_Inventory_seq ;
DROP SEQUENCE if exists Event_Feature_seq ;
DROP SEQUENCE if exists Event_Type_seq ;
DROP SEQUENCE if exists Location_Type_seq ;
DROP SEQUENCE if exists Location_seq ;
DROP SEQUENCE if exists Event_seq ;

--Schemsa, Sequences and Tables

-- "Users (UserID: string, First_Name: string, Last_Name: String,
--  Password: String, Phone: String, Email: String
-- Primary Key: UserID
-- Candidate Key: Email
-- No Foriegn Key"
CREATE TABLE USERS (
    UserID VARCHAR(20) PRIMARY KEY,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    user_password VARCHAR(50),
    Phone CHAR(10),
    Email VARCHAR(50) UNIQUE
);

-- "Event_Hosts(UserID: String, Student_ID_integer: string)
-- Primary Key: UserID
-- Candidate Key: Student_ID_integer
-- Foriegn Key: UserID"
CREATE TABLE Event_Hosts (
    UserID VARCHAR(20) PRIMARY KEY,
    Student_ID_integer CHAR(9) UNIQUE,
    FOREIGN KEY (UserID) REFERENCES USERS (UserID) 
);

-- "Admins(UserID: String, Job_Title: string)
-- Primary Key: UserID
-- No Candidate Key
-- Foriegn Key: UserID"
CREATE TABLE Admins (
    UserID VARCHAR(20) PRIMARY KEY,
    Job_Title VARCHAR(30), 
    FOREIGN KEY (UserID) REFERENCES USERS (UserID) 
);

-- "Task_Type(TypeID: integer, Name: String)
-- Primary Key: TaskID
-- No Candidate Key
-- No Foreign Key"

CREATE SEQUENCE Task_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Task_Type (
    TypeID integer PRIMARY KEY,
    Type_Name VARCHAR(30)
);


-- "Tasks(TaskID: integer, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: integer)
-- Primary Key: TaskID
-- No Cnadidate Key
-- Foriegn Key: TypeID"
CREATE SEQUENCE Task_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

-- CREATE TABLE Tasks (
--     TaskID integer PRIMARY KEY,
--     Task_Name VARCHAR(35),
--     Duedate TIMESTAMP,
--     Notes VARCHAR(250),
--     Description VARCHAR(100),
--     TypeID integer,
--     FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID)
-- );

-- "Assigned_Tasks(UserID: string, TaskID: integer, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: integer, Assigned to: string, Assigned Date/Time: Date
-- Primary Key: (UserID, TaskID)
-- No Candidate Key
-- Foriegn Key: TaskID, UserID, Assigned to"
--CREATE TABLE Assigned_Tasks (
---    UserID VARCHAR(20) NOT NULL,
--    TaskID integer PRIMARY KEY,
--    Task_Name VARCHAR(35),
--    Duedate TIMESTAMP,
--    Notes VARCHAR(250),
 --   Description VARCHAR(100),
 --   TypeID integer,
 --   Assigned_To VARCHAR(20),
 --   Assign_Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 --   FOREIGN KEY (UserID) REFERENCES USERS (UserID),
 --   FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID),
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID),
 --   FOREIGN KEY (Assigned_To) REFERENCES USERS (UserID)
--);


-- "Completed_Tasks(UserID: string, TaskID: integer, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: integer, Completed Date/Time: Date
-- Primary Key: (UserID, TaskID)
-- No Candidate Key
-- Foriegn Key: TaskID, UserID"
--CREATE TABLE Completed_Tasks (
  --  UserID VARCHAR(20) NOT NULL,
    --TaskID integer PRIMARY KEY,
    --Task_Name VARCHAR(35),
    --Duedate TIMESTAMP,
    --Notes VARCHAR(250),
    --Description VARCHAR(100),
    --TypeID integer,
    --Completed_Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    --ParentTaskID integer, 
    --FOREIGN KEY (UserID) REFERENCES USERS (UserID),
    --FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID)
    --Foreign Key (ParentTaskID) Re
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID)
--);


CREATE TABLE Tasks (
    Assigned_by_UserID VARCHAR(20) NOT NULL,
    Assigned_to_UserID VARCHAR(20) NOT NULL,
    TaskID integer PRIMARY KEY,
    Task_Name VARCHAR(35),
    Duedate TIMESTAMP,
    Notes VARCHAR(250),
    Description VARCHAR(100),
    TypeID integer,
    Assigned_Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Completed_Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ParentTaskID integer, 
    FOREIGN KEY (Assigned_by_UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (Assigned_to_UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID),
    Foreign Key (ParentTaskID) References Tasks (TaskID)
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID)
);



-- "Company(CompanyID: integer, Name: String, Street Address: String, City: String, State: String, 
-- ZipCode: String, Description: String)
-- Primary Key: CompanyID
-- No Candidate Key
-- No Forieng Key"
CREATE SEQUENCE Company_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Company (
    CompanyID integer PRIMARY KEY,
    Comapny_Name VARCHAR(30),
    Street_Address VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    ZipCode CHAR(5),
    Description VARCHAR(100)
);


-- "Business_Contacts(ContactID: integer, First_Name: String, Last_name: String, Phone: String, 
-- Email: String, Job Title: String, CompanuID: integer
-- Primary Key: ContactID
-- Candidate Key: email
-- Foreign Key: CompanyID"
CREATE SEQUENCE Business_Contacts_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Business_Contacts (
    ContactID integer PRIMARY KEY,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Phone CHAR(10),
    Email VARCHAR(50) UNIQUE,
    Job_Title VARCHAR(30),
    CompanyID integer,
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);


-- "Is Contacted(TaskID: integer, ContactID: integer)
-- Primary Key: (TaksID, ContactID)
-- No Candidate Key
-- Foriegn Key: TaskID, ContactID"
CREATE TABLE Is_Contacted (
    TaskID integer,
    ContactID integer,
    PRIMARY KEY (TaskID, ContactID),
    FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID),  
    FOREIGN KEY (ContactID) REFERENCES Business_Contacts (ContactID)
);

-- "Feature_Inventory(ItemID: integer, Name: String, Quantity: integer)
-- Primary Key: ItemID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Feature_Inventory_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Feature_Inventory (
    ItemID integer Primary KEY,
    Item_Name VARCHAR(50),
    Quantity INTEGER
);

-- "Event Features(FeatureID: integer, Name: String, Description: String, Count: interger, ItemID: integer)
-- Primary Key: FeatureID
-- No Candidate Key
-- Forieng Key: ItemID"
CREATE SEQUENCE Event_Feature_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

Create TABLE Event_Features (
    FeatureID integer Primary KEY,
    Feature_Name VARCHAR(30),
    Descritpion VARCHAR(100),
    Feature_Count INTEGER,
    ItemID integer,
    FOREIGN KEY (ItemID) REFERENCES Feature_Inventory (ItemID)
);

-- "Satisfies(TaskID: integer, FeatureID: integer)
-- Primary Key: (TaskID, FeatureID)
-- No Candidate Key
-- Foriegn Key: TaskID, FeatureID"
CREATE TABLE Satisfies (
    TaskID integer,
    FeatureID integer,
    PRIMARY KEY (TaskID, FeatureID),
    FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID),
    FOREIGN KEY (FeatureID) REFERENCES Event_Features (FeatureID)
);



-- "Event Types(Event TypeID: integer, Name: String)
-- Primary Key: Event TypeID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Event_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
   ;

CREATE TABLE Event_Types (
    Event_TypeID integer PRIMARY KEY,
    Event_Type_Name VARCHAR(50)
);


-- "Location Type(Location Type ID: integer, Name: String)
-- Primary Key: Location TypeID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Location_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Location_types (
    Location_typeID integer Primary KEY,
    Loc_Type_Name VARCHAR(50)
);



-- "Locations(LocID: integer, Name: String, Descritpion: String, Capacity: integer, Location TypeID: integer
-- Primary Key: LocID
-- No Candidate Key
-- Foriegn Key: Location TypeID"
CREATE SEQUENCE Location_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Locations (
    LocID integer PRIMARY KEY,
    Location_Name VARCHAR(50),
    DESCRIPTION Varchar(100),
    Capacity INTEGER,
    Location_typeID integer,
    FOREIGN KEY (Location_typeID) REFERENCES Location_types (Location_typeID)
);



-- "Events(EventID: integer, Name: String, integer of Attendees: integer, Start Date/Time: timestamp, 
-- end Date/Time: timestamp, Event TypeID: integer, LocID: integer, Description: String
-- Primary Key: EventID
-- No Candidate Key
-- Foriegn Key: Event Type ID, LocID"
CREATE SEQUENCE Event_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Events (
    EventID integer PRIMARY KEY,
    Event_Name VARCHAR(50),
    Attendees_conut INTEGER,
    Start_Time_Date TIMESTAMP,
    End_Time_Date TIMESTAMP,
    Event_TypeID integer,
    LocID integer,
    DESCRIPTION VARCHAR(100),
    FOREIGN KEY (Event_TypeID) REFERENCES Event_Types (Event_TypeID),
    FOREIGN KEY (LocID) REFERENCES Locations (LocID)
);

-- "Associated_With(EventID: integer, FeatureID: integer)
-- Primary key: (EventID, FeatureID)
-- No Candidate Key
-- Foriegn Key: EventID, Feature ID"
CREATE TABLE Associated_With (
    EventID integer,
    FeatureID integer,
    PRIMARY KEY (EventID, FeatureID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (FeatureID) REFERENCES Event_Features (FeatureID)
);


-- "Administrates(UserID: String, EventID: integer)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Administrates (
    UserID VARCHAR(20),
    EventId integer,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Admins (UserID)
);

-- "Hosts(UserID: String, EventID: integer)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Hosts (
    UserID VARCHAR(20),
    EventId integer,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);

-- "Is Present at(UserID: String, EventID: integer, sign in Date/time: timestamp, sign out Data/Time: timestamp)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Is_Present_at (
    UserID VARCHAR(20),
    EventID integer,
    Sign_In TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Sign_Out TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);

CREATE TABLE Vendor (
    CompanyID integer, 
    Equipment_type VARCHAR(50), 
    PRIMARY Key (CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

CREATE TABLE Caterer (
    CompanyID integer, 
    Cuisine_type VARCHAR(30), 
    PRIMARY Key (CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);



