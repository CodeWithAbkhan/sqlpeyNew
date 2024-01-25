-- Employee Database Description:
-- This database is designed to store information about employees, departments, roles, and salaries.

-- Creating the 'employees' table to store employee information
DROP DATABASE IF EXISTS employees_db;
CREATE DATABASE IF NOT EXISTS employees_db;
USE employees_db;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

CREATE TABLE employees (
    emp_no      INT             NOT NULL,        -- Employee number (unique identifier)
    birth_date  DATE            NOT NULL,        -- Date of birth
    first_name  VARCHAR(14)     NOT NULL,        -- First name of the employee
    last_name   VARCHAR(16)     NOT NULL,        -- Last name of the employee
    gender      ENUM ('M','F')  NOT NULL,        -- Gender ('M' for Male, 'F' for Female)
    hire_date   DATE            NOT NULL,        -- Date of hiring
    PRIMARY KEY (emp_no)                        -- Primary key constraint
);

-- Creating the 'departments' table to store department information
CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,        -- Department number (unique identifier)
    dept_name   VARCHAR(40)     NOT NULL,        -- Department name
    PRIMARY KEY (dept_no),                      -- Primary key constraint
    UNIQUE  KEY (dept_name)                     -- Unique key constraint for department names
);

-- Creating the 'dept_manager' table to store department manager assignments
CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,        -- Employee number (foreign key referencing 'employees' table)
   dept_no      CHAR(4)         NOT NULL,        -- Department number (foreign key referencing 'departments' table)
   from_date    DATE            NOT NULL,        -- Start date of the managerial role
   to_date      DATE            NOT NULL,        -- End date of the managerial role
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,  -- Foreign key constraint
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,  -- Foreign key constraint
   PRIMARY KEY (emp_no,dept_no)                 -- Composite primary key
); 

-- Creating the 'dept_emp' table to store department assignments for employees
CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,        -- Employee number (foreign key referencing 'employees' table)
    dept_no     CHAR(4)         NOT NULL,        -- Department number (foreign key referencing 'departments' table)
    from_date   DATE            NOT NULL,        -- Start date of the assignment
    to_date     DATE            NOT NULL,        -- End date of the assignment
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,  -- Foreign key constraint
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,  -- Foreign key constraint
    PRIMARY KEY (emp_no,dept_no)                 -- Composite primary key
);

-- Creating the 'titles' table to store employee job titles
CREATE TABLE titles (
    emp_no      INT             NOT NULL,        -- Employee number (foreign key referencing 'employees' table)
    title       VARCHAR(50)     NOT NULL,        -- Job title
    from_date   DATE            NOT NULL,        -- Start date of the job title
    to_date     DATE,                            -- End date of the job title (can be NULL for current titles)
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,  -- Foreign key constraint
    PRIMARY KEY (emp_no,title, from_date)        -- Composite primary key
); 

-- Creating the 'salaries' table to store employee salaries
CREATE TABLE salaries (
    emp_no      INT             NOT NULL,        -- Employee number (foreign key referencing 'employees' table)
    salary      INT             NOT NULL,        -- Salary amount
    from_date   DATE            NOT NULL,        -- Start date of the salary
    to_date     DATE            NOT NULL,        -- End date of the salary
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,  -- Foreign key constraint
    PRIMARY KEY (emp_no, from_date)               -- Composite primary key
);


-- Inserting data into 'employees' table
INSERT INTO employees VALUES
(1, '1990-01-15', 'Muhammad', 'Ali', 'M', '2010-05-20'),
(2, '1988-03-25', 'Aisha', 'Ahmed', 'F', '2012-08-12'),
(3, '1995-07-08', 'Omar', 'Khan', 'M', '2015-11-30'),
(4, '1992-12-18', 'Fatima', 'Hassan', 'F', '2018-04-05'),
(5, '1987-06-02', 'Ibrahim', 'Malik', 'M', '2020-09-17');

-- Inserting data into 'departments' table
INSERT INTO departments VALUES
('HR01', 'Human Resources'),
('IT02', 'Information Technology'),
('SA03', 'Sales'),
('FN04', 'Finance'),
('MK05', 'Marketing');

-- Inserting data into 'dept_manager' table
INSERT INTO dept_manager VALUES
(1, 'HR01', '2010-05-20', '2013-02-15'),
(2, 'IT02', '2012-08-12', '2016-07-22'),
(3, 'SA03', '2015-11-30', '2019-09-10'),
(4, 'FN04', '2018-04-05', '2022-01-08'),
(5, 'MK05', '2020-09-17', '2023-06-25');

-- Inserting data into 'dept_emp' table
INSERT INTO dept_emp VALUES
(1, 'HR01', '2010-05-20', '2014-03-10'),
(2, 'IT02', '2012-08-12', '2017-05-28'),
(3, 'SA03', '2015-11-30', '2020-08-03'),
(4, 'FN04', '2018-04-05', '2022-12-20'),
(5, 'MK05', '2020-09-17', '2024-01-24');

-- Inserting data into 'titles' table
INSERT INTO titles VALUES
(1, 'Senior Developer', '2010-05-20', '2015-08-18'),
(2, 'HR Specialist', '2012-08-12', '2017-11-25'),
(3, 'Sales Manager', '2015-11-30', '2020-06-15'),
(4, 'Financial Analyst', '2018-04-05', NULL),
(5, 'Marketing Coordinator', '2020-09-17', NULL);

-- Inserting data into 'salaries' table
INSERT INTO salaries VALUES
(1, 80000, '2010-05-20', '2011-12-31'),
(2, 60000, '2012-08-12', '2013-12-31'),
(3, 75000, '2015-11-30', '2016-12-31'),
(4, 70000, '2018-04-05', '2019-12-31'),
(5, 65000, '2020-09-17', '2021-12-31');
