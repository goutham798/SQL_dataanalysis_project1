-- =============================================================
-- Create Database and Tables
-- =============================================================
-- Script Purpose:
--     Creates 'DataAnalytics' database (drops if exists),
--     then creates and loads dim_customers, dim_products, fact_sales.
--
-- WARNING:
--     This will permanently delete the existing database if it exists.
--     Ensure you have backups before running.
-- =============================================================

DROP DATABASE IF EXISTS DataAnalytics;
CREATE DATABASE DataAnalytics;
USE DataAnalytics;

-- =============================================================
-- NOTE: MySQL does not support schemas within a database.
-- The 'gold' schema is removed. Tables are created directly
-- inside the DataAnalytics database.
-- =============================================================

-- Create dim_customers table
CREATE TABLE dim_customers (
    customer_key    INT,
    customer_id     INT,
    customer_number VARCHAR(50),
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    country         VARCHAR(50),
    marital_status  VARCHAR(50),
    gender          VARCHAR(50),
    birthdate       DATE,
    create_date     DATE
);

-- Create dim_products table
CREATE TABLE dim_products (
    product_key    INT,
    product_id     INT,
    product_number VARCHAR(50),
    product_name   VARCHAR(50),
    category_id    VARCHAR(50),
    category       VARCHAR(50),
    subcategory    VARCHAR(50),
    maintenance    VARCHAR(50),
    cost           INT,
    product_line   VARCHAR(50),
    start_date     DATE
);

-- Create fact_sales table
CREATE TABLE fact_sales (
    order_number  VARCHAR(50),
    product_key   INT,
    customer_key  INT,
    order_date    DATE,
    shipping_date DATE,
    due_date      DATE,
    sales_amount  INT,
    quantity      TINYINT,
    price         INT
);

-- =============================================================
-- Load Data (BULK INSERT → LOAD DATA INFILE in MySQL)
-- Use forward slashes in file paths
-- =============================================================

TRUNCATE TABLE dim_customers;
LOAD DATA LOCAL INFILE '/Users/goutham/Downloads/sql projects/sql-data-analytics-project/datasets/flat-files/dim_customers.csv'
INTO TABLE dim_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE dim_products;
LOAD DATA LOCAL INFILE '/Users/goutham/Downloads/sql projects/sql-data-analytics-project/datasets/flat-files/dim_products.csv'
INTO TABLE dim_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE fact_sales;
LOAD DATA LOCAL INFILE '/Users/goutham/Downloads/sql projects/sql-data-analytics-project/datasets/flat-files/fact_sales.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =============================================================
-- Change_Overtime & Cumulative_Analysis
-- =============================================================
-- Calculate the total sales per month
-- and running total sales over time

SELECT
    LOWER(
        DATE_FORMAT(
            STR_TO_DATE(CONCAT(order_year, '-', order_month, '-1'), '%Y-%m-%d'),
            '%Y-%b'
        )
    )         AS order_date,
    totalsales
FROM (
    SELECT
        YEAR(order_date)  AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sales_amount) AS totalsales
    FROM  fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_year, order_month
) AS monthly_sales;


-- Moving average
SELECT
    CONCAT(order_year, '-', order_month)                         AS order_dates,
    totalsales,
    SUM(totalsales) OVER (ORDER BY order_year, order_month)      AS running_total_sales,
    avgprice,
    AVG(avgprice)   OVER (ORDER BY order_year, order_month)      AS moving_avg_price
FROM (
    SELECT
        YEAR(order_date)  AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sales_amount) AS totalsales,
        AVG(price)        AS avgprice
    FROM  fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
) AS monthly_sales;


-- =============================================================
-- Performance Analysis
-- =============================================================
-- Analyze the yearly performance of products by comparing their sales
-- to both the average sales performance of the product and the previous year's sales

WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM      fact_sales   f
    LEFT JOIN dim_products p ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY YEAR(f.order_date), p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,

    ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 0)
        AS avg_sales,

    current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 0)
        AS diff_avg,

    CASE
        WHEN current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 0) > 0 THEN 'Above Avg'
        WHEN current_sales - ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 0) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_sales_indicator,

    -- Year to Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)
        AS py_sales_Diff,

    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)
        AS py_sales,

    CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increasing'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decreasing'
        ELSE 'No Change'
    END AS py_sales_indicator

FROM  yearly_product_sales
ORDER BY product_name, order_year;


-- =============================================================
-- Part_to_Whole Analysis
-- =============================================================
-- Which categories contribute most to overall sales

WITH category_sales AS (
    SELECT
        category,
        SUM(sales_amount) AS total_sales
    FROM      fact_sales   f
    LEFT JOIN dim_products p ON p.product_key = f.product_key
    GROUP BY category
    ORDER BY total_sales DESC
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER ()                                                              AS overall_sales,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), '%') AS percentage_of_oversales
FROM category_sales;


-- =============================================================
-- Data Segmentation
-- =============================================================
-- Segment products into cost ranges and
-- count how many products fall into each segment

WITH cost_segment AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100                THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500  THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE                                'above 1000'
        END AS cost_range
    FROM dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM  cost_segment
GROUP BY cost_range
ORDER BY total_products DESC;


-- =============================================================
-- Data Segmentation
-- =============================================================
-- Group customers into three segments based on their spending behavior:
--   VIP     : Customers with at least 12 months of history and spending more than €5,000.
--   Regular : Customers with at least 12 months of history but spending €5,000 or less.
--   New     : Customers with a lifespan less than 12 months.
-- Find the total number of customers by each group.

WITH customer_summary AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount)                                        AS total_spending,
        MIN(f.order_date)                                          AS first_order,
        MAX(f.order_date)                                          AS last_order,
        TIMESTAMPDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) AS lifespan
    FROM      fact_sales   f
    LEFT JOIN dim_customers c ON c.customer_key = f.customer_key
    GROUP BY c.customer_key
)
SELECT
    customer_key,
    total_spending,
    lifespan,
    CASE
        WHEN lifespan >= 12 AND total_spending > 5000  THEN 'VIP'
        WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
        ELSE                                                'New'
    END AS customer_segment
FROM  customer_summary
ORDER BY total_spending DESC;


-- Find the total number of customers by each group

WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount)                                        AS total_spending,
        MIN(order_date)                                            AS first_order,
        MAX(order_date)                                            AS last_order,
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date))     AS lifespan
    FROM      fact_sales   f
    LEFT JOIN dim_customers c ON c.customer_key = f.customer_key
    GROUP BY c.customer_key
    ORDER BY lifespan DESC
)
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT
        customer_key,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000  THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE                                                'New'
        END AS customer_segment
    FROM customer_spending
) t
GROUP BY  customer_segment
ORDER BY  total_customers;
