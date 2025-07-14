-- Table Definitions
CREATE TABLE Category (
    CID INT PRIMARY KEY,
    Category_Name VARCHAR(100),
    Category_Description VARCHAR(255),
    Visa_ID INT
);

CREATE TABLE Immigrants (
    Passport_No VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(100),
    City VARCHAR(100),
    Gender VARCHAR(10),
    DOB DATE
);

CREATE TABLE Immigrant_Category (
    Passport_No VARCHAR(50),
    CID INT,
    PRIMARY KEY (Passport_No, CID),
    FOREIGN KEY (CID) REFERENCES Category(CID),
    FOREIGN KEY (Passport_No) REFERENCES Immigrants(Passport_No)
);

CREATE TABLE Visa (
    Visa_ID INT PRIMARY KEY,
    Issue_Date DATE,
    Expiry_Date DATE,
    Visa_Type VARCHAR(100),
    Duration INT,
    CID INT,
    Passport_No VARCHAR(50),
    Visa_Status VARCHAR(100),
    Is_Blacklist BOOLEAN,
    E_ID INT,
    VisaOfficer_ID INT,
    FOREIGN KEY (CID, Passport_No) REFERENCES Immigrant_Category(CID, Passport_No)
);

CREATE TABLE Immigrant_Phone_Info (
    Passport_No VARCHAR(50),
    Phone_No VARCHAR(15),
    PRIMARY KEY (Passport_No, Phone_No),
    FOREIGN KEY (Passport_No) REFERENCES Immigrants(Passport_No)
);

CREATE TABLE Immigrant_Email_Info (
    Passport_No VARCHAR(50),
    Email_ID VARCHAR(100),
    PRIMARY KEY (Passport_No, Email_ID),
    FOREIGN KEY (Passport_No) REFERENCES Immigrants(Passport_No)
);

CREATE TABLE Sponsors_Employer (
    Employer_Passport_No VARCHAR(50) PRIMARY KEY,
    End_Date DATE,
    Start_Date DATE,
    Relationship_Type VARCHAR(100),
    Sponsorship_Status VARCHAR(100)
);

CREATE TABLE Sponsors_Employee (
    Employee_Passport_No VARCHAR(50) PRIMARY KEY,
    Employee_End_Date DATE,
    Employee_Start_Date DATE,
    Employee_Relationship_Type VARCHAR(100),
    Employee_Sponsorship_Status VARCHAR(100),
    Employer_Passport_No VARCHAR(50),
    FOREIGN KEY (Employer_Passport_No) REFERENCES Sponsors_Employer(Employer_Passport_No)
);

CREATE TABLE Family_Sponsor_Sponsors (
    Sponsoree_Member_Passport_No VARCHAR(50) PRIMARY KEY,
    Relationship_Type VARCHAR(100),
    Emergency_Contact VARCHAR(100),
    Date_of_Relationship_Establishment DATE,
    Financial_Dependency_Status VARCHAR(100)
);

CREATE TABLE Family_Sponsor_Sponoree (
    Dependents_Passport_Number VARCHAR(50) PRIMARY KEY,
    Sponsorers_Member_Passport_No VARCHAR(50),
    Relationship_Type VARCHAR(100),
    Emergency_Contact VARCHAR(100),
    Date_of_Relationship_Establishment DATE,
    Financial_Dependency_Status VARCHAR(100),
    FOREIGN KEY (Sponsorers_Member_Passport_No) REFERENCES Family_Sponsor_Sponsors(Sponsoree_Member_Passport_No)
);

CREATE TABLE Department (
    DID INT PRIMARY KEY,
    Name VARCHAR(100),
    Operating_Hours VARCHAR(100)
);

CREATE TABLE Govt_Employee (
    E_ID INT PRIMARY KEY,
    VisaOfficer_ID INT,
    DOB DATE,
    Gender VARCHAR(10),
    Country VARCHAR(100),
    City VARCHAR(100),
    E_LastName VARCHAR(100),
    E_FirstName VARCHAR(100)
);

CREATE TABLE Visa_Department (
    DID INT PRIMARY KEY,
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

CREATE TABLE Immigrant_Department (
    DID INT PRIMARY KEY,
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

CREATE TABLE Border_Department (
    DID INT PRIMARY KEY,
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

CREATE TABLE Asylum_Department (
    DID INT PRIMARY KEY,
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

CREATE TABLE Asylum_Seeker (
    CID INT,
    Passport_Number VARCHAR(50),
    Application_ID INT,
    Date_of_Arrival DATE,
    Date_of_Departure DATE,
    Reason_of_Request VARCHAR(255),
    Current_Status VARCHAR(100),
    Total_Asylum_Seekers INT,
    Number_of_Asylum_Officers_Assigned INT,
    Hearing_Date DATE,
    E_ID INT,
    AsylumOfficer_ID INT,
    PRIMARY KEY (CID, Passport_Number, Application_ID),
    FOREIGN KEY (CID, Passport_Number) REFERENCES Immigrant_Category(CID, Passport_No)
);

CREATE TABLE Request (
    ApplicationID INT PRIMARY KEY,
    Priority_Level VARCHAR(50),
    Submission_Date DATE,
    Requested_For VARCHAR(100),
    Passport_No VARCHAR(50),
    CID INT,
    DID INT,
    FOREIGN KEY (DID) REFERENCES Asylum_Department(DID)
);

CREATE TABLE Govt_Emp_Email_Info (
    E_ID INT,
    EmailID VARCHAR(100),
    PRIMARY KEY (E_ID, EmailID),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Govt_Emp_Contact_Info (
    E_ID INT,
    Phone_Contact VARCHAR(15),
    PRIMARY KEY (E_ID, Phone_Contact),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Visa_Officer (
    VisaOfficer_ID INT,
    E_ID INT,
    DID INT,
    PRIMARY KEY (E_ID, VisaOfficer_ID),
    FOREIGN KEY (DID) REFERENCES Visa_Department(DID),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Immigrant_Officer (
    ImmigrantOfficer_ID INT PRIMARY KEY,
    DID INT,
    E_ID INT,
    FOREIGN KEY (DID) REFERENCES Immigrant_Department(DID),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Border_Officer (
    BorderOfficer_ID INT,
    E_ID INT,
    DID INT,
    PRIMARY KEY (E_ID, BorderOfficer_ID),
    FOREIGN KEY (DID) REFERENCES Border_Department(DID),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Asylum_Officer (
    AsylumOfficer_ID INT,
    E_ID INT,
    Rank VARCHAR(100),
    DID INT,
    PRIMARY KEY (E_ID, AsylumOfficer_ID),
    FOREIGN KEY (DID) REFERENCES Asylum_Department(DID),
    FOREIGN KEY (E_ID) REFERENCES Govt_Employee(E_ID)
);

CREATE TABLE Department_Email_Info (
    DID INT,
    D_EmailID VARCHAR(100),
    PRIMARY KEY (DID, D_EmailID),
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

CREATE TABLE Department_Address_Info (
    DID INT,
    D_Address VARCHAR(255),
    PRIMARY KEY (DID, D_Address),
    FOREIGN KEY (DID) REFERENCES Department(DID)
);

-- Constraints
ALTER TABLE Immigrants
    ALTER COLUMN Gender SET NOT NULL,
    ADD CONSTRAINT gender_check CHECK (Gender IN ('Male', 'Female', 'Other')),
    ALTER COLUMN DOB SET NOT NULL,
    ADD CONSTRAINT dob_check CHECK (DOB <= CURRENT_DATE);

ALTER TABLE Visa
    ADD CONSTRAINT duration_check CHECK (Duration > 0),
    ADD CONSTRAINT date_check CHECK (Expiry_Date > Issue_Date);

ALTER TABLE Sponsors_Employee
    ADD CONSTRAINT employee_date_check CHECK (Employee_End_Date IS NULL OR Employee_End_Date > Employee_Start_Date);

ALTER TABLE Sponsors_Employer
    ADD CONSTRAINT employer_date_check CHECK (End_Date IS NULL OR End_Date > Start_Date);

ALTER TABLE Asylum_Seeker
    ADD CONSTRAINT departure_check CHECK (Date_of_Departure IS NULL OR Date_of_Departure > Date_of_Arrival),
    ADD CONSTRAINT numbers_check CHECK (Total_Asylum_Seekers >= 0 AND Number_of_Asylum_Officers_Assigned >= 0);

ALTER TABLE Govt_Employee
    ALTER COLUMN Gender SET NOT NULL,
    ADD CONSTRAINT gov_gender_check CHECK (Gender IN ('Male', 'Female', 'Other'));
