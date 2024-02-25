--DETAILS OF DONOR FIRSTNAME ,LASTNAME WHOSE BLOODGROUP IS AB-

SELECT FirstName,LastName,Age
FROM Donors
WHERE BloodGRoup='AB-'


--Find the names of donors, their blood group,Age, the names of the doctor and helper, and the sub-branch name where the blood group is O+.
SELECT
    d.DonorID,
    d.FirstName AS DonorFirstName,
    d.LastName AS DonorLastName,
    d.BloodGroup AS DonorBloodGroup,
    doc.FirstName AS DoctorFirstName,
    doc.LastName AS DoctorLastName,
    h.FirstName AS HelperFirstName,
    h.LastName AS HelperLastName,
    sb.BranchName AS SubBranchName
FROM
    Donors d
JOIN
    Donor_Branch db ON d.DonorID = db.DonorID
JOIN
    SubBranch sb ON db.SubBranchID = sb.SubBranchID
JOIN
    Doctors_SubBranch dsb ON db.SubBranchID = dsb.SubBranchID
JOIN
    Doctors doc ON dsb.DoctorID = doc.DoctorID
JOIN
    Helpers_Doctors hd ON doc.DoctorID = hd.DoctorID
JOIN
    Helpers h ON hd.HelperID = h.HelperID
WHERE
    d.BloodGroup = 'O+' AND sb.BranchName ='LifeSaver Drive_1';


	--Find all donor names, ages, blood groups, and their assigned doctor names along with the branch they are assigned to.
	SELECT
    d.FirstName AS DonorFirstName,
    d.LastName AS DonorLastName,
    d.Age AS DonorAge,
    d.BloodGroup AS DonorBloodGroup,
    doc.FirstName AS DoctorFirstName,
    doc.LastName AS DoctorLastName,
    sb.BranchName AS AssignedBranch
FROM
    Donors d
JOIN
    Donor_Branch db ON d.DonorID = db.DonorID
JOIN
    SubBranch sb ON db.SubBranchID = sb.SubBranchID
JOIN
    Doctors_SubBranch dsb ON db.SubBranchID = dsb.SubBranchID
JOIN
    Doctors doc ON dsb.DoctorID = doc.DoctorID;


--Find Doctor FirstName,Specialization,Contactnum and their helpers,and their contactnumber in asc order

SELECT 
    doc.FirstName AS DoctorFirstName,
    doc.Specialization,
    doc.ContactNumber AS DoctorContactNumber,
    h.FirstName AS HelperFirstName,
    h.ContactNumber AS HelperContactNumber
FROM 
    Doctors AS doc
INNER JOIN
    Helpers_Doctors AS hd ON doc.DoctorID = hd.DoctorID
INNER JOIN
    Helpers AS h ON hd.HelperID = h.HelperID
ORDER BY
    doc.FirstName ASC;

--Find the total number of donors in each blood group:
SELECT BloodGroup, COUNT(*) AS TotalDonors
FROM Donors
GROUP BY BloodGroup;

--Find the average age of donors for each blood group:
SELECT BloodGroup, AVG(Age) AS AverageAge
FROM Donors
GROUP BY BloodGroup;

--Find the sub-branches with the highest number of donors:
SELECT sb.BranchName, COUNT(*) AS TotalDonors
FROM SubBranch sb
JOIN Donor_Branch db ON sb.SubBranchID = db.SubBranchID
GROUP BY sb.BranchName
ORDER BY TotalDonors DESC;


--Find 5 max age doner name
SELECT TOP 5 * FROM Donors
ORDER BY DonorID DESC;

--Name and Bloodgroup who has rare blood

SELECT FirstName,LastName,BloodGroup
FROM Donors
WHERE BloodGroup NOT IN ('A+', 'B+', 'AB+', 'O+')
ORDER BY DonorID DESC;








