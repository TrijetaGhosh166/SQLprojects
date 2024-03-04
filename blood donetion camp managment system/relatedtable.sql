CREATE TABLE SubBranch (
    SubBranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    Location VARCHAR(255)
);
-- Inserting data into the SubBranch table
INSERT INTO SubBranch (SubBranchID, BranchName, Location)
VALUES 
(1, 'LifeSaver Drive_1', 'Howrah'),
(2, 'LifeSaver Drive_2', 'Salt Lake City'),
(3, 'LifeSaver Drive_3', 'New Town');
-- Add new column HelperContactNumber to Doctors_SubBranch table
ALTER TABLE SubBranch
ADD HelperContactNumber VARCHAR(15);
UPDATE SubBranch
SET HelperContactNumber = '9876543210'
WHERE SubBranchID = 1;

UPDATE SubBranch
SET HelperContactNumber = '9876543211' 
WHERE SubBranchID = 2;

UPDATE SubBranch
SET HelperContactNumber = '9876543212' 
WHERE SubBranchID = 3;

-- Creating the table for doctors assigned to sub-branches
CREATE TABLE Doctors_SubBranch (
    DoctorID INT,
    SubBranchID INT,
    PRIMARY KEY (DoctorID, SubBranchID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SubBranchID) REFERENCES SubBranch(SubBranchID)
);

-- Inserting data into the Doctors_SubBranch table
INSERT INTO Doctors_SubBranch (DoctorID, SubBranchID)
VALUES 
(1, 2), -- Doctor 1 assigned to SubBranch A
(2, 1), -- Doctor 2 assigned to SubBranch A
(3, 1), -- Doctor 3 assigned to SubBranch B
(4, 2), -- Doctor 4 assigned to SubBranch B
(5, 3), -- Doctor 5 assigned to SubBranch C
(6, 3); -- Doctor 6 assigned to SubBranch C

-- Creating the table for helpers assigned to doctors
CREATE TABLE Helpers_Doctors (
    HelperID INT PRIMARY KEY,
    DoctorID INT,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Inserting data into the Helpers_Doctors table
INSERT INTO Helpers_Doctors (HelperID, DoctorID)
VALUES 
(1, 2), -- Helper 1 assigned to Doctor 1
(2, 1), -- Helper 2 assigned to Doctor 2
(3, 3), -- Helper 3 assigned to Doctor 3
(4, 4), -- Helper 4 assigned to Doctor 4
(5, 5), -- Helper 5 assigned to Doctor 5
(6, 6); -- Helper 6 assigned to Doctor 6

-- Creating the Donor_Branch table
CREATE TABLE Donor_Branch (
    DonorID INT,
    SubBranchID INT,
    PRIMARY KEY (DonorID, SubBranchID),
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID),
    FOREIGN KEY (SubBranchID) REFERENCES SubBranch(SubBranchID)
);
-- Inserting values into the Donor_Branch table
INSERT INTO Donor_Branch (DonorID, SubBranchID)
VALUES 
(1, 1), -- Donor 1 assigned to SubBranch 1
(2, 1), -- Donor 2 assigned to SubBranch 1
(3, 1), -- Donor 3 assigned to SubBranch 1
(4, 2), -- Donor 4 assigned to SubBranch 2
(5, 2), -- Donor 5 assigned to SubBranch 2
(6, 2), -- Donor 6 assigned to SubBranch 2
(7, 3), -- Donor 7 assigned to SubBranch 3
(8, 3), -- Donor 8 assigned to SubBranch 3
(9, 3); -- Donor 9 assigned to SubBranch 3


SELECT*FROM SubBranch;
SELECT* FROM Doctors_SubBranch;
SELECT*FROM Helpers_Doctors;
SELECT*FROM Donor_Branch;