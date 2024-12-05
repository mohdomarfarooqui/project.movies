create database movierental;
use movierental;
create table customers (
customerid int primary key,
firstname varchar(50),
lastname varchar(50),
email varchar(100),
phone varchar(15),
registrationdate date not null);

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    ReleaseYear INT,
    Rating VARCHAR(10)
);

CREATE TABLE Rentals (
    RentalID INT PRIMARY KEY,
    CustomerID INT NOT NULL, FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    MovieID INT NOT NULL, FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    RentalDate DATE NOT NULL,
    ReturnDate DATE,
    RentalStatus VARCHAR(20) CHECK (RentalStatus IN ('Returned', 'Not Returned'))
    );
    
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, RegistrationDate)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '2023-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '0987654321', '2023-02-20');



INSERT INTO Movies (MovieID, Title, Genre, ReleaseYear, Rating)
VALUES
(1, 'Inception', 'Sci-Fi', 2010, 'PG-13'),
(2, 'Titanic', 'Romance', 1997, 'PG-13'),
(3, 'The Dark Knight', 'Action', 2008, 'PG-13');


INSERT INTO Rentals (RentalID, CustomerID, MovieID, RentalDate, ReturnDate, RentalStatus)
VALUES
(1, 1, 1, '2023-03-01', '2023-03-05', 'Returned'),
(2, 2, 3, '2023-03-04', NULL, 'Not Returned');


SELECT movies.Title
FROM Movies
JOIN Rentals ON Movies.MovieID = Rentals.MovieID
JOIN Customers ON Rentals.CustomerID = Customers.CustomerID
WHERE Customers.FirstName = 'John' AND Customers.LastName = 'Doe';


SELECT Movies.Title, Customers.FirstName, Customers.LastName
FROM Movies
JOIN Rentals ON Movies.MovieID = Rentals.MovieID
JOIN Customers ON Rentals.CustomerID = Customers.CustomerID
WHERE Rentals.RentalStatus = 'Not Returned';

SELECT Customers.FirstName, Customers.LastName, COUNT(Rentals.RentalID) AS RentalCount
FROM Customers
JOIN Rentals ON Customers.CustomerID = Rentals.CustomerID
GROUP BY Customers.CustomerID;

SELECT Genre, COUNT(*) AS GenreCount
FROM Movies
JOIN Rentals ON Movies.MovieID = Rentals.MovieID
GROUP BY Genre
ORDER BY GenreCount DESC
LIMIT 1;

