CREATE DATABASE EmployeerDB
USE EmployeerDB

USE master;
GO


ALTER DATABASE EmployeerDB
MODIFY NAME = CompanyDB;

USE CompanyDB

CREATE TABLE Employees(
[Id] INT PRIMARY KEY IDENTITY(1,1),
[FullName] NVARCHAR (50) NOT NULL,
[Age] INT CHECK (Age >= 18 AND Age <= 70 ) NOT NULL,
[Email] NVARCHAR (50) UNIQUE,
[Address] NVARCHAR (100) DEFAULT  'XXXXX'
)

SELECT * FROM Employees


INSERT INTO Employees([FullName],[Age], [Email], [Address])
VALUES ('Cavidan Huseynov', 32, 'ch@gmail.com', 'Xetai' ),
       ('Ferid Eliyev', 19, 'fe@gmail.com', DEFAULT),
       ('Lamiye Selimova', 22 , 'ls@gmail.com', 'Balaxani'),
       ('Nurana Ehmedova', 21, 'ne@gmail.com', DEFAULT),
       ('Firuza Axundava', 26, 'fa@gmail.com', 'Yasamal'),
       ('Ehmed Ehmedov', 38, 'ee@gmail.com', 'Qaradag')

SELECT * FROM Employees

SELECT SUM(Age) AS SumOfEmployeesAges
FROM Employees 

SELECT AVG(Age) AS AverageAge
FROM Employees

SELECT * FROM Employees
WHERE [FullName] LIKE '%N%'

SELECT TOP 3 [FullName]
FROM Employees
ORDER BY [Id] DESC

SELECT SUM (Age) + AVG(Age) AS Result
FROM Employees

SELECT
    SUM(Age) AS TotalAge,
    AVG(Age) AS AverageAge
FROM Employees;

SELECT [FullName],[Email], [Address]
FROM Employees
WHERE Age > 25;

SELECT * FROM Employees
WHERE [FullName] LIKE 'C%'

SELECT [FullName], [Email]
FROM Employees
WHERE Email LIKE '%gmail%';

SELECT * FROM Employees
WHERE [Age] BETWEEN 25 AND 30 