--DROP Tables

--Foreign Key
DROP TABLE if exists Is_Present_at ;
DROP TABLE if exists Uses ;
DROP TABLE if exists Administrates ;
DROP TABLE if exists Hosts ;
DROP TABLE if exists Event_Hosts ;
DROP TABLE if exists Admins ;
DROP TABLE if exists Satisfies ;
--DROP TABLE Subtask_of;
DROP TABLE if exists Is_Contacted ;
--DROP TABLE Assigned_Tasks;
--DROP TABLE Completed_Tasks;
DROP TABLE if exists Business_Contacts;
DROP TABLE if exists Associated_With ;
DROP TABLE if exists Tasks ;
DROP TABLE if exists Features ;
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
DROP TABLE if exists Event_Features ;

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
    UserID VARCHAR(50) PRIMARY KEY,
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
    TypeID integer PRIMARY KEY DEFAULT NEXTVAL('Task_Type_seq'),
    Type_Name VARCHAR(30)
);


-- "Feature Inventory(ItemID: integer, Name: String, Quantity: integer,
--  availablity start: time, avaiablity end: time)
-- Primary Key: ItemID
-- No Candidate Key
-- No Foreign Key"


CREATE SEQUENCE Feature_Inventory_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Feature_Inventory (
    ItemID integer Primary KEY DEFAULT NEXTVAL('Feature_Inventory_seq'),
    Item_Name VARCHAR(50),
    Quantity INTEGER,
    Available_Start Time,
    Available_End Time
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
    CompanyID integer PRIMARY KEY DEFAULT NEXTVAL('Company_seq'),
    Comapny_Name VARCHAR(50),
    Street_Address VARCHAR(50),
    City VARCHAR(30),
    State VARCHAR(30),
    ZipCode CHAR(5),
    Description VARCHAR(100)
);

-- "Caterer(CompanyID: integer, Food Type: String)
-- Primary Key: CompanyID
-- No Candidate Key
-- Foriegn Key: CompanyID"

CREATE TABLE Caterer (
    CompanyID integer, 
    Cuisine_type VARCHAR(30), 
    PRIMARY Key (CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

-- "Vendor(CompanyID: integer, Service: String) 
-- Primary Key: CompanyID
-- No Candidate Key
-- Foriegn Key: CompanyID"

CREATE TABLE Vendor (
    CompanyID integer, 
    Equipment_type VARCHAR(50), 
    PRIMARY Key (CompanyID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

-- "Business_Contacts(ContactID: integer, First_Name: String, Last_name: String, Phone: String,
--  Email: String, Job Title: String, CompanuID: integer,  availabilyt start: time, avaiablity end: time)
-- Primary Key: ContactID
-- Candidate Key: email
-- Foreign Key: CompanyID"

CREATE SEQUENCE Business_Contacts_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Business_Contacts (
    ContactID INTEGER PRIMARY KEY DEFAULT NEXTVAL('Business_Contacts_seq'),
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Phone CHAR(10),
    Email VARCHAR(50) UNIQUE,
    Job_Title VARCHAR(30),
    CompanyID integer,
    Available_Start Time,
    Available_End Time,
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

-- "Features(FeatureID: integer, Name: String, Description: String, )
-- Primary Key: FeatureID
-- No Candidate Key
-- No Forieng Key"


CREATE SEQUENCE Event_Feature_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

Create TABLE Features (
    FeatureID integer Primary KEY DEFAULT NEXTVAL(' Event_Feature_seq'),
    Feature_Name VARCHAR(30),
    Description VARCHAR(100)
    );

-- "Tasks(TaskId: integer, Name: String, Duedate: Date, FeatureID: integer, 
-- Description: String, TypeID: integer, Assigned By: string,  
-- Assigned to: string, Assigned Date/Time: Date, Completed By: string, 
-- Completed Date/Time: Date, Parent Task TaskID, integer)
-- Primary Key: TaskID
-- No Cnadidate Key
-- Foriegn Key: TypeID, Assigned By, Assigned To, Parent Task TaskID"


CREATE SEQUENCE Task_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Tasks (
    TaskID integer PRIMARY KEY DEFAULT NEXTVAL('Task_seq'),
    Task_Name VARCHAR(50),
    Assigned_by_UserID VARCHAR(50) NOT NULL,
    Assigned_to_UserID VARCHAR(50) NOT NULL,
    Duedate TIMESTAMP,
    Notes VARCHAR(250),
    Description VARCHAR(250),
    TypeID integer,
    Assigned_Date_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Completed_Date_Time TIMESTAMP,
    ParentTaskID integer, 
    FOREIGN KEY (Assigned_by_UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (Assigned_to_UserID) REFERENCES USERS (UserID),
    FOREIGN KEY (TypeID) REFERENCES Task_Type (TypeID),
    Foreign Key (ParentTaskID) References Tasks (TaskID)
    -- FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID)
);

-- "Is Contacted For(FeatureID: integer, ContactID: Integer)
-- Primary Key: (FeatureID)
-- No Candidate Key
-- Foriegn Key: FeatureID, ContactID"


CREATE TABLE Is_Contacted (
    FeatureID integer,
    ContactID integer,
    PRIMARY KEY (FeatureID, ContactID),
    FOREIGN KEY (FeatureID) REFERENCES Features (FeatureID),  
    FOREIGN KEY (ContactID) REFERENCES Business_Contacts (ContactID)
);

-- "USes(FeatureID: integer, ItemID: Integer)
-- Primary Key: (FeatureID)
-- No Candidate Key
-- Foriegn Key: FeatureID, ItemID"

CREATE TABLE Uses (
    FeatureID integer,
    ItemID integer,
    PRIMARY KEY (FeatureID, ItemID),
    FOREIGN KEY (FeatureID) REFERENCES features (FeatureID),  
    FOREIGN KEY (ItemID) REFERENCES Feature_Inventory (ItemID)
);

-- "Satisfies(TaskID: integer, FeatureID: integer, quantity)
-- Primary Key: (TaskID, FeatureID)
-- No Candidate Key
-- Foriegn Key: TaskID, FeatureID"
CREATE TABLE Satisfies (
    TaskID integer,
    FeatureID integer,
    Quantity integer,
    PRIMARY KEY (TaskID, FeatureID),
    FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID) on delete cascade,
    FOREIGN KEY (FeatureID) REFERENCES Features (FeatureID)
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
    Event_TypeID integer PRIMARY KEY DEFAULT NEXTVAL('Event_Type_seq'),
    Event_Type_Name VARCHAR(50)
);


-- "Location Type(Location Type ID: integer, Name: String, 
-- availabilyt start: time, avaiablity end: time)
-- Primary Key: Location TypeID
-- No Candidate Key
-- No Foriegn Key"

CREATE SEQUENCE Location_Type_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Location_types (
    Location_typeID integer Primary KEY DEFAULT NEXTVAL('Location_Type_seq'),
    Loc_Type_Name VARCHAR(50),
    Available_Start Time,
    Available_End Time
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
    LocID integer PRIMARY KEY DEFAULT NEXTVAL('Location_seq'),
    Location_Name VARCHAR(50),
    DESCRIPTION Varchar(100),
    Capacity INTEGER,
    Location_typeID integer,
    FOREIGN KEY (Location_typeID) REFERENCES Location_types (Location_typeID)
);

-- "Events(EventID: integer, Name: String, Number of Attendees: integer, 
-- Start Date/Time: timestamp, end Date/Time: timestamp, Event TypeID: integer, 
-- LocID: integer, Description: String, status: String)
-- Primary Key: EventID
-- No Candidate Key
-- Foriegn Key: Event Type ID, LocID"

CREATE SEQUENCE Event_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ;

CREATE TABLE Events (
    EventID integer PRIMARY KEY DEFAULT NEXTVAL('Event_seq'),
    Event_Name VARCHAR(50),
    Attendees_count INTEGER,
    Start_Time_Date TIMESTAMP,
    End_Time_Date TIMESTAMP,
    Event_TypeID integer,
    Event_Status VARCHAR(20) Default 'active',
    LocID integer,
    DESCRIPTION VARCHAR(250),
    FOREIGN KEY (Event_TypeID) REFERENCES Event_Types (Event_TypeID),
    FOREIGN KEY (LocID) REFERENCES Locations (LocID)
);

-- "Associated_With(EventID: integer, TaskID: integer)
-- Primary key: (EventID, FeatureID)
-- No Candidate Key
-- Foriegn Key: EventID, Feature ID"
CREATE TABLE Associated_With (
    EventID integer ,
    TaskID integer ,
    PRIMARY KEY (EventID, TaskID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID) on delete cascade,
    FOREIGN KEY (TaskID) REFERENCES Tasks (TaskID)on delete cascade
);


-- "Administrates(UserID: String, EventID: integer)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Administrates (
    UserID VARCHAR(20),
    EventId integer,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID) on delete cascade,
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
    FOREIGN KEY (EventID) REFERENCES Events (EventID) on delete cascade,
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);

-- "Is Present at(UserID: String, EventID: integer, sign in Date/time: timestamp, sign out Data/Time: timestamp)
-- Primary Key: (UserID, EventID)
-- No Candidate Key
-- Foriegn Key: UserID, EventID"
CREATE TABLE Is_Present_at (
    UserID VARCHAR(20),
    EventID integer,
    Sign_In TIMESTAMP,
    Sign_Out TIMESTAMP ,
    PRIMARY Key (UserID, EventID),
    FOREIGN KEY (EventID) REFERENCES Events (EventID) on delete cascade,
    FOREIGN KEY (UserID) REFERENCES Event_Hosts (UserID)
);





