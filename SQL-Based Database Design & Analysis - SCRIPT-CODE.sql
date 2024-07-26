-- Create the database
CREATE DATABASE IF NOT EXISTS care_hospital;


-- Use the database
USE care_hospital;


-- CREATION OF TABLES
-- Create Patients Table (1)
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    ContactNumber VARCHAR (50),
    CONSTRAINT chk_gender CHECK (Gender IN ('M', 'F', 'O'))
);


-- Create Departments Table (2)
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR (50),
    StaffCount INT NOT NULL
);


-- Create Doctors Table (3)
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR (50),
    Email VARCHAR(30) NOT NULL,
    CONSTRAINT chk_email CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT Doctors_FK1 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


-- Create Appointments Table (4)
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status ENUM('scheduled', 'completed', 'canceled') NOT NULL,
    CONSTRAINT Appointments_FK1 FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT Appointments_FK2 FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


-- Create MedicalRecords Table (5)
CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    DateOfVisit DATE NOT NULL,
    Diagnosis TEXT,
    Prescription TEXT,
    CONSTRAINT MedicalRecords_FK1 FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT MedicalRecords_FK2 FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


-- Create Inventory Table (6)
CREATE TABLE Inventory (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    ItemName VARCHAR(100) NOT NULL,
    Quantity INT CHECK (Quantity >= 0),
    ExpiryDate DATE,
    DepartmentID INT NOT NULL,
    UsageHistory VARCHAR(50),
    CONSTRAINT Inventory_FK1 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);





-- LOADING DATA INTO TABLES
-- Patients Table (1)
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Gender, ContactNumber)
VALUES 
    (101, 'John', 'Smith', '1980-05-15', 'M', '123-456-7890'),
    (102, 'Emily', 'Johnson', '1992-09-20', 'F', '456-789-0123'),
    (103, 'Michael', 'Brown', '1975-03-10', 'M', '789-012-3456'),
    (104, 'Sarah', 'Davis', '1988-11-02', 'F', '234-567-8901'),
    (105, 'David', 'Martinez', '1965-07-25', 'M', '567-890-1234');
    
    
    -- Departments Table (2)
INSERT INTO Departments (DepartmentID, DepartmentName, Location, ContactNumber, StaffCount)
VALUES 
    (201, 'Cardiology', "Main Building, 3rd Floor", '123-456-7890', 15),
    (202, 'Pediatrics', "Children's Wing, 2nd Floor", '456-789-0123', 10),
    (203, 'Orthopedics', "East Wing, 1st Floor", NULL, 12),
    (204, 'Dermatology', "West Wing, 2nd Floor", '234-567-8901', 8),
    (205, 'Neurology', "North Wing, 4th Floor", '567-890-1234', 9);


-- Doctors Table (3)
INSERT INTO Doctors (DoctorID, DepartmentID, FirstName, LastName, Specialty, ContactNumber, Email)
VALUES 
    (301, 201, 'Robert', 'Johnson', 'Cardiologist', '123-456-7890', 'robert.johnson@hc.com'),
    (302, 202, 'Emily', 'Williams', 'Pediatrician', '456-789-0123', 'emily.williams@hc.com'),
    (303, 203, 'Michael', 'Davis', 'Orthopedic Surgeon', '789-012-3456', 'michael.davis@hc.com'),
    (304, 204, 'Sarah', 'Garcia', 'Dermatologist', '234-567-8901', 'sarah.garcia@hc.com'),
    (305, 205, 'David', 'Martinez', 'Neurologist', '567-890-1234', 'david.martinez@hc.com');


-- Appointments Table (4)
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, Status)
VALUES 
    (401, 101, 301, '2024-05-12', '10:00:00', 'scheduled'),
    (402, 102, 302, '2024-05-13', '11:00:00', 'scheduled'),
    (403, 103, 303, '2024-05-14', '12:00:00', 'completed'),
    (404, 104, 304, '2024-05-15', '13:00:00', 'canceled'),
    (405, 105, 305, '2024-05-16', '14:00:00', 'scheduled');


-- MedicalRecords Table (5)
INSERT INTO MedicalRecords (RecordID, PatientID, DoctorID, DateOfVisit, Diagnosis, Prescription)
VALUES 
    (501, 101, 301, '2024-05-12', 'Hypertension', 'Medication A'),
    (502, 102, 302, '2024-05-13', 'Common Cold', 'Rest and Fluids'),
    (503, 103, 303, '2024-05-14', 'Fractured Arm', 'Surgery recommended'),
    (504, 104, 304, '2024-05-15', 'Skin Allergy', 'Topical cream prescribed'),
    (505, 105, 305, '2024-05-16', 'Migraine', 'Pain relievers');


-- Inventory Table (6)
INSERT INTO Inventory (ItemID, ItemName, Quantity, ExpiryDate, DepartmentID, UsageHistory)
VALUES 
    (601, 'Bandages', 200, '2025-12-31', 203, 'Orthopedics'),
    (602, 'Aspirin', 500, '2023-06-30', 201, 'Cardiology'),
    (603, 'Antibiotics', 100, '2024-09-30', 202, 'Pediatrics'),
    (604, 'Anti-Allergics', 50, '2025-03-31', 204, 'Dermatology'),
    (605, 'Apomorphine', 300, '2024-12-31', 205, 'Neurology');



-- QUERY NO. A - INSERT 
-- Add a new appointment for a doctor with DoctorID = 301 
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) 
VALUES (101, 301, '2024-05-17', '15:00:00', 'completed'); 
-- This Query No. A is used to bring visible difference in number of appointments retrieved in descending order in Query No.1. 


-- DATA RETRIEVING QUERIES

-- QUERY NO. 1 - SELECT, CONCAT, COUNT, INNER JOIN, GROUP BY, HAVING, ORDER BY 
-- Get a count of appointments per doctor, only showing those doctors who have appointments, sort by appointment count in descending order:  
SELECT  
CONCAT (Doctors.FirstName, ' ' , Doctors.LastName) AS DoctorName, 
COUNT(Appointments.AppointmentID) AS AppointmentCount 
FROM Appointments 
INNER JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID 
GROUP BY DoctorName 
HAVING AppointmentCount > 0 
ORDER BY AppointmentCount DESC; 


-- QUERY NO. 2: WHERE 
-- Pick a patient who is born after 1980  
SELECT * FROM Patients  
WHERE DateOfBirth > '1980-01-01'; 


-- QUERY NO. 3 - SELECT, INNER JOIN 
-- Get a list of items in the inventory along with their quantities and the department they belong to. 
SELECT ItemName, Quantity, ExpiryDate, DepartmentName 
FROM Inventory 
INNER JOIN Departments ON Inventory.DepartmentID = Departments.DepartmentID; 


-- QUERY NO. 4 - CREATE, VIEW, SELECT, CONCAT, AS, WHERE, AND - MULTITABLE VIEW 
-- Create a view that displays the patient's full name, appointment date and time, doctor's full name, and department name for all scheduled appointments. 
CREATE VIEW Scheduled_Appointments AS 
SELECT CONCAT(Patients.FirstName, ' ' ,Patients.LastName) AS PatientName, 
Appointments.AppointmentDate, Appointments.AppointmentTime,  
CONCAT (Doctors.FirstName, ' ' ,Doctors.LastName) AS DoctorName, Departments.DepartmentName 
FROM Patients,Appointments,Doctors,Departments 
WHERE Departments.DepartmentID = Doctors.DepartmentID 
AND Appointments.DoctorID = Doctors.DoctorID 
AND Appointments.PatientID = Patients.PatientID 
AND Appointments.Status = 'scheduled';  
-- Check Query No 4 
-- Show the details of the view created in Query No. 4 
Select * From Scheduled_Appointments; 


-- QUERY NO. 5: UPDATE, SET, WHERE, SELECT 
-- Update an appointment of a patient using the appointment ID:  
UPDATE Appointments  
SET Status = 'completed'  
WHERE AppointmentID = 401; 
-- Check Query No.5 
SELECT * FROM Appointments; 


-- QUERY NO 6: ALTER 
-- Alter Patients table to add a column:  
ALTER TABLE Patients ADD Column Email VARCHAR(255); 
-- Check Query No.6  
Select * From Patients; 


-- QUERY NO. 7 DROP  
-- Drop an unused column: 
ALTER TABLE Inventory  
DROP COLUMN UsageHistory; 
-- Check Query. 7 
SELECT * FROM Inventory; 


-- QUERY NO. 8 - DELETE, WHERE. 
-- Delete an appointment where appointment ID is 404:  
 DELETE FROM Appointments 
WHERE AppointmentID = 404; 
-- Check Query No. 8 
Select * From Appointments; 


-- QUERY NO. 9 – VIEW, SELECT, JOIN 
-- View for doctor schedules  
CREATE VIEW DoctorSchedules AS 
SELECT Doctors.FirstName AS DoctorFirstName, Doctors.LastName AS DoctorLastName, Doctors.Specialty,  
       Patients.FirstName AS PatientFirstName, Patients.LastName AS PatientLastName,  
       Appointments.AppointmentDate, Appointments.AppointmentTime, Appointments.Status 
FROM Doctors 
JOIN Appointments ON Doctors.DoctorID = Appointments.DoctorID 
JOIN Patients ON Appointments.PatientID = Patients.PatientID; 
-- Check QUERY NO. 9 
SELECT * FROM DoctorSchedules; 


-- QUERY NO. 10 - TRIGGER, IF, THEN, UPDATE, UNION, SET 
-- Implement a trigger that automatically updates the staff count of a department in the Departments table whenever a new doctor is added or removed. 
-- Also use Union to combine two Queries for both insertion and deletion. 
DELIMITER $$ 
CREATE TRIGGER UPDATE_STAFFCOUNT_AFTER_INSERT 
AFTER INSERT ON DOCTORS 
FOR EACH ROW 
BEGIN 
IF NEW.DEPARTMENTID IS NOT NULL THEN 
UPDATE DEPARTMENTS 
SET STAFFCOUNT = STAFFCOUNT + 1  
WHERE DEPARTMENTID = NEW.DEPARTMENTID; 
END IF; 
END; 
$$  
DELIMITER ; 
UNION 
DELIMITER $$ 
CREATE TRIGGER UPDATE_STAFFCOUNT_AFTER_DELETE 
AFTER DELETE ON DOCTORS 
FOR EACH ROW 
BEGIN 
IF OLD.DEPARTMENTID IS NOT NULL THEN 
UPDATE DEPARTMENTS 
SET STAFFCOUNT = STAFFCOUNT - 1  
WHERE DEPARTMENTID = OLD.DEPARTMENTID; 
END IF; 
END; 
$$ 
DELIMITER ; 
-- Check query 10 if the trigger is working  
-- Display staff count first 
SELECT DepartmentID, StaffCount FROM Departments WHERE DepartmentID = 201; 
-- Insert a new doctor into the department with DepartmentID 201 
INSERT INTO Doctors (DepartmentID, FirstName, LastName, Specialty, ContactNumber, Email)  
VALUES (201, 'Test', 'Doctor', 'Test Specialty', '123-456-7890', 'test.doctor@hc.com'); 
-- Check the updated staff count for the department 
SELECT DepartmentID, StaffCount FROM Departments WHERE DepartmentID = 201; 


-- Query No 11 
-- Trigger Logs every time an appointment status is updated, which is helpful for auditing and tracking patient flow.
-- Creating the Log table : AppointmentLog 
CREATE TABLE AppointmentLog ( 
    LogID INT AUTO_INCREMENT PRIMARY KEY, 
    AppointmentID INT, 
    OldStatus ENUM('scheduled', 'completed', 'canceled'), 
    NewStatus ENUM('scheduled', 'completed', 'canceled'), 
    UpdateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 
 -- Trigger to update appointment log when appointment table is updated.  
DELIMITER $$ 
CREATE TRIGGER LogAppointmentUpdate 
AFTER UPDATE ON Appointments 
FOR EACH ROW 
BEGIN 
    IF OLD.Status != NEW.Status THEN 
        INSERT INTO AppointmentLog (AppointmentID, OldStatus, NewStatus) 
        VALUES (OLD.AppointmentID, OLD.Status, NEW.Status); 
    END IF; 
END; 
$$ 
DELIMITER ; 
-- Updating an appointment's status to test the trigger 
SELECT * FROM Appointments ; 
UPDATE Appointments SET Status = 'completed' WHERE AppointmentID = 405; 
UPDATE Appointments SET Status = 'scheduled' WHERE AppointmentID = 405; 
-- Checking query 11 the log to see if the update has been recorded 
SELECT * FROM AppointmentLog; 


-- QUERY NO. 12 
-- Trigger checks inventory levels after an update and logs a warning if the quantity of any item falls below a predefined threshold, aiding in inventory management. 
-- Create the log table  
CREATE TABLE InventoryLog ( 
    LogID INT AUTO_INCREMENT PRIMARY KEY, 
    ItemID INT, 
    Quantity INT, 
    WarningMessage VARCHAR(255), 
    LogTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 
-- Trigger 
DELIMITER $$ 
CREATE TRIGGER CheckInventoryAfterUpdate 
AFTER UPDATE ON Inventory 
FOR EACH ROW 
BEGIN 
    IF NEW.Quantity < 100 THEN 
        INSERT INTO InventoryLog (ItemID, Quantity, WarningMessage) 
        VALUES (NEW.ItemID, NEW.Quantity, CONCAT('Warning: Low inventory for item ID ', NEW.ItemID)); 
    END IF; 
END; 
$$ 
DELIMITER ; 
-- Updating an inventory item to reduce its quantity below the threshold to test the trigger 
UPDATE Inventory SET Quantity = 95 WHERE ItemID = 602; 
UPDATE Inventory SET Quantity = 95 WHERE ItemID = 602; 
-- Check Query 12  - the inventory log to see if the warning has been recorded 
SELECT * FROM InventoryLog; 


-- Check Query No 10, 11 & 12 
Show Triggers;


-- QUERY NO. 13 - UPDATE, SET, WHERE. 
UPDATE MedicalRecords 
SET Diagnosis = 'Fractured Arm (Updated)',  
Prescription = 'Surgery completed, Bed rest recommended' 
WHERE RecordID = 503; 
-- Check QUERY NO. 13 
Select * From MedicalRecords; 


