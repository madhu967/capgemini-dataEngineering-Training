
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    dept_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
(1, 'Karthik', NULL, 1),
(2, 'Ajay', 1, 1),
(3, 'Vijay', 1, 2),
(4, 'Vinay', 2, 2),
(5, 'Meena', 3, 3),
(6, 'Veer', NULL, 4),
(7, 'Keerthi', 4, 5),
(8, 'Priya', 4, 5);

-- ========== Table 2: departments ==========
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

-- ========== Table 3: projects ==========
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO projects (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 4),
(5, 'Project E', 5);

-- ========== Table 4: employee_salaries (for questions needing salary data) ==========
CREATE TABLE employee_salaries (
    emp_id INT PRIMARY KEY,
    salary DECIMAL(10,2)
);

INSERT INTO employee_salaries (emp_id, salary) VALUES
(1, 50000.00),
(2, 45000.00),
(3, 55000.00),
(4, 48000.00),
(5, 60000.00),
(6, 52000.00);

CREATE TABLE employee_contacts (
    emp_id INT PRIMARY KEY,
    phone VARCHAR(15),
    email VARCHAR(50)
);

INSERT INTO employee_contacts (emp_id, phone, email) VALUES
(1, '9876543210', 'karthik@company.com'),
(2, '9876543211', 'ajay@company.com'),
(3, '9876543212', 'vijay@company.com'),
(4, '9876543213', 'vinay@company.com'),
(5, '9876543214', 'meena@company.com');


SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
    e.manager_id,
    m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;


SELECT 
    e.emp_id,
    e.emp_name,
    e.dept_id,
    d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
    m.emp_id AS manager_id,
    m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;


SELECT 
    d.dept_id,
    d.dept_name,
    e.emp_id,
    e.emp_name,
    s.salary
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_salaries s ON e.emp_id = s.emp_id
ORDER BY d.dept_id;


SELECT 
    e.emp_id,
    e.emp_name,
    e.dept_id,
    d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL OR e.dept_id IS NULL
ORDER BY e.emp_id;


SELECT 
    e.emp_id,
    e.emp_name,
    p.project_id,
    p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
ORDER BY e.emp_id;


SELECT 
    e.emp_id,
    e.emp_name,
    p.project_id,
    p.project_name
FROM employees e
INNER JOIN projects p ON e.emp_id = p.emp_id
ORDER BY e.emp_id;


SELECT 
    e.emp_id,
    e.emp_name,
    p.project_id,
    p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id
ORDER BY p.project_id;


SELECT 
    e.emp_id,
    e.emp_name,
    s.salary
FROM employees e
LEFT JOIN employee_salaries s ON e.emp_id = s.emp_id
ORDER BY e.emp_id;



SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_id,
    d.dept_name,
    CASE 
        WHEN d.dept_name IS NULL THEN 'Unassigned'
        ELSE d.dept_name
    END AS department_status
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

