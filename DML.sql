Insert Script:
INSERT INTO Department (DID, Name, Operating_Hours) VALUES
(1, 'Visa Department', '09:00-17:00'),
(2, 'Immigrant Department', '10:00-18:00'),
(3, 'Border Department', '08:00-16:00'),
(4, 'Asylum Department', '11:00-19:00');
INSERT INTO Visa_Department (DID) VALUES (1);
INSERT INTO Immigrant_Department (DID) VALUES (2);
INSERT INTO Border_Department (DID) VALUES (3);
INSERT INTO Asylum_Department (DID) VALUES (4);
INSERT INTO Govt_Employee (E_ID, DOB, Gender, Country, City, E_LastName,
E_FirstName) VALUES
(1001, '1980-05-12', 'Male', 'USA', 'New York', 'Smith', 'John'),
(1002, '1985-08-20', 'Female', 'Canada', 'Toronto', 'Johnson', 'Emily'),
(1003, '1975-12-03', 'Male', 'UK', 'London', 'Brown', 'James');
INSERT INTO Govt_Emp_Email_Info (E_ID, EmailID) VALUES
(1001, 'john.smith@gov.org'),
(1002, 'emily.johnson@gov.ca'),
(1003, 'james.brown@gov.uk');
INSERT INTO Govt_Emp_Contact_Info (E_ID, Phone_Contact) VALUES
(1001, '1234567890'),
(1002, '2234567890'),
(1003, '3234567890');
INSERT INTO Visa_Officer (VisaOfficer_ID, E_ID, DID) VALUES
(501, 1001, 1),
(502, 1002, 1),
(503, 1003, 1);
INSERT INTO Immigrants (Passport_No, Name, Country, City, Gender, DOB) VALUES
('P1001', 'Ali Khan', 'Pakistan', 'Lahore', 'Male', '1990-01-15'),
('P1002', 'Maria Gomez', 'Mexico', 'Monterrey', 'Female', '1988-03-10'),
('P1003', 'Chen Wei', 'China', 'Beijing', 'Male', '1995-06-12'),
('P1004', 'Linda Park', 'South Korea', 'Seoul', 'Female', '1991-09-25');
INSERT INTO Immigrant_Phone_Info (Passport_No, Phone_No) VALUES
('P1001', '03001234567'),
('P1002', '0555123456'),
('P1003', '01098765432'),
('P1004', '01123456789');
INSERT INTO Immigrant_Email_Info (Passport_No, Email_ID) VALUES
('P1001', 'ali.khan@email.com'),
('P1002', 'maria.gomez@email.com'),
('P1003', 'chen.wei@email.com'),
('P1004', 'linda.park@email.com');
INSERT INTO Category (CID, Category_Name, Category_Description, Visa_ID) VALUES
(1, 'Worker', 'Work visa', 201),
(2, 'Student', 'Student visa', 202),
(3, 'Researcher', 'Research visa', 203),
(4, 'Tourist', 'Tourist visa', 204);
INSERT INTO Immigrant_Category (Passport_No, CID) VALUES
('P1001', 1),
('P1002', 2),
('P1003', 3),
('P1004', 4);
INSERT INTO Visa (Visa_ID, Issue_Date, Expiry_Date, Visa_Type, Duration, CID,
Passport_No, Visa_Status, Is_Blacklist, E_ID, VisaOfficer_ID) VALUES
(201, '2023-01-01', '2025-01-01', 'Work', 730, 1, 'P1001', 'Approved', FALSE, 1001, 501),
(202, '2022-09-01', '2024-09-01', 'Student', 730, 2, 'P1002', 'Approved', FALSE, 1002, 502),
(203, '2023-05-01', '2024-05-01', 'Research', 365, 3, 'P1003', 'Approved', FALSE, 1003,
503),
(204, '2024-01-10', '2024-07-10', 'Tourist', 180, 4, 'P1004', 'Approved', FALSE, 1001, 501);
INSERT INTO Sponsors_Employer (Employer_Passport_No, End_Date, Start_Date,
Relationship_Type, Sponsorship_Status) VALUES
('P2001', NULL, '2022-01-01', 'Employment', 'Active'),
('P2002', '2024-12-31', '2023-01-01', 'Employment', 'Expired');
INSERT INTO Sponsors_Employee (Employee_Passport_No, Employee_End_Date,
Employee_Start_Date, Employee_Relationship_Type, Employee_Sponsorship_Status,
Employer_Passport_No) VALUES
('P1001', NULL, '2023-03-01', 'Worker', 'Ongoing', 'P2001'),
('P1003', '2024-06-01', '2023-01-01', 'Researcher', 'Ended', 'P2002');
INSERT INTO Family_Sponsor_Sponsors (Sponsoree_Member_Passport_No,
Relationship_Type, Emergency_Contact, Date_of_Relationship_Establishment,
Financial_Dependency_Status) VALUES
('P1001', 'Parent', '1111111111', '2000-01-01', 'Dependent'),
('P1002', 'Sibling', '2222222222', '2010-01-01', 'Independent');
INSERT INTO Family_Sponsor_Sponoree (Dependents_Passport_Number,
Sponsorers_Member_Passport_No, Relationship_Type, Emergency_Contact,
Date_of_Relationship_Establishment, Financial_Dependency_Status) VALUES
('P3001', 'P1001', 'Child', '9999999999', '2015-05-05', 'Dependent'),
('P3002', 'P1002', 'Brother', '8888888888', '2008-07-10', 'Independent');
INSERT INTO Asylum_Officer (AsylumOfficer_ID, E_ID, Rank, DID) VALUES
(601, 1001, 'Senior', 4),
(602, 1002, 'Junior', 4);
INSERT INTO Asylum_Seeker (CID, Passport_Number, Application_ID, Date_of_Arrival,
Date_of_Departure, Reason_of_Request, Current_Status, Total_Asylum_Seekers,
Number_of_Asylum_Officers_Assigned, Hearing_Date, E_ID, AsylumOfficer_ID) VALUES
(1, 'P1001', 401, '2024-01-01', NULL, 'Persecution', 'Pending', 3, 1, '2024-06-01', 1001, 601),
(2, 'P1002', 402, '2023-05-10', '2023-12-01', 'Violence', 'Closed', 1, 1, '2023-10-01', 1002,
602);
INSERT INTO Request (ApplicationID, Priority_Level, Submission_Date, Requested_For,
Passport_No, CID, DID) VALUES
(5001, 'High', '2024-01-15', 'Visa Renewal', 'P1001', 1, 1),
(5002, 'Medium', '2024-02-20', 'Family Reunification', 'P1002', 2, 4);
