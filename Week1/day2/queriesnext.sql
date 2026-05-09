-- Query 25: Select the department with the highest average salary.
SELECT department_id, AVG(salary) as avg_salary
FROM employee
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

-- Query 26: Select departments with more than 2 employees.
SELECT department_id, COUNT(*) as emp_count
FROM employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Query 27: Select departments with an average salary greater than 55000.
SELECT department_id, AVG(salary) as avg_salary
FROM employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- Query 28: Select years with more than 1 employee hired.
SELECT YEAR(hire_date) as hire_year, COUNT(*) as emp_count
FROM employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- Query 29: Select departments with a total salary expense less than 100000.
SELECT department_id, SUM(salary) as total_salary
FROM employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- Query 30: Select departments with the maximum salary above 75000.
SELECT department_id, MAX(salary) as max_salary
FROM employee
GROUP BY department_id
HAVING MAX(salary) > 75000;

-- Query 31: Select all employees ordered by their salary in ascending order.
SELECT *
FROM employee
ORDER BY salary ASC;

-- Query 32: Select all employees ordered by their age in descending order.
SELECT *
FROM employee
ORDER BY age DESC;

-- Query 33: Select all employees ordered by their hire date in ascending order.
SELECT *
FROM employee
ORDER BY hire_date ASC;

-- Query 34: Select employees ordered by their department and then by their salary.
SELECT *
FROM employee
ORDER BY department_id ASC, salary DESC;

-- Query 35: Select departments ordered by the total salary of their employees.
SELECT department_id, SUM(salary) as total_salary
FROM employee
GROUP BY department_id
ORDER BY total_salary DESC;

-- Query 36: Select employee names along with their department names.
SELECT e.name, d.name as department_name
FROM employee e
JOIN department d ON e.department_id = d.department_id;

-- Query 37: Select project names along with the department names they belong to.
SELECT p.name as project_name, d.name as department_name
FROM project p
JOIN department d ON p.department_id = d.department_id;

-- Query 38: Select employee names and their corresponding project names.
SELECT e.name as employee_name, p.name as project_name
FROM employee e
JOIN project p ON e.department_id = p.department_id;

-- Query 39: Select all employees and their departments, including those without a department.
SELECT e.name, d.name as department_name
FROM employee e
LEFT JOIN department d ON e.department_id = d.department_id;

-- Query 40: Select all departments and their employees, including departments without employees.
SELECT d.name as department_name, e.name as employee_name
FROM department d
LEFT JOIN employee e ON d.department_id = e.department_id;

-- Query 41: Select employees who are not assigned to any project.
SELECT e.name
FROM employee e
LEFT JOIN project p ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- Query 42: Select employees and the number of projects their department is working on.
SELECT e.name, COUNT(p.project_id) as project_count
FROM employee e
LEFT JOIN project p ON e.department_id = p.department_id
GROUP BY e.emp_id, e.name;

-- Query 43: Select the departments that have no employees.
SELECT d.name
FROM department d
LEFT JOIN employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- Query 44: Select employee names who share the same department with 'John Doe'.
SELECT DISTINCT e.name
FROM employee e
WHERE e.department_id = (SELECT department_id FROM employee WHERE name = 'John Doe')
AND e.name != 'John Doe';

-- Query 45: Select the department name with the highest average salary.
SELECT d.name
FROM department d
JOIN (
  SELECT department_id, AVG(salary) as avg_salary
  FROM employee
  GROUP BY department_id
  ORDER BY avg_salary DESC
  LIMIT 1
) sub ON d.department_id = sub.department_id;

-- Query 46: Select the employee with the highest salary.
SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

-- Query 47: Select employees whose salary is above the average salary.
SELECT *
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

-- Query 48: Select the second highest salary from the Employee table.
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Query 49: Select the department with the most employees.
SELECT d.name
FROM department d
JOIN (
  SELECT department_id, COUNT(*) as emp_count
  FROM employee
  GROUP BY department_id
  ORDER BY emp_count DESC
  LIMIT 1
) sub ON d.department_id = sub.department_id;

-- Query 50: Select employees who earn more than the average salary of their department.
SELECT e.name, e.salary, e.department_id
FROM employee e
WHERE e.salary > (
  SELECT AVG(salary)
  FROM employee
  WHERE department_id = e.department_id
);

-- Query 51: Select the nth highest salary (for example, 3rd highest).
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- Query 52: Select employees who are older than all employees in the HR department.
SELECT *
FROM employee
WHERE age > (
  SELECT MAX(age)
  FROM employee e
  JOIN department d ON e.department_id = d.department_id
  WHERE d.name = 'HR'
);

-- Query 53: Select departments where the average salary is greater than 55000.
SELECT d.name, AVG(e.salary) as avg_salary
FROM department d
JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
HAVING AVG(e.salary) > 55000;

-- Query 54: Select employees who work in a department with at least 2 projects.
SELECT DISTINCT e.name
FROM employee e
WHERE (
  SELECT COUNT(*)
  FROM project p
  WHERE p.department_id = e.department_id
) >= 2;

-- Query 55: Select employees who were hired on the same date as 'Jane Smith'.
SELECT *
FROM employee
WHERE hire_date = (SELECT hire_date FROM employee WHERE name = 'Jane Smith')
AND name != 'Jane Smith';

-- Query 56: Select the total salary of employees hired in the year 2020.
SELECT SUM(salary) as total_salary
FROM employee
WHERE YEAR(hire_date) = 2020;

-- Query 57: Select the average salary of employees in each department, ordered by the average salary in descending order.
SELECT d.name, AVG(e.salary) as avg_salary
FROM department d
JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
ORDER BY avg_salary DESC;

-- Query 58: Select departments with more than 1 employee and an average salary greater than 55000.
SELECT d.name, COUNT(e.emp_id) as emp_count, AVG(e.salary) as avg_salary
FROM department d
JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
HAVING COUNT(e.emp_id) > 1 AND AVG(e.salary) > 55000;

-- Query 59: Select employees hired in the last 2 years, ordered by their hire date.
SELECT *
FROM employee
WHERE hire_date >= DATEADD(YEAR, -2, GETDATE())
ORDER BY hire_date ASC;

-- Query 60: Select the total number of employees and the average salary for departments with more than 2 employees.
SELECT d.name, COUNT(e.emp_id) as total_employees, AVG(e.salary) as avg_salary
FROM department d
JOIN employee e ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
HAVING COUNT(e.emp_id) > 2;

-- Query 61: Select the name and salary of employees whose salary is above the average salary of their department.
SELECT e.name, e.salary
FROM employee e
WHERE e.salary > (
  SELECT AVG(salary)
  FROM employee
  WHERE department_id = e.department_id
);

-- Query 62: Select the names of employees who are hired on the same date as the oldest employee in the company.
SELECT name
FROM employee
WHERE hire_date = (
  SELECT hire_date
  FROM employee
  WHERE age = (SELECT MAX(age) FROM employee)
);

-- Query 63: Select the department names along with the total number of projects they are working on, ordered by the number of projects.
SELECT d.name, COUNT(p.project_id) as project_count
FROM department d
LEFT JOIN project p ON d.department_id = p.department_id
GROUP BY d.department_id, d.name
ORDER BY project_count DESC;

-- Query 64: Select the employee name with the highest salary in each department.
SELECT d.name as department_name, e.name as employee_name, e.salary
FROM department d
JOIN employee e ON d.department_id = e.department_id
WHERE (e.department_id, e.salary) IN (
  SELECT department_id, MAX(salary)
  FROM employee
  GROUP BY department_id
);

-- Query 65: Select the names and salaries of employees who are older than the average age of employees in their department.
SELECT e.name, e.salary, e.age
FROM employee e
WHERE e.age > (
  SELECT AVG(age)
  FROM employee
  WHERE department_id = e.department_id
);
