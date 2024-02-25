---Library Managment System

--CREATE DATABAE
CREATE DATABASE LMS_Project
--CREATE TABLE SUBJECT
CREATE TABLE Subjects(

Subject_ID INT NOT NULL,
Subject_Name VARCHAR(64) NOT NULL,
CONSTRAINT PK_Subjects PRIMARY KEY CLUSTERED ([Subject_ID]ASC)
)
GO

--SHOW TABLE
SELECT*FROM Subjects
--TABLE DEPT
CREATE TABLE Department
(
Dept_ID INT NOT NULL,
Dept_Name VARCHAR NOT NULL
CONSTRAINT PK_Department PRIMARY KEY CLUSTERED ([Dept_ID]ASC)
)
GO

SELECT*FROM  Department
--TABLE BookDetails
CREATE TABLE BookDetails
(
Book_ID INT NOT NULL,
Book_Name VARCHAR(64) NOT NULL,
Author_Name VARCHAR(64) NOT NULL,
Book_Serial_Number VARCHAR (64) NOT NULL,
Subject_ID INT NOT NULL,
Publisher VARCHAR (64) NOT NULL,
Price INT NOT NULL,
 CONSTRAINT [PK_BookDetails] PRIMARY KEY CLUSTERED ([Book_ID] ASC)
)
GO

ALTER TABLE dbo.BookDetails  WITH CHECK 
ADD  CONSTRAINT FK_BookDetails_subjects_Subject_ID FOREIGN KEY([Subject_ID])
REFERENCES dbo.Subjects ([Subject_ID])
GO

SELECT*FROM BookDetails
--TABLE BorrowerDetails
CREATE TABLE BorrowerDetails
(
Borrower_ID INT NOT NULL,
Borrower_Name VARCHAR(64) NOT NULL,
Borrower_Contact INT NOT NULL,
Dept_ID INT NOT NULL,
Address VARCHAR(64)NOT NULL,
CONSTRAINT [PK_BorrowerDetails] PRIMARY KEY CLUSTERED ([Borrower_ID] ASC)
)
SELECT*FROM BorrowerDetails

ALTER TABLE dbo.BorrowerDetails  WITH CHECK 
ADD  CONSTRAINT FK_Borrowerdetails_Department_Dept_ID FOREIGN KEY(Dept_ID)
REFERENCES dbo.Department ([Dept_ID])
GO
--TABLE BookBorrowed
CREATE TABLE BookBorrowed
(
Book_Borrowed_ID INT NOT NULL,
Book_ID INT NOT NULL,
Borrower_ID INT NOT NULL,
Borrowed_On DATETIME NOT NULL,
Due_Date DATETIME NOT NULL,
Number_Of_Copies INT NOT NULL,
Return_Status VARCHAR (3)NOT NULL
CONSTRAINT [PK_BookBorrowed] PRIMARY KEY CLUSTERED ([Book_Borrowed_ID] ASC)
) ON [PRIMARY]
GO
SELECT*FROM BookBorrowed

ALTER TABLE dbo.BookBorrowed  WITH CHECK ADD  CONSTRAINT FK_Bookborrowed_BookDetails_Book_ID FOREIGN KEY([Book_ID])
REFERENCES dbo.BookDetails ([Book_ID])
GO
ALTER TABLE dbo.BookBorrowed  WITH CHECK ADD  CONSTRAINT FK_Bookborrowed_Borrowerdetails_Borrower_ID FOREIGN KEY([Borrower_ID])
REFERENCES dbo.BorrowerDetails ([Borrower_ID])
GO

--after inserting value
SELECT * FROM Subjects;
SELECT * FROM Department
SELECT*FROM BookDetails
SELECT*FROM BorrowerDetails
SELECT*FROM BookBorrowed

-- create a report/view to see bookname, authorname, subjectname and price
-- we have to create a view and save our select statement in the view
-- so that librarian can simply call the view and see the report details
CREATE VIEW BookReport
AS
SELECT B.Book_Name, B.Author_Name, S.Subject_Name, B.Price
FROM BookDetails AS B
INNER JOIN Subjects AS S ON B.Subject_ID = S.Subject_ID
--to show the view
SELECT * FROM BookReport;
-- create a report/view to see Borrowername, BorrowerContact, DepartmentName and Address
-- we have to create a view and save our select statement in the view
-- so that librarian can simply call the view and see the report details
CREATE VIEW BorrowerReport
AS
SELECT Br.Borrower_Name,Br.Borrower_Contact,D.Dept_Name,Br.Address
FROM Department AS D INNER JOIN BorrowerDetails AS Br
ON D.Dept_ID=Br.Dept_ID

SELECT * FROM BorrowerReport

-- create a report/view to see borrowd book details: BookName, BorrowerName, 
-- BorrowerContact, AuthorName, BorrowedOn, DueDate
-- we have to create a view and save our select statement in the view
-- so that librarian can simply call the view and see the report details
CREATE VIEW BorrowedBookReport
AS
SELECT B.Book_Name, Br.Borrower_Name, Br.Borrower_Contact, B.Author_Name, BB.Borrowed_On, BB.Due_Date
FROM BookDetails AS B
INNER JOIN BookBorrowed AS BB ON B.Book_ID = BB.Book_ID
INNER JOIN BorrowerDetails AS Br ON BB.Borrower_ID = Br.Borrower_ID
WHERE BB.Return_Status = 'Yes';
SELECT*FROM BorrowedBookReport

-- Create a Stored Procedure to borrow a book (Add a entry to BookBorrowed table)
-- BookName, BorrowerName
CREATE PROCEDURE BorrowNewBook
@BookName Varchar(32),
@BorrowerName Varchar(32)
AS
BEGIN
	declare @B_id int = NULL , @Br_id int = NULL, @BB_id int = 1
	select @BB_id = max(Book_Borrowed_ID)+1 from BookBorrowed
	IF  EXISTS (select * from BookDetails where Book_Name = @BookName)
	BEGIN
		Print 'Book does not exist in the library: ' + @BookName
	END
	ELSE
	BEGIN
		select @B_id = Book_ID from BookDetails where Book_Name = @BookName
	END
	IF NOT EXISTS (select * from BorrowerDetails where Borrower_Name = @BorrowerName)
	BEGIN
		Print 'Not a member of the library: ' + @BorrowerName
	END
	ELSE
	BEGIN
		select @Br_id = Borrower_ID from BorrowerDetails where Borrower_Name = @BorrowerName
	END
	IF (@B_id IS NOT NULL) AND (@Br_id IS NOT NULL)
	BEGIN
		INSERT INTO BookBorrowed (Book_Borrowed_ID, Book_ID, Borrower_ID, Borrowed_On, Due_Date, Number_Of_Copies, Return_Status)
		Values(@BB_id, @B_id, @Br_id, getdate(), dateadd(day, 3, getdate()), 1, 'No')
	END
	else
	begin
		Print 'Validation error... Hence book can not be borrowed...'
	end
END

-- please write a procedure for returning a book
-- validate the borrower name, book name and find the book borrowed ID
-- If book submitted after due date, ask for penalty and update returnstatus
-- If book submitted before due date then no penalty and update returnstatus
create procedure ReturnBook
@BookName Varchar(32),
@BorrowerName Varchar(32)
AS
BEGIN
	declare @B_id int = NULL , @Br_id int = NULL, @BB_id int = 1, @DueDate datetime 
	select @B_id = Book_ID from BookDetails where Book_Name = @BookName
	select @Br_id = Borrower_ID from BorrowerDetails where Borrower_Name = @BorrowerName
	select @BB_id = Book_Borrowed_ID from BookBorrowed where Book_ID = @B_id AND Borrower_ID = @Br_id
	select @DueDate = Due_Date from BookBorrowed where Book_Borrowed_ID = @BB_id

	if (@duedate<getdate())
	begin
		print 'Due date is over - applicable penalty' 
		update BookBorrowed set Return_Status = 'Yes' where Book_Borrowed_ID = @BB_id
	end
	else
		begin
		print 'Returned within due date - No penalty' 
		update BookBorrowed set Return_Status = 'Yes' where Book_Borrowed_ID = @BB_id
	end
END


