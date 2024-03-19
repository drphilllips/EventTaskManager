--DROP Tables

--Foriegn Key
DROP TABLE Is_Present_at;
DROP TABLE Administrates;
DROP TABLE Hosts;
DROP TABLE Event_Hosts;
DROP TABLE Admins;
DROP TABLE Satisfies;
DROP TABLE Subtask_of;
DROP TABLE Is_Contacted;
DROP TABLE Assigned_Tasks;
DROP TABLE Completed_Tasks;
DROP TABLE Business_Contacts;
DROP TABLE Associated_With;
DROP TABLE Event_Features;
DROP TABLE EVENTS;
DROP TABLE Locations;
--DROP TABLE Tasks;

--No Foriegn Key
DROP TABLE Company;
DROP TABLE Feature_Inventory;
DROP TABLE Event_Types;
DROP TABLE Location_types;
DROP TABLE USERS;
DROP TABLE Task_Type;

-- Sequences used to generate automatic primary keys (in oracle)
DROP SEQUENCE Task_Type_seq;
DROP SEQUENCE Task_seq;
DROP SEQUENCE Company_seq;
DROP SEQUENCE Business_Contacts_seq;
DROP SEQUENCE Feature_Inventory_seq;
DROP SEQUENCE Event_Feature_seq;
DROP SEQUENCE Event_Type_seq;
DROP SEQUENCE Location_Type_seq;
DROP SEQUENCE Location_seq;
DROP SEQUENCE Event_seq;

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

-- "Event_Hosts(UserID: String, Student_ID_number: string)
-- Primary Key: UserID
-- Candidate Key: Student_ID_number
-- Foriegn Key: UserID"
CREATE TABLE Event_Hosts (
    UserID VARCHAR(20) PRIMARY KEY,
    Student_ID_number CHAR(9) UNIQUE,
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

-- "Task_Type(TypeID: number, Name: String)
-- Primary Key: TaskID
-- No Candidate Key
-- No Foreign Key"

CREATE SEQUENCE Task_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Task_Type (
    TypeID NUMBER PRIMARY KEY,
    Type_Name VARCHAR(30)
);


-- "Tasks(TaskID: number, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: number)
-- Primary Key: TaskID
-- No Cnadidate Key
-- Foriegn Key: TypeID"
CREATE SEQUENCE Task_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- CREATE TABLE Tasks (
--     TaskID NUMBER PRIMARY KEY,
--     Task_Name VARCHAR(35),
--     Duedate TIMESTAMP,
--     Notes VARCHAR(250),
--     Description VARCHAR(100),
--     TypeID NUMBER,
--     FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID)
-- );

-- "Assigned_Tasks(UserID: string, TaskID: number, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: number, Assigned to: string, Assigned Date/Time: Date
-- Primary Key: (UserID, TaskID)
-- No Candidate Key
-- Foriegn Key: TaskID, UserID, Assigned to"
CREATE TABLE Assigned_Tasks (
    UserID VARCHAR(20) NOT NULL,
    TaskID NUMBER PRIMARY KEY,
    Task_Name VARCHAR(35),
    Duedate TIMESTAMP,
    Notes VARCHAR(250),
    Description VARCHAR(100),
    TypeID NUMBER,
    Assigned_To VARCHAR(20),
    Assign_Date_Time TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID),
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID),
    FOREIGN KEY (Assigned_To) REFERENCES USERS (UserID)
);


-- "Completed_Tasks(UserID: string, TaskID: number, Name: String, Duedate: Date, Notes: String, 
-- Description: String, TypeID: number, Completed Date/Time: Date
-- Primary Key: (UserID, TaskID)
-- No Candidate Key
-- Foriegn Key: TaskID, UserID"
CREATE TABLE Completed_Tasks (
    UserID VARCHAR(20) NOT NULL,
    TaskID NUMBER PRIMARY KEY,
    Task_Name VARCHAR(35),
    Duedate TIMESTAMP,
    Notes VARCHAR(250),
    Description VARCHAR(100),
    TypeID NUMBER,
    Completed_Date_Time TIMESTAMP DEFAULT SYSDATE,
    FOREIGN KEY (UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID)
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID)
);



-- "Subtask_of(Parent TaskTaskID: number, Sub Task TaskID: number)
-- Primary Key: (Parent TaskTaskID, Sub Task TaskID)
-- No Candidate Key
-- Foriegn Key: Parent TaskTaskID, Sub Task TaskID"
CREATE TABLE Subtask_of (
    Parent_TaskID NUMBER,
    Sub_TaksID NUMBER,
    PRIMARY KEY (Parent_TaskID, Sub_TaksID),
    FOREIGN KEY (Parent_TaskID) REFERENCES Assigned_Tasks (TaskID),
    FOREIGN KEY (Sub_TaksID) REFERENCES Assigned_Tasks (TaskID)
);



-- "Company(CompanyID: number, Name: String, Street Address: String, City: String, State: String, 
-- ZipCode: String, Description: String)
-- Primary Key: CompanyID
-- No Candidate Key
-- No Forieng Key"
CREATE SEQUENCE Company_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Company (
    CompanyID Number PRIMARY KEY,
    Comapny_Name VARCHAR(30),
    Street_Address VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    ZipCode CHAR(5),
    Description VARCHAR(100)
);


-- "Business_Contacts(ContactID: number, First_Name: String, Last_name: String, Phone: String, 
-- Email: String, Job Title: String, CompanuID: number
-- Primary Key: ContactID
-- Candidate Key: email
-- Foreign Key: CompanyID"
CREATE SEQUENCE Business_Contacts_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Business_Contacts (
    ContactID NUMBER PRIMARY KEY,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Phone CHAR(10),
    Email VARCHAR(50) UNIQUE,
    Job_Title VARCHAR(30),
    CompanyID NUMBER,
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);


-- "Is Contacted(TaskID: number, ContactID: number)
-- Primary Key: (TaksID, ContactID)
-- No Candidate Key
-- Foriegn Key: TaskID, ContactID"
CREATE TABLE Is_Contacted (
    TaskID NUMBER,
    ContactID NUMBER,
    PRIMARY KEY (TaskID, ContactID),
    FOREIGN KEY (TaskID) REFERENCES Assigned_Tasks (TaskID),
    FOREIGN KEY (ContactID) REFERENCES Business_Contacts (ContactID)
);

-- "Feature_Inventory(ItemID: number, Name: String, Quantity: number)
-- Primary Key: ItemID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Feature_Inventory_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Feature_Inventory (
    ItemID NUMBER Primary KEY,
    Item_Name VARCHAR(50),
    Quantity INTEGER
);

-- "Event Features(FeatureID: number, Name: String, Description: String, Count: interger, ItemID: Number)
-- Primary Key: FeatureID
-- No Candidate Key
-- Forieng Key: ItemID"
CREATE SEQUENCE Event_Feature_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

Create TABLE Event_Features (
    FeatureID NUMBER Primary KEY,
    Feature_Name VARCHAR(30),
    Descritpion VARCHAR(100),
    Feature_Count INTEGER,
    ItemID NUMBER,
    FOREIGN KEY (ItemID) REFERENCES Feature_Inventory (ItemID)
);

-- "Satisfies(TaskID: number, FeatureID: number)
-- Primary Key: (TaskID, FeatureID)
-- No Candidate Key
-- Foriegn Key: TaskID, FeatureID"
CREATE TABLE Satisfies (
    TaskID NUMBER,
    FeatureID NUMBER,
    PRIMARY KEY (TaskID, FeatureID),
    FOREIGN KEY (TaskID) REFERENCES Assigned_Tasks (TaskID),
    FOREIGN KEY (FeatureID) REFERENCES Event_Features (FeatureID)
);



-- "Event Types(Event TypeID: number, Name: String)
-- Primary Key: Event TypeID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Event_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Event_Types (
    Event_TypeID NUMBER PRIMARY KEY,
    Event_Type_Name VARCHAR(50)
);


-- "Location Type(Location Type ID: number, Name: String)
-- Primary Key: Location TypeID
-- No Candidate Key
-- No Foriegn Key"
CREATE SEQUENCE Location_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Location_types (
    Location_typeID NUMBER Primary KEY,
    Loc_Type_Name VARCHAR(50)
);



-- "Locations(LocID: number, Name: String, Descritpion: String, Capacity: integer, Location TypeID: number
-- Primary Key: LocID
-- No Candidate Key
-- Foriegn Key: Location TypeID"
CREATE SEQUENCE Location_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Locations (
    LocID NUMBER PRIMARY KEY,
    Location_Name VARCHAR(50),
    DESCRIPTION Varchar(100),
    Capacity INTEGER,
    Location_typeID NUMBER,
    FOREIGN KEY (Location_typeID) REFERENCES Location_types (Location_typeID)
);



-- "Events(EventID: number, Name: String, Number of Attendees: integer, Start Date/Time: timestamp, 
-- end Date/Time: timestamp, Event TypeID: number, LocID: number, Description: String
-- Primary Key: EventID
-- No Candidate Key
-- Foriegn Key: Event Type ID, LocID"
CREATE SEQUENCE Event_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE TABLE Events (
    EventID Number PRIMARY KEY,
    Event_Name VARCHAR(50),
    Attendees_conut INTEGER,
    Start_Time_Date TIMESTAMP,
    End_Time_Date TIMESTAMP,
    Event_TypeID NUMBER,
    LocID NUMBER,
    DESCRIPTION VARCHAR(100),
    FOREIGN KEY (Event_TypeID) REFERENCES Event_Types (Event_TypeID),
    FOREIGN KEY (LocID) REFERENCES Locations (LocID)
);

-- "Associated_With(EventID: number, FeatureID: number)
-- Primary key: (EventID, FeatureID)
-- No Candidate Key
-- Foriegn Key: EventID, Feature ID"
CREATE TABLE Associated_With (
    EventID NUMBER,
    FeatureID NUMBER,
    PRIMARY KEY (EventID, FeatureID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (FeatureID) REFERENCES Event_Features (FeatureID)
);


-- "Administrates(UserID: String, EventID: number)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Administrates (
    UserID VARCHAR(20),
    EventId NUMBER,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Admins (UserID)
);

-- "Hosts(UserID: String, EventID: number)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Hosts (
    UserID VARCHAR(20),
    EventId NUMBER,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);

-- "Is Present at(UserID: String, EventID: number, sign in Date/time: timestamp, sign out Data/Time: timestamp)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Is_Present_at (
    UserID VARCHAR(20),
    EventID NUMBER,
    Sign_In TIMESTAMP DEFAULT SYSDATE,
    Sign_Out TIMESTAMP DEFAULT SYSDATE,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID),
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);





