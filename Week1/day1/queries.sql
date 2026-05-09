CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE IF NOT EXISTS Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE IF NOT EXISTS Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000, 2, '2019-12-01');

INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4);

SELECT * FROM Employee;

SELECT name, salary FROM Employee;

SELECT * FROM Employee WHERE age > 30;

SELECT name FROM Department;

SELECT e.* FROM Employee e 
JOIN Department d ON e.department_id = d.department_id 
WHERE d.name = 'IT';

SELECT * FROM Employee WHERE name LIKE 'J%';

SELECT * FROM Employee WHERE name LIKE '%e';

SELECT * FROM Employee WHERE name LIKE '%a%';

SELECT * FROM Employee WHERE LENGTH(name) = 9;

SELECT * FROM Employee WHERE name LIKE '_o%';

SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

SELECT * FROM Employee WHERE YEAR(hire_date) < 2019;

SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

SELECT * FROM Employee WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

SELECT SUM(salary) AS total_salary FROM Employee;

SELECT AVG(salary) AS average_salary FROM Employee;

SELECT MIN(salary) AS minimum_salary FROM Employee;

SELECT department_id, COUNT(*) AS employee_count FROM Employee GROUP BY department_id;

SELECT department_id, AVG(salary) AS average_salary FROM Employee GROUP BY department_id;

SELECT department_id, SUM(salary) AS total_salary FROM Employee GROUP BY department_id;

SELECT department_id, AVG(age) AS average_age FROM Employee GROUP BY department_id;

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count FROM Employee GROUP BY YEAR(hire_date);

SELECT department_id, MAX(salary) AS highest_salary FROM Employee GROUP BY department_id;

SELECT d.name, AVG(e.salary) AS average_salary 
FROM Employee e 
JOIN Department d ON e.department_id = d.department_id 
GROUP BY d.department_id, d.name 
ORDER BY average_salary DESC 
LIMIT 1;
