
CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

SELECT 
    emp_id,
    CONCAT(UPPER(SUBSTR(emp_name,1,1)), LOWER(SUBSTR(emp_name,2))) AS emp_name_proper,
    department,
    ROUND(base_salary + IFNULL(bonus, 0)) AS total_income,
    YEAR(joining_date) AS joining_year,
    CASE 
        WHEN YEAR(CURDATE()) - YEAR(joining_date) > 7 THEN 'Senior'
        WHEN YEAR(CURDATE()) - YEAR(joining_date) BETWEEN 4 AND 7 THEN 'Mid'
        ELSE 'Junior'
    END AS experience_level
FROM employee_payments;

-- ========== QUESTION 2: Order Delivery Delay Analysis ==========
CREATE TABLE orders_delivery (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

SELECT 
    order_id,
    UPPER(customer_name) AS customer_name_upper,
    DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) AS delivery_days,
    IFNULL(delivery_date, CURDATE()) AS delivery_date_filled,
    TRUNCATE(order_amount, 1) AS order_amount_truncated,
    CASE 
        WHEN DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) = 0 THEN 'Same-day'
        WHEN DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) > 3 THEN 'Delayed'
        WHEN delivery_date IS NULL THEN 'Pending'
        ELSE 'On-time'
    END AS delivery_status
FROM orders_delivery;

-- ========== QUESTION 3: Customer Spending Pattern ==========
CREATE TABLE customer_spending (
    cust_id INT,
    cust_name VARCHAR(50),
    city VARCHAR(30),
    purchase_amount DECIMAL(10,2),
    purchase_date DATE
);

INSERT INTO customer_spending VALUES
(1,'amit','mumbai',12000.75,'2024-12-01'),
(2,'neha','delhi',8500.40,'2024-12-15'),
(3,'rohit','mumbai',15500.90,'2024-11-20'),
(4,'kavya','chennai',6000.10,'2024-10-05');

SELECT 
    cust_id,
    CONCAT(UPPER(SUBSTR(cust_name,1,1)), LOWER(SUBSTR(cust_name,2))) AS cust_name_proper,
    city,
    DATE_FORMAT(purchase_date, '%M') AS purchase_month,
    ROUND(purchase_amount) AS purchase_amount_rounded,
    ABS(purchase_amount) AS purchase_amount_abs,
    CASE 
        WHEN purchase_amount > 15000 THEN 'High spender'
        WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium'
        ELSE 'Low'
    END AS spending_category
FROM customer_spending;

-- ========== QUESTION 4: Subscription Validity Check ==========
CREATE TABLE subscriptions (
    user_id INT,
    user_email VARCHAR(100),
    start_date DATE,
    end_date DATE,
    subscription_fee DECIMAL(10,2)
);

INSERT INTO subscriptions VALUES
(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),
(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),
(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

SELECT 
    user_id,
    SUBSTR(user_email, POSITION('@' IN user_email) + 1) AS email_domain,
    DATEDIFF(end_date, start_date) / 30.44 AS subscription_months,
    FORMAT(subscription_fee, 2) AS fee_formatted,
    DATEDIFF(end_date, CURDATE()) AS remaining_days,
    CASE 
        WHEN end_date >= CURDATE() AND DATEDIFF(end_date, CURDATE()) > 30 THEN 'Active'
        WHEN end_date >= CURDATE() AND DATEDIFF(end_date, CURDATE()) <= 30 THEN 'Expiring Soon'
        ELSE 'Expired'
    END AS subscription_status
FROM subscriptions;

-- ========== QUESTION 5: Loan EMI Risk Categorization ==========
CREATE TABLE loan_details (
    loan_id INT,
    customer_name VARCHAR(50),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_start DATE
);

INSERT INTO loan_details VALUES
(201,'suresh',500000.75,8.5,'2022-01-10'),
(202,'mahesh',750000.40,9.2,'2021-05-20'),
(203,'anita',300000.90,7.8,'2023-07-01');

SELECT 
    loan_id,
    UPPER(customer_name) AS customer_name_upper,
    loan_amount,
    interest_rate,
    (loan_amount * interest_rate / 100) / 12 AS monthly_interest,
    YEAR(CURDATE()) - YEAR(loan_start) AS years_since_start,
    ROUND((loan_amount * (interest_rate / 100 / 12)) / (1 - POWER(1 + (interest_rate / 100 / 12), -60))) AS emi_rounded,
    CASE 
        WHEN interest_rate > 9 THEN 'High Risk'
        WHEN interest_rate BETWEEN 7 AND 9 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM loan_details;

-- ========== QUESTION 6: Employee Attendance Evaluation ==========
CREATE TABLE attendance (
    emp_id INT,
    emp_name VARCHAR(50),
    total_days INT,
    present_days INT,
    record_date DATE
);

INSERT INTO attendance VALUES
(1,'karthik',30,28,'2025-01-31'),
(2,'veena',30,22,'2025-01-31'),
(3,'ravi',30,18,'2025-01-31');

SELECT 
    emp_id,
    LOWER(emp_name) AS emp_name_lower,
    total_days,
    present_days,
    DATE_FORMAT(record_date, '%M') AS month_name,
    ROUND((present_days / total_days) * 100, 2) AS attendance_percentage,
    (total_days - present_days) AS days_absent,
    CASE 
        WHEN (present_days / total_days) * 100 >= 90 THEN 'Excellent'
        WHEN (present_days / total_days) * 100 BETWEEN 75 AND 89 THEN 'Average'
        ELSE 'Poor'
    END AS attendance_rating
FROM attendance;

-- ========== QUESTION 7: Product Discount Validation ==========
CREATE TABLE product_sales (
    product_id INT,
    product_name VARCHAR(50),
    mrp DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO product_sales VALUES
(1,'Laptop',75000.75,68000.50,'2025-01-10'),
(2,'Mobile',35000.40,33000.25,'2025-01-12'),
(3,'Tablet',25000.90,26000.75,'2025-01-15');

SELECT 
    product_id,
    CONCAT(UPPER(SUBSTR(product_name,1,1)), LOWER(SUBSTR(product_name,2))) AS product_name_proper,
    mrp,
    selling_price,
    ABS(mrp - selling_price) AS discount_amount,
    ROUND((ABS(mrp - selling_price) / mrp) * 100, 2) AS discount_percentage,
    DATE_FORMAT(sale_date, '%W') AS sale_day,
    CASE 
        WHEN selling_price < mrp THEN 'Valid Discount'
        WHEN selling_price > mrp THEN 'Overpriced'
        ELSE 'No Discount'
    END AS discount_status
FROM product_sales;

-- ========== QUESTION 8: Insurance Policy Aging ==========
CREATE TABLE insurance_policies (
    policy_id INT,
    holder_name VARCHAR(50),
    premium_amount DECIMAL(10,2),
    policy_start DATE,
    policy_end DATE
);

INSERT INTO insurance_policies VALUES
(301,'arjun',12000.50,'2023-01-01','2026-01-01'),
(302,'megha',8500.75,'2022-06-15','2025-06-15'),
(303,'vinod',15000.90,'2021-03-01','2024-03-01');

SELECT 
    policy_id,
    UPPER(holder_name) AS holder_name_upper,
    premium_amount,
    policy_start,
    policy_end,
    ROUND(DATEDIFF(policy_end, policy_start) / 365.25, 1) AS policy_duration_years,
    DATEDIFF(policy_end, CURDATE()) AS remaining_days,
    ROUND(premium_amount) AS premium_rounded,
    CASE 
        WHEN DATEDIFF(policy_end, policy_start) / 365.25 >= 3 THEN 'Long Term'
        WHEN DATEDIFF(policy_end, policy_start) / 365.25 BETWEEN 1 AND 3 THEN 'Mid Term'
        ELSE 'Expired'
    END AS policy_category
FROM insurance_policies;

-- ========== QUESTION 9: Salary Increment Simulation ==========
CREATE TABLE salary_revision (
    emp_id INT,
    emp_name VARCHAR(50),
    current_salary DECIMAL(10,2),
    rating INT,
    last_hike DATE
);

INSERT INTO salary_revision VALUES
(1,'karthik',75000.75,5,'2023-01-01'),
(2,'veena',65000.40,4,'2024-01-01'),
(3,'ravi',85000.90,3,'2022-01-01');

SELECT 
    emp_id,
    LOWER(emp_name) AS emp_name_lower,
    current_salary,
    rating,
    last_hike,
    YEAR(CURDATE()) - YEAR(last_hike) AS years_since_hike,
    ROUND(current_salary * (rating / 10)) AS increment_amount,
    ROUND(current_salary + (current_salary * (rating / 10))) AS new_salary,
    CASE 
        WHEN rating >= 5 THEN 'High Increment'
        WHEN rating BETWEEN 3 AND 4 THEN 'Moderate'
        ELSE 'No Increment'
    END AS increment_category
FROM salary_revision;

CREATE TABLE bank_accounts (
    account_id INT,
    customer_name VARCHAR(50),
    balance DECIMAL(12,2),
    last_transaction DATE,
    branch VARCHAR(30)
);

INSERT INTO bank_accounts VALUES
(501,'ramesh',125000.75,'2024-12-20','hyderabad'),
(502,'sita',8500.40,'2023-06-15','delhi'),
(503,'manoj',-2500.90,'2025-01-05','mumbai');

SELECT 
    account_id,
    CONCAT(UPPER(SUBSTR(customer_name,1,1)), LOWER(SUBSTR(customer_name,2))) AS customer_name_proper,
    balance,
    ABS(balance) AS absolute_balance,
    DATEDIFF(CURDATE(), last_transaction) AS days_since_transaction,
    CONCAT(UPPER(SUBSTR(branch,1,1)), LOWER(SUBSTR(branch,2))) AS branch_proper,
    SIGN(balance) AS balance_sign,
    CASE 
        WHEN balance > 0 AND DATEDIFF(CURDATE(), last_transaction) < 90 THEN 'Active'
        WHEN balance > 0 AND DATEDIFF(CURDATE(), last_transaction) >= 90 THEN 'Dormant'
        ELSE 'Overdrawn'
    END AS account_status
FROM bank_accounts;

    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    tax_percent DECIMAL(5,2),
    last_revision DATE
);
