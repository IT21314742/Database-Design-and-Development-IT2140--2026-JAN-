CREATE DATABASE Tutorial_2
GO
;

USE Tutorial_2;
GO
;


-- Employee Table
CREATE TABLE Employee
(
eid VARCHAR(5) PRIMARY KEY ,
ename VARCHAR(30) NOT NULL,
salary INT CHECK (salary > 0),
dept INT,
phone VARCHAR(10)
)
;

--Department Table
CREATE TABLE Department
(
deptNo INT PRIMARY KEY,
dname VARCHAR(50),
location VARCHAR(50) CHECK(location IN('Colombo','Kandy','Galle')),
mgrID VARCHAR(5)
);

--INSERT DATA to Employee Table
INSERT INTO Employee (eid, ename, salary, dept, phone) VALUES
('E0001','Kumari',45000,3,'0112123456'),
('E0002','Anushka',63000,1,'0112123457'),
('E0003','Anura',27000,2,'0112123458'),
('E0004','Niranjala',36000,3,'0112123459'),
('E0005','Sampath',50000,1,'0112123450')
;

SELECT * FROM Employee;

INSERT INTO Department (deptNo, dname, location, mgrID) VALUES
(1,'Adminstration','Colombo','E0002'),
(2,'Sales','Kandy','E0002'),
(3,'Finance','Colombo','E0005')
;

SELECT * FROM Department;

--- 4. Add the foreign key constraints to the created tables.
ALTER TABLE Employee
ADD FOREIGN KEY (dept) REFERENCES Department(deptNo);

ALTER TABLE Department
ADD FOREIGN KEY(mgrID) REFERENCES Employee(eid);

--- 5.Add a column named bdate to the employee table to store the birth dates of employees.
ALTER TABLE Employee
ADD bdate DATE
;

--- 6. Update the salary of Kumari to 35000.
UPDATE Employee
SET salary = 35000
WHERE ename = 'Kumari'
;

--- 7. Delete Sampath from Employee table.
DELETE FROM Employee
WHERE ename = 'Sampath'
;

--- 8. Display the employee names and their salaries sorted by their names
SELECT ename, salary
FROM Employee
ORDER BY ename ASC;

--- 9. Display the names of the employees who obtain a salary greater than 50,000.
SELECT ename AS Employee_Name, salary AS Employee_Salary
FROM Employee
WHERE salary > 50000
;

--- 10.Display the employee’s name and the id of the department he/she is working in.
SELECT ename AS Employee_Name, dept AS Department_ID
FROM Employee
;

