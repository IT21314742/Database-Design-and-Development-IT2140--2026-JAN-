CREATE DATABASE Lab_Sheet_1;
GO

USE Lab_Sheet_1;
GO


-- Create emp Table
create table emp
(
	eid integer primary key,
	ename varchar(25),
	age int,
	salary float
)

-- View all from emp table
SELECT * FROM emp;

-- Insert data into emp table
insert into emp values(1000,'Lakmal',33,90000)
insert into emp values(1001,'Nadeeka',24,28000)
insert into emp values(1002,'Amila',26,35000)
insert into emp values(1003,'Nishani',28,60000)
insert into emp values(1004,'Krishan',36,95000)
insert into emp values(1005,'Surangi',37,22000)
insert into emp values(1006,'Shanika',24,18000)
insert into emp values(1007,'Amali',21,20000)
insert into emp values(1008,'Charith',28,35000)
insert into emp values(1009,'Prasad',40,95000)


--create dep table
create table dept
(
did char(12) primary key,
budget float,
managerId int foreign key references emp
)

SELECT * FROM dept;

-- Insert into dept table
INSERT INTO dept VALUES ('Academic',900000,1002)
INSERT INTO dept VALUES ('Admin',120000,1000)
INSERT INTO dept VALUES ('Finance',3000000,1008)
INSERT INTO dept VALUES ('ITSD',4500000,1000)
INSERT INTO dept VALUES ('Maintenance',40000,1004)
INSERT INTO dept VALUES ('SESD',20000,1004)
INSERT INTO dept VALUES ('Marketing',90000,1008)


--Create works table
create table works
(
eid int foreign key references emp,
did Char(12) foreign key references dept,
pct_time int,
primary key(eid,did)
)

--view works table
SELECT * FROM works;

--insert into works table
insert into works values(1000,'Admin',40)
insert into works values(1000,'ITSD',50)
insert into works values(1001,'Admin',100)
insert into works values(1002,'Academic',100)
insert into works values(1003,'Admin',20)
insert into works values(1003,'Academic',30)
insert into works values(1003,'ITSD',45)
insert into works values(1004,'Admin',60)
insert into works values(1004,'Finance',30)
insert into works values(1006,'Finance',45)
insert into works values(1006,'Maintenance',52)
insert into works values(1008,'Maintenance',30)
insert into works values(1008,'ITSD',30)
insert into works values(1008,'Finance',35)
insert into works values(1009,'Admin',100)

-- Exercises (Section 1) — see Data_Set.sql for reference

----- a. Retrieve all information of all employees
SELECT * 
FROM emp;

---b. Display the names and salaries of employees who earn more than 50,000.
SELECT ename, salary
FROM emp
WHERE salary >= 50000;

--- c. Find employees whose names start with the letter 'A'
SELECT ename
FROM emp
WHERE ename LIKE 'A%'

--- d. List the names and ages of employees younger than 30.
SELECT ename AS EmployeeName, age AS EmployeeAge
FROM emp
WHERE age < 30
;

--------------- OR ------
SELECT ename, age
FROM emp
WHERE age < 30;

------- Between method --------
SELECT ename AS Employee_Name, age AS Employee_Age
FROM emp
WHERE age BETWEEN 18 AND 29;


----- e. Find the employees whose salary is between 20,000 and 60,000.
SELECT ename AS Employee_Name, salary AS Employee_Salary
FROM emp
WHERE salary BETWEEN 20000 AND 60000;

---- OR ----
SELECT ename, salary
FROM emp
WHERE salary >= 20000 AND salary <= 60000;

--- f. Show employee names whose names contain the letter ‘a’.
SELECT ename
FROM emp
WHERE ename LIKE '%a%'


--- g. Display the employee ID and name of those who are either aged 24 or 28
SELECT eid AS Employee_ID, ename AS Employee_Name, age AS Employee_Age
FROM emp
WHERE age = 24 OR age = 28
;

---- secondery method -----
SELECT eid, ename, age
FROM emp
WHERE age IN (24,28)
;

--- h. Select employees whose age is not between 25 and 35.
SELECT ename AS Employee_Name, age AS Employee_Age
FROM emp
WHERE age NOT BETWEEN 25 AND 35
;

--- i. List all employees whose salary is not null.
SELECT *
FROM emp
WHERE salary IS NOT NULL
;



---- Exercises (Section 2) — see Data_Set.sql for reference
---- Write SQL queries for the following:

---List all employees sorted by their name (ename)
SELECT *
FROM emp
ORDER BY ename ASC
;

--- a. Show all employees sorted in descending order of salary.
SELECT ename AS EMployee_Name, salary AS Employee_Salary
FROM emp
ORDER BY salary DESC
;


--- b. Display employee details ordered ascending by age and descending by salary.
SELECT *
FROM emp
ORDER BY age ASC, salary DESC
;

--- c. Show all departments sorted by budget in descending order.
SELECT * FROM dept;


SELECT *
FROM dept
ORDER BY budget DESC
;

--- d. List all work assignments ordered by pct_time.
SELECT *
FROM works
ORDER BY pct_time
;


--- Exercises (Section 3) — see Data_Set.sql for reference
---Write SQL queries for the following:

--- a. How many employees are in the organization?
SELECT COUNT(eid) AS TotalEmployees
FROM emp;


--- b. What is the total salary paid to all employees?
SELECT SUM(salary) AS TotalSalary
FROM emp
;

--- c. What is the highest salary and the lowest salary among all employees?
SELECT MIN(salary) AS LowestSalary, MAX(salary) AS HighestSalary
FROM emp

---- IMPROVE LIKE THIS ----
SELECT eid,ename,salary
FROM emp
WHERE salary = (SELECT MIN(salary) FROM emp)
	OR salary = (SELECT MAX(salary) FROM emp)
;


--- d. What is the average salary of employees?
SELECT AVG(salary) AS AverageSalary
FROM emp
;

--- More Better----
SELECT CONCAT('RS: ', AVG(salary)) AS AverageSalary
FROM emp
;

--- e. How many employees are aged below 30?
SELECT COUNT(*) AS EmployeesBelow30
FROM emp
WHERE age < 30
;


--- Bit informative version----
SELECT eid AS EmployeeID, ename AS EmployeeName, age AS EmployeeAge
FROM emp
WHERE age < 30;


---f. What is the total number of departments?
SELECT COUNT(did) AS Department_Count
FROM dept
;

--- g. What is the maximum and minimum department budget?
SELECT MIN(budget) AS Minimum_Busget, MAX(Budget) AS Maximum_Budget
FROM dept
;

--- h. What is the total percentage of work assigned across all employees? (works table)
SELECT SUM(pct_time) AS Total_Percentage
FROM works
;


--- i. What is the average work time (pct_time) per employee?
SELECT AVG(employee_total) AS Average_work_time_per_employee
FROM (
    SELECT eid, SUM(pct_time) AS employee_total
    FROM works
    GROUP BY eid
) AS employee_totals;


--- Exercises (Section 4) — see Data_Set.sql for reference
--- Write SQL queries for the following:

--- a. What is the total salary paid to employees of each age group?
SELECT age, SUM(salary) AS TotalSalary
FROM emp
GROUP BY age
ORDER BY age
;

--- Count the number of employees working in each department. Rename the count as ‘Number of Employees’
SELECT did AS Department_ID, COUNT(eid) AS Number_of_Employees
FROM works
GROUP BY did
;


--- c. How many employees earn a salary greater than 50,000?
SELECT COUNT(eid) AS NumberofEmployeesEarn50K
FROM emp
WHERE salary > 50000
;

--- d. List all employees who earn more than 50,000, sorted by salary in ascending order.
SELECT eid,salary, ename AS EmployeeNames
FROM emp
WHERE salary > 50000
ORDER BY salary ASC 
;


--- Exercises (Section 5) — see Data_Set.sql for reference
--- Write SQL queries for the following:

--- a. Display the department IDs where the number of employees is less than 3.
SELECT did AS DepartmentID, COUNT(eid) AS NoOfEmployees
FROM works
GROUP BY did
HAVING COUNT(eid) < 3 ;


--- b. List each manager and the number of departments they manage. Show only managers who manage more than 1 department. Sort by the number of departments ascending.
SELECT managerId AS manager, COUNT(did) AS NoOfDepartments
FROM dept
GROUP BY managerId
HAVING COUNT(did) > 1
ORDER BY COUNT(did) ASC
;

--- c. Show each age group and the average salary of employees in that group. Display only age groups where the average salary is greater than 40,000.
SELECT age, AVG(salary) AS AverageSalary
FROM emp
GROUP BY age
HAVING AVG(salary) > 40000
;

--- Rounding up to avg-----
SELECT age, ROUND(AVG(salary),2) AS Average_Salary
FROM emp
GROUP BY age
HAVING AVG(salary) > 40000
;


--- Find the number of work assignments per employee. Display employees with more than 2 assignments
SELECT eid AS Employee, COUNT(pct_time) AS NoOfAssignments
FROM works
GROUP BY eid
HAVING COUNT(pct_time) >2
;

--- List departments with a total budget greater than 1,000,000
SELECT did, SUM(budget) AS total_budget
FROM dept
GROUP BY did
HAVING SUM(budget) > 1000000
;

-- OR Simpler--- 

SELECT did, budget AS total_budget
FROM dept
WHERE budget > 1000000
;







--- IT21314742 Jayasinghe SVMT
------- END OF THE LAB SHEET -----------