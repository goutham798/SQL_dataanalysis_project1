-- =============================================================
-- Create Database and Tables
-- =============================================================
-- Script Purpose:
--     Creates 'DataWarehouseAnalytics' database (drops if exists),
--     then creates and loads dim_customers, dim_products, fact_sales.
--
-- WARNING:
--     This will permanently delete the existing database if it exists.
--     Ensure you have backups before running.
-- =============================================================

-- Drop and recreate the database
DROP DATABASE IF EXISTS DataWarehouseAnalytics;
CREATE DATABASE DataWarehouseAnalytics;
USE DataWarehouseAnalytics;

-- =============================================================
-- NOTE: MySQL does not support schemas within a database.
-- The 'gold' schema is removed. Tables are created directly
-- inside the DataWarehouseAnalytics database.
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
    product_key     INT,
    product_id      INT,
    product_number  VARCHAR(50),
    product_name    VARCHAR(50),
    category_id     VARCHAR(50),
    category        VARCHAR(50),
    subcategory     VARCHAR(50),
    maintenance     VARCHAR(50),
    cost            INT,
    product_line    VARCHAR(50),
    start_date      DATE
);

-- Create fact_sales table
CREATE TABLE fact_sales (
    order_number    VARCHAR(50),
    product_key     INT,
    customer_key    INT,
    order_date      DATE,
    shipping_date   DATE,
    due_date        DATE,
    sales_amount    INT,
    quantity        TINYINT,
    price           INT
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

SHOW VARIABLES LIKE 'local_infile';
select * from fact_sales;
