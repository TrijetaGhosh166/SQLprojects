CREATE DATABASE BDC;

--information about blood donors

CREATE TABLE Donors (
    DonorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BloodGroup VARCHAR(5),
    Age INT,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);
INSERT INTO Donors (DonorID, FirstName, LastName, BloodGroup, Age, Gender, ContactNumber, Email, Address)
VALUES
(1, 'Rahul', 'Gupta', 'O+', 35, 'Male', '9876543210', 'rahul@example.com', '123 Main St, New Delhi'),
(2, 'Priya', 'Sharma', 'A-', 28, 'Female', '9876543211', 'priya@example.com', '456 Park Ave, Mumbai'),
(3, 'Amit', 'Patel', 'B+', 45, 'Male', '9876543212', 'amit@example.com', '789 Elm St, Kolkata'),
(4, 'Sneha', 'Singh', 'AB+', 22, 'Female', '9876543213', 'sneha@example.com', '101 Oak St, Bangalore'),
(5, 'Ravi', 'Joshi', 'O-', 31, 'Male', '9876543214', 'ravi@example.com', '222 Pine St, Chennai'),
(6, 'Anita', 'Kumar', 'A+', 40, 'Female', '9876543215', 'anita@example.com', '333 Cedar St, Hyderabad'),
(7, 'Raj', 'Verma', 'B-', 29, 'Male', '9876543216', 'raj@example.com', '444 Maple St, Pune'),
(8, 'Neha', 'Agarwal', 'AB-', 37, 'Female', '9876543217', 'neha@example.com', '555 Birch St, Jaipur'),
(9, 'Vikas', 'Yadav', 'O+', 25, 'Male', '9876543218', 'vikas@example.com', '666 Elm St, Ahmedabad'),
(10, 'Pooja', 'Das', 'A-', 33, 'Female', '9876543219', 'pooja@example.com', '777 Oak St, Surat'),
(11, 'Rahul', 'Shah', 'B+', 27, 'Male', '9876543220', 'rahul2@example.com', '888 Maple St, Lucknow'),
(12, 'Sunita', 'Rao', 'AB+', 39, 'Female', '9876543221', 'sunita@example.com', '999 Pine St, Chandigarh'),
(13, 'Amit', 'Singh', 'O-', 32, 'Male', '9876543222', 'amit2@example.com', '123 Cedar St, Patna'),
(14, 'Divya', 'Mishra', 'A+', 36, 'Female', '9876543223', 'divya@example.com', '456 Birch St, Nagpur'),
(15, 'Manoj', 'Gandhi', 'B-', 41, 'Male', '9876543224', 'manoj@example.com', '789 Maple St, Indore'),
(16, 'Shweta', 'Thakur', 'AB-', 24, 'Female', '9876543225', 'shweta@example.com', '101 Pine St, Varanasi'),
(17, 'Rajesh', 'Khan', 'O+', 30, 'Male', '9876543226', 'rajesh@example.com', '222 Cedar St, Bhopal'),
(18, 'Preeti', 'Sharma', 'A-', 26, 'Female', '9876543227', 'preeti@example.com', '333 Birch St, Ludhiana'),
(19, 'Vivek', 'Reddy', 'B+', 38, 'Male', '9876543228', 'vivek@example.com', '444 Maple St, Coimbatore'),
(20, 'Anjali', 'Rajput', 'AB+', 23, 'Female', '9876543229', 'anjali@example.com', '555 Oak St, Amritsar');


-- Table for Main Branches
CREATE TABLE MainBranch (
    MainBranchID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(255),
    ContactNumber VARCHAR(15)
);
INSERT INTO MainBranch (MainBranchID, Name, Location, ContactNumber)
VALUES (1, 'LifeSaver Drive', 'Kolkata', '033-654-2747');



-- Table for Helpers (Compounders, Volunteers, etc.)
CREATE TABLE Helpers (
    HelperID INT PRIMARY KEY,
    MainBranchID INT,
    FirstName VARCHAR(10),
	LastName VARCHAR(10),
    Role VARCHAR(100),
    ContactNumber VARCHAR(15),
    FOREIGN KEY (MainBranchID) REFERENCES MainBranch(MainBranchID)
);


INSERT INTO Helpers (HelperID, MainBranchID, FirstName, LastName, Role, ContactNumber)
VALUES 
(1, 1, 'Rajesh', 'Patel', 'Compounder', '9876543210'),
(2, 1, 'Neha', 'Sharma', 'Volunteer', '9876543211'),
(3, 1, 'Ramesh', 'Singh', 'Nurse', '9876543212'),
(4, 1, 'Priya', 'Gupta', 'Volunteer', '9876543213'),
(5, 1, 'Sanjay', 'Kumar', 'Compounder', '9876543214');

SELECT *FROM Helpers

--Doctor details

-- Creating the table for doctor details
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(100),
    ContactNumber VARCHAR(15)
);
 
INSERT INTO Doctors VALUES 
(1, 'Dr. Manoj', 'Sharma', 'Hematologist (Blood Cancer)', '9876543220'),
(2, 'Dr. Priyanka', 'Verma', 'Endocrinologist (Diabetes)', '9876543221'),
(3, 'Dr. Rahul', 'Singh', 'Cardiovascular Hematologist', '9876543222'),
(4, 'Dr. Sneha', 'Patil', 'Hematologist (Thrombophilia)', '9876543223'),
(5, 'Dr. Rohan', 'Mehta', 'Hematologist (Hemophilia)', '9876543224'),
(6, 'Dr. Nisha', 'Gupta', 'Endocrinologist (Thyroid Disorders)', '9876543225');
SELECT * FROM Donors;
SELECT*FROM MainBranch;
SELECT *FROM Helpers;
SELECT*FROM Doctors;



