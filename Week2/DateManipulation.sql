
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    order_timestamp TIMESTAMP,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

-- ========== QUESTION 2: Insert Sample Data ==========
INSERT INTO orders VALUES
(1, 'Karthik', '2024-01-15', '2024-01-15 10:30:45', '2024-01-20', 2500.00),
(2, 'Veena', '2024-02-18', '2024-02-18 18:45:20', '2024-02-22', 3200.50),
(3, 'Ravi', '2024-03-02', '2024-03-02 09:15:10', '2024-03-08', 4100.75),
(4, 'Anil', '2024-03-09', '2024-03-09 14:05:55', '2024-03-15', 1800.00),
(5, 'Suresh', '2024-01-07', '2024-01-07 23:55:00', '2024-01-12', 2900.00);

-- ========== QUESTION 3: CURRENT DATE & TIME FUNCTIONS ==========
-- Get current date
SELECT CURDATE() AS current_date;

SELECT CURRENT_DATE() AS current_date_alt;

-- Get current time
SELECT CURTIME() AS current_time;

SELECT CURRENT_TIME() AS current_time_alt;

-- Get current date + time
SELECT NOW() AS current_datetime;

SELECT CURRENT_TIMESTAMP AS current_timestamp_alt;

-- Display all together
SELECT 
    CURDATE() AS current_date,
    CURTIME() AS current_time,
    NOW() AS current_datetime
FROM orders LIMIT 1;


SELECT 
    order_id,
    order_date AS date_type,
    order_timestamp AS timestamp_type,
    delivery_date AS date_type2,
    DATE(order_timestamp) AS extracted_date_from_timestamp
FROM orders;

-- ========== QUESTION 5: EXTRACTING YEAR, MONTH, DAY ==========
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM orders;

-- ========== QUESTION 6: EXTRACT USING EXTRACT() ==========
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS extracted_year,
    EXTRACT(MONTH FROM order_date) AS extracted_month,
    EXTRACT(DAY FROM order_date) AS extracted_day,
    EXTRACT(HOUR FROM order_timestamp) AS extracted_hour,
    EXTRACT(MINUTE FROM order_timestamp) AS extracted_minute,
    EXTRACT(SECOND FROM order_timestamp) AS extracted_second
FROM orders;

-- ========== QUESTION 7: MONTH NAME AND DAY NAME ==========
SELECT
    order_id,
    order_date,
    MONTHNAME(order_date) AS month_name,
    DAYNAME(order_date) AS day_name,
    CONCAT(DAYNAME(order_date), ', ', MONTHNAME(order_date), ' ', DAY(order_date), ', ', YEAR(order_date)) AS formatted_date
FROM orders;

-- ========== QUESTION 8: WEEKDAY AND DAY OF WEEK ==========
-- WEEKDAY: 0=Monday, 1=Tuesday, ... 6=Sunday
-- DAYOFWEEK: 1=Sunday, 2=Monday, ... 7=Saturday

SELECT
    order_id,
    order_date,
    WEEKDAY(order_date) AS weekday_number,
    DAYOFWEEK(order_date) AS day_of_week_number,
    DAYNAME(order_date) AS day_name,
    CASE 
        WHEN WEEKDAY(order_date) = 0 THEN 'Monday'
        WHEN WEEKDAY(order_date) = 1 THEN 'Tuesday'
        WHEN WEEKDAY(order_date) = 2 THEN 'Wednesday'
        WHEN WEEKDAY(order_date) = 3 THEN 'Thursday'
        WHEN WEEKDAY(order_date) = 4 THEN 'Friday'
        WHEN WEEKDAY(order_date) = 5 THEN 'Saturday'
        WHEN WEEKDAY(order_date) = 6 THEN 'Sunday'
    END AS weekday_name
FROM orders;

-- ========== QUESTION 9: IDENTIFY WEEKENDS (SATURDAY & SUNDAY) ==========
-- Method 1: Using DAYNAME
SELECT 
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    'Weekend' AS day_type
FROM orders
WHERE DAYNAME(order_date) IN ('Saturday', 'Sunday');

-- Method 2: Using DAYOFWEEK
SELECT 
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    'Weekend' AS day_type
FROM orders
WHERE DAYOFWEEK(order_date) IN (1, 7);

-- Method 3: Combined with non-weekend orders for comparison
SELECT
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    CASE 
        WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS order_day_type
FROM orders
ORDER BY order_date;

-- ========== QUESTION 10: IDENTIFY WEEKDAYS ==========
SELECT 
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    'Weekday' AS day_type
FROM orders
WHERE DAYOFWEEK(order_date) BETWEEN 2 AND 6;

-- Alternative using WEEKDAY function (0-4 = Monday to Friday)
SELECT 
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    'Weekday' AS day_type
FROM orders
WHERE WEEKDAY(order_date) BETWEEN 0 AND 4;

-- Combined weekday analysis
SELECT
    order_id,
    customer_name,
    order_date,
    DAYNAME(order_date) AS day_name,
    CASE 
        WHEN DAYOFWEEK(order_date) BETWEEN 2 AND 6 THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_classification
FROM orders
ORDER BY order_date;
