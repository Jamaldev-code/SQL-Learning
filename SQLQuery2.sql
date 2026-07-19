CREATE DATABASE CourseDb1;
GO

USE CourseDb1;
GO


-- 1. Students
CREATE TABLE Students
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Age INT NOT NULL
);


-- 2. Rooms
CREATE TABLE Rooms
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);


-- 3. Educations
CREATE TABLE Educations
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);


-- 4. Teachers
CREATE TABLE Teachers
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    EducationId INT,

    CONSTRAINT FK_Teachers_Educations
        FOREIGN KEY (EducationId)
        REFERENCES Educations(Id)
);


-- 5. Groups
CREATE TABLE [Group]
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    RoomId INT,

    CONSTRAINT FK_Group_Rooms
        FOREIGN KEY (RoomId)
        REFERENCES Rooms(Id)
);


-- 6. GroupStudents
CREATE TABLE GroupStudents
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    GroupId INT NOT NULL,

    CONSTRAINT FK_GroupStudents_Students
        FOREIGN KEY (StudentId)
        REFERENCES Students(Id),

    CONSTRAINT FK_GroupStudents_Groups
        FOREIGN KEY (GroupId)
        REFERENCES [Group](Id)
);


-- 7. GroupTeachers
CREATE TABLE GroupTeachers
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GroupId INT NOT NULL,
    TeacherId INT NOT NULL,

    CONSTRAINT FK_GroupTeachers_Groups
        FOREIGN KEY (GroupId)
        REFERENCES [Group](Id),

    CONSTRAINT FK_GroupTeachers_Teachers
        FOREIGN KEY (TeacherId)
        REFERENCES Teachers(Id)
);


-- 8. StaffMembers
CREATE TABLE StaffMembers
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2)
);


-- 9. Roles
CREATE TABLE Roles
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);


-- 10. StaffMemberRoles
CREATE TABLE StaffMemberRoles
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StaffMemberId INT NOT NULL,
    RoleId INT NOT NULL,

    CONSTRAINT FK_StaffMemberRoles_StaffMembers
        FOREIGN KEY (StaffMemberId)
        REFERENCES StaffMembers(Id),

    CONSTRAINT FK_StaffMemberRoles_Roles
        FOREIGN KEY (RoleId)
        REFERENCES Roles(Id)
);


INSERT INTO Students (FullName, Age)
VALUES
('Ali Mammadov', 19),
('Leyla Aliyeva', 21),
('Murad Hasanov', 22),
('Aysel Karimova', 20),
('Elvin Huseynov', 23),
('Nigar Rahimova', 18),
('Tural Ahmadov', 25),
('Sabina Ismayilova', 21),
('Kamran Abbasov', 24),
('Zahra Mehdiyeva', 19);

INSERT INTO Educations (Name)
VALUES
('C# Programming'),
('SQL'),
('Java'),
('Python'),
('Web Development');

INSERT INTO Teachers (FullName, EducationId)
VALUES
('Jamaladdin Aghazada', 1),
('Orkhan Mammadov', 2),
('Nurlan Aliyev', 3),
('Amina Hasanli', 4),
('Rashad Karimov', 5);


INSERT INTO Rooms (Name)
VALUES
('Mars'),
('Earch'),
('Moon'),
('Neptune'),
('Pluton');

INSERT INTO [Group] (Name, RoomId)
VALUES
('CSharp-101', 1),
('CSharp-102', 1),
('SQL-101', 2),
('SQL-102', 2),
('Java-101', 3),
('Python-101', 4),
('Python-102', 4),
('Web-101', 5),
('Web-102', 5),
('Advanced-CSharp', NULL);

INSERT INTO StaffMembers (FullName, Salary)
VALUES
('Emin Mammadov', 1200),
('Samir Aliyev', 1800),
('Aysun Hasanli', 2200),
('Rauf Karimov', 1500),
('Lala Huseynova', 2500),
('Farid Ahmadov', 1300),
('Gunay Rahimova', 1900),
('Togrul Abbasov', 1700),
('Nermin Ismayilova', 2100),
('Orkhan Mehdiyev', 1100);


INSERT INTO Roles (Name)
VALUES
('Manager'),
('Administrator'),
('Accountant'),
('HR Specialist'),
('Assistant');

INSERT INTO GroupStudents (StudentId, GroupId)
VALUES
(1, 1),
(2, 1),
(3, 1),

(4, 2),
(5, 2),

(6, 3),
(7, 3),

(8, 4),
(9, 4),

(10, 5);

INSERT INTO GroupTeachers (GroupId, TeacherId)
VALUES
(1, 1),
(2, 1),

(3, 2),
(4, 2),

(5, 3),

(6, 4),
(7, 4),

(8, 5),
(9, 5),

(10, 1);

INSERT INTO StaffMemberRoles (StaffMemberId, RoleId)
VALUES
(1, 1),
(1, 2),

(2, 2),

(3, 1),
(3, 3),
(3, 4),

(4, 3),

(5, 1),
(5, 4),

(6, 5);

SELECT * FROM Students;

SELECT * FROM Teachers;

SELECT * FROM Educations;

SELECT * FROM Rooms;

SELECT * FROM [Group];

SELECT * FROM GroupStudents;

SELECT * FROM GroupTeachers;

SELECT * FROM StaffMembers;

SELECT * FROM Roles;

SELECT * FROM StaffMemberRoles;

SELECT *
FROM Students
ORDER BY FullName ASC;

SELECT *
FROM Students
WHERE Age > 20;

SELECT
    Teachers.FullName AS TeacherName,
    Educations.Name AS EducationName
FROM Teachers
INNER JOIN Educations
    ON Teachers.EducationId = Educations.Id;

SELECT
    [Group].Name AS GroupName,
    Rooms.Name AS RoomName
FROM [Group]
INNER JOIN Rooms
    ON [Group].RoomId = Rooms.Id;

SELECT
    [Group].Name AS GroupName,
    Rooms.Name AS RoomName
FROM [Group]
LEFT JOIN Rooms
    ON [Group].RoomId = Rooms.Id;

SELECT *
FROM StaffMembers
WHERE Salary > 1800;

SELECT
    Teachers.FullName AS TeacherName,
    [Group].Name AS GroupName
FROM Teachers
INNER JOIN GroupTeachers
    ON Teachers.Id = GroupTeachers.TeacherId
INNER JOIN [Group]
    ON GroupTeachers.GroupId = [Group].Id;

SELECT
    Students.FullName AS StudentName,
    [Group].Name AS GroupName
FROM Students
INNER JOIN GroupStudents
    ON Students.Id = GroupStudents.StudentId
INNER JOIN [Group]
    ON GroupStudents.GroupId = [Group].Id;

SELECT
    Rooms.Name AS RoomName,
    COUNT([Group].Id) AS GroupCount
FROM Rooms
LEFT JOIN [Group]
    ON Rooms.Id = [Group].RoomId
GROUP BY Rooms.Name;

SELECT
    [Group].Name AS GroupName,
    COUNT(GroupStudents.StudentId) AS StudentCount
FROM [Group]
LEFT JOIN GroupStudents
    ON [Group].Id = GroupStudents.GroupId
GROUP BY [Group].Name;

SELECT TOP 2
    [Group].Name AS GroupName,
    COUNT(GroupStudents.StudentId) AS StudentCount
FROM [Group]
LEFT JOIN GroupStudents
    ON [Group].Id = GroupStudents.GroupId
GROUP BY [Group].Name
ORDER BY StudentCount DESC;

DELETE FROM GroupStudents
WHERE StudentId = 10;

SELECT Students. *
FROM Students
LEFT JOIN GroupStudents
   ON Students.Id = GroupStudents.StudentId
WHERE GroupStudents.StudentId IS NULL;

SELECT * FROM Teachers

DELETE FROM GroupTeachers
WHERE TeacherId = 1;

SELECT Teachers. *
FROM Teachers
LEFT JOIN GroupTeachers
   ON Teachers.Id = GroupTeachers.TeacherId
WHERE GroupTeachers.TeacherId IS NULL;

SELECT * FROM [Group]
WHERE RoomId IS NULL

SELECT 
    [Teachers].FullName AS [FullName],
    COUNT(GroupTeachers.GroupId) AS GroupCount
FROM [Teachers]
LEFT JOIN GroupTeachers
    ON [GroupTeachers].Id = GroupTeachers.TeacherId
GROUP BY [Teachers].FullName;

SELECT 
    [Educations].[Name] AS EducationName,
    COUNT(Teachers.id) AS TeacherCount
FROM Educations
LEFT JOIN Teachers
    ON Educations.Id = Teachers.EducationId
GROUP BY Educations.[Name];


SELECT
    StaffMembers.FullName AS StaffName,
    Roles.[Name] AS RoleName
FROM StaffMembers
INNER JOIN StaffMemberRoles
    ON StaffMembers.Id = StaffMemberRoles.StaffMemberId
INNER JOIN Roles
    ON StaffMemberRoles.RoleId = Roles.Id;

SELECT
    StaffMembers.FullName AS StaffName,
    COUNT(StaffMemberRoles.RoleId) AS RoleCount
FROM StaffMembers
INNER JOIN StaffMemberRoles
    ON StaffMembers.Id = StaffMemberRoles.StaffMemberId
GROUP BY StaffMembers.FullName
HAVING COUNT(StaffMemberRoles.RoleId) > 1;