DROP TABLE IF EXISTS departments; 
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS assignment;
 
CREATE TABLE departments (
    dept_id    INT PRIMARY KEY,
    dept_name  VARCHAR(50) NOT NULL,
    location   VARCHAR(50)
);

use departments;

CREATE DATABASE departments;

INSERT INTO departments VALUES
(1, 'Engineering', 'Bengaluru'),
(2, 'HR',          'Mumbai'),
(3, 'Sales',       'Delhi'),
(4, 'Finance',     'Mumbai'),
(5, 'Marketing',   'Bengaluru');   -- no employees on purpose

CREATE TABLE employees (
    emp_id      INT PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    hire_date   DATE,
    salary      INT,
    commission  INT,            -- NULL for non-sales staff
    dept_id     INT,            -- NULL = not assigned yet
    manager_id  INT,            -- NULL = top of hierarchy
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

INSERT INTO employees VALUES
(1,  'Arjun',    'Mehta',     '2019-03-15', 150000, NULL, 1,    NULL),
(2,  'Priya',    'Sharma',    '2020-07-01',  95000, NULL, 1,    1),
(3,  'Rohan',    'Gupta',     '2021-01-10',  85000, NULL, 1,    1),
(4,  'Sneha',    'Iyer',      '2022-06-20',  70000, NULL, 1,    2),
(5,  'Karthik',  'Nair',      '2023-02-14',  60000, NULL, 1,    2),
(6,  'Ananya',   'Rao',       '2018-11-05', 110000, NULL, 2,    1),
(7,  'Vikram',   'Singh',     '2021-09-12',  55000, NULL, 2,    6),
(8,  'Neha',     'Verma',     '2020-04-18',  90000, 5000, 3,    1),
(9,  'Aditya',   'Kulkarni',  '2022-01-25',  65000, 8000, 3,    8),
(10, 'Meera',    'Joshi',     '2023-05-30',  52000, 3000, 3,    8),
(11, 'Sanjay',   'Reddy',     '2019-08-08', 120000, NULL, 4,    1),
(12, 'Divya',    'Menon',     '2021-12-01',  72000, NULL, 4,    11),
(13, 'Faisal',   'Khan',      '2024-01-15',  48000, NULL, 4,    11),
(14, 'Pooja',    'Patel',     '2022-09-09',  68000, 6000, 3,    8),
(15, 'Manoj',    'Kumar',     '2020-02-28',  78000, NULL, 1,    2),
(16, 'Ishita',   'Bose',      '2024-03-11',  58000, NULL, 1,    3),
(17, 'Tarun',    'Chawla',    '2017-06-19',  98000, NULL, 2,    6),
(18, 'Lakshmi',  'Pillai',    '2023-10-02',  62000, NULL, NULL, 1);  -- no department


CREATE TABLE projects (
    project_id    INT PRIMARY KEY,
    project_name  VARCHAR(100) NOT NULL,
    dept_id       INT,
    start_date    DATE,
    end_date      DATE,         -- NULL = ongoing
    budget        INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO projects VALUES
(1, 'Website Revamp',      1, '2024-01-01', '2024-06-30',  500000),
(2, 'Mobile App',          1, '2024-03-01', NULL,         1200000),
(3, 'Payroll Automation',  4, '2023-09-01', '2024-02-28',  300000),
(4, 'CRM Rollout',         3, '2024-05-01', NULL,          800000),
(5, 'Hiring Portal',       2, '2024-02-01', '2024-08-31',  250000),
(6, 'Brand Campaign',      5, '2024-06-01', NULL,          400000);


CREATE TABLE assignments (
    emp_id           INT,
    project_id       INT,
    role             VARCHAR(50),
    hours_allocated  INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO assignments VALUES
(2,  1, 'Lead',        120),
(3,  1, 'Developer',   200),
(4,  1, 'Developer',   180),
(2,  2, 'Lead',        150),
(3,  2, 'Developer',   220),
(5,  2, 'Developer',   200),
(15, 2, 'Backend',     210),
(16, 2, 'Tester',      100),
(4,  2, 'Designer',     90),
(1,  2, 'Sponsor',      20),
(12, 3, 'Analyst',      90),
(11, 3, 'Manager',      60),
(13, 3, 'Analyst',     110),
(8,  4, 'Manager',      80),
(9,  4, 'Sales Rep',   140),
(10, 4, 'Sales Rep',   130),
(14, 4, 'Sales Rep',   120),
(7,  5, 'Coordinator', 100),
(6,  5, 'Manager',      50),
(17, 5, 'Recruiter',   160);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM assignments; 
 
 
 -- 1. List all employees with their first name, last name and salary.
 SELECT first_name, last_name, salary
 FROM employees
 GROUP BY first_name, last_name, salary;
 
 -- 2. Show employees who earn more than 80,000.
 SELECT first_name, salary
 FROM employees
 WHERE salary > 80000;
 
 -- 3. Find employees hired in 2022 or later.
 SELECT * 
 FROM employees
 WHERE hire_date >= '2022-01-01';
 
 -- 4. List employees from department 1 or 3, sorted by salary (highest first).
 SELECT e.first_name, e.salary, d.dept_name
 FROM departments d
 JOIN employees e
 ON e.dept_id = d.dept_id
 GROUP BY e.first_name, e.salary, d.dept_name
 ORDER BY e.salary DESC;
 
 -- 5. Find employees whose first name starts with 'A'.
 SELECT emp_id, first_name
 FROM employees
 WHERE first_name LIKE 'A%'
 GROUP BY emp_id, first_name;
 
 -- 6. Find employees whose salary is between 60,000 and 90,000.
 SELECT emp_id, salary
 FROM employees
 WHERE salary BETWEEN 60000 AND 90000;
 
 -- 7. List employees who have no department assigned.
 SELECT * 
 FROM employees 
 WHERE dept_id IS NULL;
 
 -- 8. List employees who receive a commission (non-NULL).
 SELECT * FROM employees
 WHERE commission is NOT NULL;
 
 -- 9. Show the 3 highest-paid employees.
 SELECT first_name, salary
 FROM employees
 GROUP BY first_name, salary
 ORDER BY salary DESC
 LIMIT 3;
 
 
 -- 10. Show distinct locations from the departments table.
 SELECT DISTINCT location
 FROM departments;
 
 -- 11. Count the total number of employees.
 SELECT COUNT(emp_id)
 FROM employees;
 
 -- 12. Find the average, minimum and maximum salary.
 SELECT AVG(salary), MIN(salary), MAX(salary)
 FROM employees;
 
 -- 13. Count employees in each department (show dept_id).
  SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS employee_count
  FROM employees e
  JOIN departments d
  ON e.dept_id = d.dept_id
  GROUP BY d.dept_id, d.dept_name;
  
  -- 14.  Find the total salary expense per department.
  SELECT d.dept_id, d.dept_name, SUM(e.salary)
  FROM departments d
  JOIN employees e
  ON e.dept_id = d.dept_id
  GROUP BY d.dept_id, d.dept_name;
  
  -- 15. show dept having more than 3 employee
  SELECT COUNT(e.emp_id) AS TOTAL_EMP, d.dept_name, d.dept_id
  FROM departments d
  JOIN employees e
  ON e.dept_id = d.dept_id
  GROUP BY d.dept_id, d.dept_name
  HAVING COUNT(e.emp_id) > 2;
  
  -- 16. count how many projects are on going
  SELECT project_name, end_date
  FROM projects
  WHERE end_date IS NOT NULL;
  
  -- 17. find the total budget of projects per department
  SELECT SUM(p.budget) AS TOTAL_BUDGET, d.dept_name
  FROM projects p 
  JOIN departments d
  ON p.dept_id = d.dept_id
  GROUP BY d.dept_name;
  
 -- 18. show each employees name with their dept name (inner join)
 SELECT e.first_name, d.dept_name
 FROM departments d 
 INNER JOIN employees e
 ON e.dept_id = d.dept_id
 GROUP BY e.first_name, d.dept_name;
 
 -- 19. show all employees with dept name including those without a depatment (left join)
 SELECT e.first_name, d.dept_name
 FROM departments d 
 LEFT JOIN employees e
 ON e.dept_id = d.dept_id
 GROUP BY e.first_name, d.dept_name;
 
 -- 20. Find dept that as no employees
 SELECT d.dept_name, e.emp_id
 FROM departments d
LEFT JOIN employees e 
 ON e.dept_id = d.dept_id
 WHERE e.emp_id IS NULL
 GROUP BY d.dept_name, e.emp_id;
 
 -- 21. list emp name with project they work on and their role
 SELECT e.first_name, p.project_name, a.role
 FROM employees e 
 JOIN assignments a 
 ON a.emp_id = a.emp_id
 JOIN projects p  
 ON a.project_id = p.project_id
 GROUP BY e.first_name, p.project_name, a.role;
 
 -- 22. find emp who are not assigned to any project
 SELECT e.emp_id,
       e.first_name || ' ' || e.last_name AS employee_name
FROM employees e
LEFT JOIN assignments a ON e.emp_id = a.emp_id
WHERE a.emp_id IS NULL;

-- 23. show each project name with  total hours allocated across all employees.
SELECT e.emp_id, p.project_name, a.hours_allocated
FROM employees e 
JOIN assignments a 
ON e.emp_id = a.emp_id
JOIN projects p 
ON a.project_id = p.project_id
GROUP BY e.emp_id, p.project_name, a.hours_allocated;

-- 24. find employees earning more than company average salary 
  SELECT emp_id, first_name, salary
  FROM employees
  WHERE salary > (SELECT AVG(salary) FROM employees)
                  ORDER BY salary DESC;
 
 
 -- 25. find the employes with the second highest salary
 SELECT emp_id, first_name, salary
 FROM employees
 WHERE salary = (
                 SELECT MAX(salary) 
                 FROM employees
                 WHERE salary < (SELECT MAX(salary) FROM employees)
);

-- 26. find employees who earn more than their dept avg salary
SELECT e.emp_id,
       e.first_name AS employee_name,
       e.dept_id,
       e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
)
ORDER BY e.dept_id, e.salary DESC;


