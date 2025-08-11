CREATE DATABASE library_management;
USE library_management;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(50),
    Genre VARCHAR(30),
    AvailableCopies INT
);

INSERT INTO Books VALUES
(1, 'Atomic Habits', 'James Clear', 'Self-Help', 5),
(2, 'The Alchemist', 'Paulo Coelho', 'Fiction', 3),
(3, 'Sapiens', 'Yuval Noah Harari', 'History', 4),
(4, 'Deep Work', 'Cal Newport', 'Productivity', 2);


# Table for storing borrowing records
CREATE TABLE Borrowing (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    BorrowerName VARCHAR(50),
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


INSERT INTO Borrowing VALUES
(1, 1, 'Anita', '2025-08-01', '2025-08-08'),
(2, 2, 'Rahul', '2025-08-03', '2025-08-10'),
(3, 1, 'Priya', '2025-08-05', NULL), -- not returned yet
(4, 3, 'Vikram', '2025-08-06', '2025-08-13');

# SHOW ALL AVAILABLE BOOK
SELECT Title, Author, Genre, AvailableCopies
FROM Books
WHERE AvailableCopies > 0;

#  Find all currently borrowed books (not returned yet)

SELECT b.Title, br.BorrowerName, br.BorrowDate
FROM Borrowing br
JOIN Books b ON br.BookID = b.BookID
WHERE br.ReturnDate IS NULL;

# Count how many books each borrower has borrowed

SELECT BorrowerName, COUNT(*) AS TotalBorrowed
FROM Borrowing
GROUP BY BorrowerName;

# Check which genre is borrowed the most


SELECT Genre, COUNT(*) AS BorrowCount
FROM Borrowing br
JOIN Books b ON br.BookID = b.BookID
GROUP BY Genre
ORDER BY BorrowCount DESC;
