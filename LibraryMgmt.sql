CREATE DATABASE 

USE Libraries

CREATE TABLE Library_Branch (
	BranchID INT PRIMARY KEY Not Null IDENTITY (1,1),
	BranchName VARCHAR(30) Not Null,
	Address VARCHAR(50) Not Null
);
INSERT INTO Library_Branch
	(BranchName, Address)
	VALUES
	('Sharpstown', '45 Sharpstown Road'),
	('Central', '6400 Lyons Street'),
	('Mt. Rosalie', '9432 Mountain Trail Lane'),
	('Garnet Springs','1 Garnet Steet')
;
CREATE TABLE Publisher (
	PublisherName VARCHAR(35) PRIMARY KEY Not Null,
	Address VARCHAR(50) Not Null,
	Phone VARCHAR(15) Not Null
)
INSERT INTO Publisher
	(PublisherName, Address, Phone)
	VALUES
	('Bloody Books', '20 Pennywise Road', '303-555-9900'),
	('UK Publishing', '30 Diagon Alley', '434-222-4444'),
	('Love and Such Publishing', '2005 Romantic Lane', '619-555-0032'),
	('Penguin Kids', '56 Playtime Place', '240-542-5542'),
	('Baker & Smith', '4655 Knoll Lane', '654-765-9012')
;
CREATE TABLE Books (
	BookId INT PRIMARY KEY Not Null IDENTITY (100,5),
	Title VARCHAR (40) Not Null,
	PublisherName VARCHAR(35) Not Null CONSTRAINT fk_Pub_Name 
	FOREIGN KEY REFERENCES Publisher (PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);
 
INSERT INTO Books
	(Title, PublisherName)
	VALUES
	('The Lost Tribe', 'Baker & Smith'),
	('It', 'Bloody Books'),
	('The Jungle Book', 'Penguin Kids'),
	('Harry Potter & the Chamber of Secrets', 'UK Publishing'),
	('The Shining', 'Bloody Books'),
	('The Client', 'Love and Such Publishing'),
	('A Million Little Pieces', 'Baker & Smith'),
	('The Little Prince', 'Penguin Kids'),
	('Life of Pi', 'Penguin Kids'),
	('Infinite Love', 'Love and Such Publishing'),
	('Peanuts', 'Penguin Kids'),
	('Into the Abyss', 'Baker & Smith'),
	('Wild', 'Love and Such Publishing'),
	('Space and Stars', 'Penguin Kids'),
	('Charlottetown Manor','Bloody Books'),
	('Carrie', 'Bloody Books'),
	('The Beginning', 'UK Publishing'),
	('Eat, Love, Pray', 'Love and Such Publishing'),
	('The Jester', 'Baker & Smith'),
	('Queen of Hearts', 'UK Publishing'),
	('Computer Programming for Dummies', 'Baker & Smith'),
	('Coding for Kids', 'Penguin Kids')
;
CREATE TABLE Book_Authors (
	BookID INT Not Null CONSTRAINT fk_book_id
	FOREIGN KEY REFERENCES Books (BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	AuthorName VARCHAR(30) Not Null
);

INSERT INTO Book_Authors 
	(BookID,AuthorName)
	VALUES
	(100, 'Marcia Brady'),
	(105, 'Stephen King'),
	(110, 'Rudyard Kipling'),
	(115, 'J.K. Rowling'),
	(120, 'Stephen King'),
	(125, 'John Grisham'),
	(130, 'James Frey'),
	(135, 'Antoine de Saint-Exupéry'),
	(140, 'Yann Martel'),
	(145, 'Julie Jacobson'),
	(150, 'Cornell J. Paul'),
	(155, 'Leighton Smith'),
	(160, 'Cheryl Strayed'),
	(165, 'Dr. Authur Blimpski'),
	(170, 'Jerry Dupois'),
	(175, 'Stephen King'),
	(180, 'Adam Tyler'),
	(185, 'Elizabeth Gilbert'),
	(190, 'Donald Lee Cook'),
	(195, 'Morgan Dugan'),
	(200, 'Brian McCulley'),
	(205, 'Alix Fullerton')
;
CREATE TABLE Book_Copies (
	BookID INT Not Null CONSTRAINT fk_BookCopyID
	FOREIGN KEY REFERENCES Books (BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT Not Null CONSTRAINT fk_branchCopy_id
	FOREIGN KEY REFERENCES Library_Branch (BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	Number_Of_Copies INT Not Null
)

INSERT INTO Book_Copies
(BookID, BranchID, Number_Of_Copies)
VALUES
(100, 1, 5),(105, 1, 2),(115, 1, 3),(180, 1, 6),(190, 1, 2),
(165, 1, 4),(150, 1, 5),(160, 1, 2),(120, 1, 2),(175, 1, 5),


(120, 2, 4),(100, 2, 5),(115, 2, 6),(125, 2, 3),(115, 2, 4),(105,2, 5),(135, 2, 5),
(100, 2, 2), (130, 2, 5),(140, 2, 4),(150, 2, 3),(155, 2, 5),(145, 2, 4),

(160, 3, 6),(170, 3, 3),(200, 3, 3),(195, 3, 4),(175, 3, 2),(110, 3, 4),
(115, 3, 5),(115, 3, 4),(155, 3, 5),(135, 3, 5),(125, 3, 5),(130, 3, 5),(165, 3, 5),

(110, 4, 5),(115, 4, 6),(200, 4, 5), (100,4, 5),(175, 4, 3),(105, 4, 3),
(185, 4, 5),(165, 4, 7),(155, 4, 5), (105,4, 5), (110, 4, 5)
;
DELETE FROM Book_Copies WHERE BookID = 115 AND BranchID = 2 AND Number_Of_Copies = 4
CREATE TABLE Borrower (
	CardNo INT PRIMARY KEY Not null IDENTITY (1000,1),
	Name VARCHAR(30) Not Null,
	Address VARCHAR(35) Not Null,
	Phone VARCHAR(15) Not Null
);
INSERT INTO Borrower
	(Name, Address, Phone)
	VALUES
	('Leslie Kleeb', '280 Chestnut Street', '720-546-3211'),
	('Alex Gibson','14363 East Hawaii Circle','720-257-4315'),
	('Martina Thomas', '2893 South Locust Street','303-683-5596'),
	('Caitlin Edwards', '32 Miscomite Drive', '720-456-9876'),
	('Dan Owens', '877 Pennsylvania Point', '970-233-0988'),
	('Lindsey Mash', '34 Main Street', '303-544-2233'),
	('Kaylin Delmonte','8798 Samson Road','303-559-3321'),
	('Ashton Ketchem','5255 Pokemon Drive','970-255-0011'),
	('Val Smith','55 North Mill Lane','303-555-3252')
;

CREATE TABLE Book_Loans (
	BookID INT Not Null CONSTRAINT fk_BookLoanID
	FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT Not Null CONSTRAINT fk_BranchLoanID FOREIGN KEY REFERENCES Library_Branch(BranchID),
	CardNo INT Not Null CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES Borrower(CardNo),
	DateOut DATETIME Not Null,
	DateDue DATETIME Not Null
);
SELECT BranchId FROM Library_Branch
INSERT INTO Book_Loans
(BookID, BranchID, CardNo, DateOut, DateDue)
VALUES
(100, 1, 1000, '2018-11-25', '2018-11-30'),
(120, 1, 1005, '2018-11-23', '2018-11-28'),
(160, 1, 1000, '2018-11-25', '2018-11-30'),
(180, 1, 1005, '2018-11-15', '2018-11-24'),
(190, 1, 1000, '2018-11-25', '2018-11-30'),
(120, 1, 1000, '2018-11-25', '2018-11-30'),
(175, 1, 1005, '2018-11-15', '2018-11-24'),
(175, 1, 1006, '2018-11-11', '2018-12-01'),
(175, 1, 1002, '2018-11-09', '2018-11-29'),
(165, 1, 1004, '2018-11-10', '2019-11-21'),
(180, 1, 1002, '2018-11-09', '2018-11-29'),
(190, 1, 1001, '2018-11-05', '2018-11-15'),
(120, 1, 1006, '2018-11-16', '2018-11-29'),


(105, 2, 1001, '2018-11-14', '2018-11-19'),
(135, 2, 1001, '2018-11-14', '2018-11-30'),
(140, 2, 1001, '2018-11-14', '2018-11-30'),
(145, 2, 1001, '2018-11-14', '2018-11-30'),
(150, 2, 1001, '2018-11-14', '2018-11-30'),
(125, 2, 1006, '2018-11-20', '2018-11-25'),
(100, 2, 1006, '2018-11-20', '2018-11-25'),
(115, 2, 1006, '2018-11-20', '2018-11-25'),
(140, 2, 1007, '2018-11-01', '2018-11-05'),
(160, 2, 1007, '2018-11-01', '2018-11-05'),
(100, 2, 1007, '2018-11-01', '2018-11-05'),
(100, 2, 1004, '2018-11-28', '2018-12-05'),
(115, 2, 1003, '2018-11-12', '2018-11-19'),

(110, 3, 1002, '2018-11-10', '2018-11-15'),
(130, 3, 1000, '2018-10-10', '2018-12-01'),
(165, 3, 1002, '2018-11-14', '2018-12-01'),
(195, 3, 1002, '2018-11-14', '2018-12-01'),
(160, 3, 1000, '2018-11-10', '2018-12-01'),
(200, 3, 1002, '2018-11-14', '2018-12-01'),
(115, 3, 1000, '2018-11-10', '2018-12-01'),
(125, 3, 1001, '2018-11-23', '2018-11-29'),
(175, 3, 1000, '2018-11-04', '2018-11-14'),
(155, 3, 1004, '2018-11-15', '2018-12-01'),
(135, 3, 1002, '2018-11-14', '2018-12-01'),

(115, 4, 1003, '2018-11-19', '2018-11-24'),
(155, 4, 1003, '2018-11-19', '2018-12-01'),
(100, 4, 1004, '2018-11-27', '2018-12-04'),
(185, 4, 1004, '2018-11-27', '2018-12-04'),
(105, 4, 1004, '2018-11-27', '2018-12-04'),
(110, 4, 1005, '2018-11-05', '2018-11-15'),
(105, 4, 1003, '2018-11-01', '2018-11-15'),
(200, 4, 1000, '2018-10-31', '2018-11-05'),
(155, 4, 1002, '2018-11-01', '2018-11-15'),
(165, 4, 1006, '2018-11-13', '2018-11-18'),
(200, 4, 1004, '2018-11-27', '2018-12-04'),
(175, 4, 1003, '2018-11-12', '2018-11-19'),
(165, 4, 1003, '2018-11-12', '2018-11-19')
;
/*Above is Built Database*/
CREATE PROC LostTribeCopies
AS
SELECT Number_of_Copies FROM Book_Copies a1
INNER JOIN Books a2 ON a2.BookID = a1.BookID
INNER JOIN Library_Branch a3 ON a3.BranchID = a1.BranchID
WHERE Title = 'The Lost Tribe' AND BranchName = 'Central'
GO
/*Above is PROC #1*/
CREATE PROC AllBranchesLostTribeCopies
AS
SELECT BranchName, Number_Of_Copies FROM Library_Branch a1
INNER JOIN Book_Copies a3 ON a3.BranchID = a1.BranchID
INNER JOIN Books a2 ON a2.BookID = a3.BookID
WHERE Title = 'The Lost Tribe'
GO
/*Above is PROC #2*/
CREATE PROC WhoHasNotBorrowered
AS
SELECT Name FROM Borrower a1
WHERE NOT EXISTS (SELECT * FROM Book_Loans a2 WHERE a1.CardNo = a2.CardNo)
/*Above is PROC #3*/

CREATE PROC DueTodaySharpstown
AS
SELECT Name, DateDue, BranchName FROM Book_Loans a1 /*Add DateDue & BranchName for check for accuracy*/
INNER JOIN Borrower a2 ON a2.CardNo = a1.CardNo
INNER JOIN Library_Branch a3 ON a3.BranchID = a1.BranchID
WHERE DateDue = '2018-11-29' AND BranchName = 'Sharpstown'
GO
/*Above is PROC #4*/
CREATE PROC TotalCheckedOut
AS
SELECT BranchName, COUNT(*) FROM Library_Branch
INNER JOIN Book_Loans ON Book_Loans.BranchID = Library_Branch.BranchID
WHERE Book_Loans.DateOut < GETDATE() AND DateDue >= GETDATE()
GROUP BY BranchName
/*Above is PROC #5*/
CREATE PROC CheckedOutMoreThan5
AS
SELECT B.Name, B.Address, COUNT(*) FROM Borrower as B
INNER JOIN Book_Loans ON Book_Loans.CardNo = B.CardNo
WHERE Book_Loans.DateOut < GETDATE() AND DateDue >= GETDATE()
GROUP BY B.Name, B.Address HAVING COUNT(*) >= 5
GO
/*Above is PROC #6*/
CREATE PROC StephenKingAtCentral
AS
SELECT Title, COUNT(*) AS TotalBooks FROM Books
INNER JOIN Book_Authors ON Book_Authors.BookID = Books.BookID AND AuthorName = 'Stephen King'
INNER JOIN Book_Copies ON Book_Copies.BookID = Books.BookID
INNER JOIN Library_Branch ON Library_Branch.BranchID = Book_Copies.BranchID AND BranchName = 'Central'
INNER JOIN Book_Loans ON Book_Loans.BranchId = Library_Branch.BranchID
WHERE Book_Loans.DateOut < GETDATE() AND DateDue >= GETDATE() 
GROUP BY Title
/*Above is PROC #7*/


