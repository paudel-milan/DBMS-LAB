create database employee;

use employee;

-- Create DEPT Table
CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    DLOC VARCHAR(50)
);

-- Create EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(50),
    MGR_NO INT,
    HIREDATE DATE,
    SAL DECIMAL(10, 2),
    DEPTNO INT,
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);

-- Create PROJECT Table
CREATE TABLE PROJECT (
    PNO INT PRIMARY KEY,
    PNAME VARCHAR(50),
    PLOC VARCHAR(50)
);

-- Create INCENTIVES Table
CREATE TABLE INCENTIVES (
    EMPNO INT,
    INCENTIVE_DATE DATE,
    INCENTIVE_AMOUNT DECIMAL(10, 2),
    FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO)
);

-- Create ASSIGNED_TO Table (Represents the relationship between EMPLOYEE and PROJECT with JOB_ROLE)
CREATE TABLE ASSIGNED_TO (
    EMPNO INT,
    PNO INT,
    JOB_ROLE VARCHAR(50),
    FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO),
    FOREIGN KEY (PNO) REFERENCES PROJECT(PNO),
    PRIMARY KEY (EMPNO, PNO)
);

-- Insert Data into DEPT Table
INSERT INTO DEPT (DEPTNO, DNAME, DLOC) VALUES 
(1, 'HR', 'Bengaluru'),
(2, 'Finance', 'Hyderabad'),
(3, 'Engineering', 'Mysuru'),
(4, 'Marketing', 'Mumbai');

-- Insert Data into EMPLOYEE Table
INSERT INTO EMPLOYEE (EMPNO, ENAME, MGR_NO, HIREDATE, SAL, DEPTNO) VALUES 
(101, 'Alice', NULL, '2022-01-15', 60000, 1),
(102, 'Bob', 101, '2022-03-01', 50000, 2),
(103, 'Charlie', 101, '2022-05-20', 55000, 1),
(104, 'David', NULL, '2022-07-10', 70000, 3),
(105, 'Eve', 104, '2022-08-15', 65000, 3),
(106, 'Frank', 102, '2022-09-05', 50000, 2),
(107, 'Grace', 105, '2022-10-20', 72000, 4);

-- Insert Data into PROJECT Table
INSERT INTO PROJECT (PNO, PNAME, PLOC) VALUES 
(201, 'Project Alpha', 'Bengaluru'),
(202, 'Project Beta', 'Hyderabad'),
(203, 'Project Gamma', 'Mysuru'),
(204, 'Project Delta', 'Mumbai');

-- Insert Data into INCENTIVES Table
INSERT INTO INCENTIVES (EMPNO, INCENTIVE_DATE, INCENTIVE_AMOUNT) VALUES 
(101, '2022-12-01', 1500),
(103, '2022-12-10', 1300),
(104, '2022-12-15', 1400),
(105, '2022-12-20', 1600),
(107, '2022-12-30', 1700);

-- Insert Data into ASSIGNED_TO Table
INSERT INTO ASSIGNED_TO (EMPNO, PNO, JOB_ROLE) VALUES 
(101, 201, 'Manager'),
(102, 202, 'Analyst'),
(103, 201, 'Developer'),
(104, 203, 'Lead Engineer'),
(105, 203, 'Developer'),
(106, 202, 'Consultant'),
(107, 204, 'Marketing Specialist');



-- Retrieve the employee numbers of all employees who work on project located in Bengaluru, Hyderabad, or Mysuru

select e.empno from employee e
join assigned_to a on a.empno=e.empno
join project p on p.pno=a.pno
where p.ploc in ("Bangalore","Hyderabad","Mysore");

-- Get Employee ID’s of those employees who didn’t receive incentives

select empno from employee
where empno not in (select empno from incentives);

-- Write a SQL query to find the employees name, number, dept,
-- job_role, department location and project location who are working for
-- a project location same as his/her department location.

select e.ename,e.empno,d.dname,a.job_role,p.ploc from employee e
join dept d on d.deptno=e.deptno
join assigned_to a on a.empno=e.empno
join project p on p.pno=a.pno
where p.ploc=d.dloc;




