CREATE DATABASE Lab1;
GO

USE Lab1;
GO

CREATE TABLE Employees
(
	EmployeeID INT PRIMARY KEY,
	FirstName VARCHAR(10) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Place VARCHAR(50),
	Country VARCHAR(30),
	PhoneNo	VARCHAR(15)
);

SELECT * FROM Employees;

CREATE TABLE Rooms
(
	RoomID INT PRIMARY KEY,
	RoomName VARCHAR(20) NOT NULL,
	Capacity VARCHAR(10) NOT NULL
);

CREATE TABLE Meetings
(
	MeetingID INT IDENTITY(1,1) PRIMARY KEY,
	MeetingTitle VARCHAR(50),
	MeetingDate DATE,
	TimeFrom TIME,
	TimeTo TIME,
	RoomID INT FOREIGN KEY REFERENCES Rooms(RoomID)
);


CREATE TABLE EmployeeMeetings
(
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
	MeetingID INT FOREIGN KEY REFERENCES Meetings(MeetingID)

	PRIMARY KEY (EmployeeID, MeetingID)
);

-- Insert Employees Information to the employee table

INSERT INTO Employees (EmployeeID, FirstName, LastName, Place, Country, PhoneNo)
VALUES 
(1, 'Vihan','Jayasinghe','Silverstone', 'United Kindom', '0147845221'),
(2, 'Chamod', 'Ekanayake', 'Texas', 'United States', '0174585445'),
(3, 'Mohan', 'Devinda', 'Goa', 'India', '0198741556'),
(4, 'Rajitha', 'Gunawardhana', 'Colombo', 'Sri-Lanka', '945684112'),
(5, 'Gimhani', 'Gunawardhane', 'hamburg', 'Germany', '1124578995'),
(6, 'Max', 'Verstappen', 'Holland', 'Netherland', '0784595661'),
(7, 'Charles', 'Leclerc', 'Prince ST', 'Monaco', '154268774'),
(8, 'Gihan', 'Eranga', 'England', 'United Kindom', '158574456');

SELECT * FROM Employees;


-- Insert Into Rooms Table
INSERT INTO Rooms (RoomID, RoomName, Capacity)
VALUES
(1, 'warfare', '4_Seats'),
(2, 'Queens', '2-Seats'),
(3, 'Barberians', '40-Seats'),
(4, 'Archers', '15-Seats'),
(5, 'Giants', '20-Seats'),
(6, 'Goblins', '40-Seats'),
(7, 'Dragons', '10-Seats')
;

SELECT * FROM Rooms;

--- Insert Into meeting Table
INSERT INTO Meetings (MeetingTitle, MeetingDate, TimeFrom, TimeTo, RoomID )
VALUES
( 'NanoMeeting', '2026-03-29', '09:00:00',  '11:00:00', 1),
( 'MegaMeeting','2026-03-30', '10:00:00', '10:30:00', 2),
( 'P.E.K.K.A Standup', '2026-04-01', '08:30:00', '11:00:00', 3),
( 'Dragon-Meeting', '2026-04-02', '01:00:00', '01:30:00', 4),
( 'Baby Dragon Design Finalize', '2026-04-03', '02:00:00', '04:00:00', 5);

SELECT * FROM Meetings;

-- Insert into EmployeeMeetings table
INSERT INTO EmployeeMeetings (EmployeeID, MeetingID)
VALUES 
(1,1),
(2,1),
(3,1),
(4,2),
(5,3)
;

SELECT * FROM EmployeeMeetings;

SELECT * FROM Employees;


-- Find the first name of employees from India whose last name start with k.
SELECT FirstName 
FROM Employees
WHERE Country='germany' AND LastName LIKE 'G%';

SELECT LastName
FROM Employees
WHERE Country = 'United kindom' AND FirstName LIKE 'G%';



-- Find the names of rooms capacity over 50
SELECT RoomID
FROM ROOMS
WHERE Capacity > 5;

SELECT * FROM Rooms;


-- Find the IDs of meeting with a duration more than 3 hours. 
SELECT MeetingID
FROM Meetings
WHERE DATEDIFF(HOUR, TimeFrom, TimeTo) > 3
;

---------OR if we need it on minute -----
SELECT MeetingID
FROM Meetings
WHERE DATEDIFF(MINUTE,TimeFrom, TimeTo) > 180
;

--- Find the IDs of rooms with a capacity over 50.
SELECT RoomID
FROM Rooms
WHERE capacity > 50;

--- Display the highest and the lowest capacities among rooms.
SELECT MIN(capacity) AS MinimumCapacity,
		MAX(capacity) AS HighestCapacity
FROM Rooms  --- Absolutly Best way

------- OR -------
SELECT MIN(capacity), MAX(capacity)
FROM Rooms;


--- Find the number of employees from India.
SELECT COUNT(EmployeeID)
FROM Employees
WHERE country = 'India'
;

-- Find the number of employees from different countries
SELECT COUNT(*)
FROM Employees
GROUP BY Country
;

---- OR ----
SELECT Country, COUNT(*) AS NumberofEmployees
FROM Employees
GROUP BY Country;

--- Find the country which has more than 20 employees from
SELECT country, COUNT(EmployeeID) AS Number_of_Employees
FROM Employees
GROUP BY Country
HAVING COUNT(EmployeeID) > 20;


--- Find the number of rooms used for each meeting title
SELECT MeetingTitle, COUNT(DISTINCT RoomID) AS NumberOfRooms
FROM Meetings
GROUP BY MeetingTitle;


--- Find all meeting titles that have been held in more than one room, along with the number of rooms for each title
SELECT MeetingTitle, COUNT(DISTINCT RoomID) AS NumberOfRooms
FROM Meetings
GROUP BY MeetingTitle
HAVING COUNT(DISTINCT RoomID) > 1;