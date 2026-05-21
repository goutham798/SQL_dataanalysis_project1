# SQL_dataanalysis_project1

# SQL Sales Data Analysis Project

## Project Overview

This project focuses on analyzing sales, customer behavior, and product performance using MySQL.

The objective of the project is to transform raw sales data into meaningful business insights through SQL queries, analytical reporting, and performance tracking techniques.

The project demonstrates practical SQL skills used in real-world data analyst roles, including:
- Data cleaning
- Data aggregation
- Business KPI analysis
- Customer segmentation
- Product performance evaluation
- Trend analysis
- Window functions
- Report generation

---

## Tables Used

### 1. `fact_sales`
Contains transactional sales data.

### 2. `dim_customers`
Contains customer-related information.

### 3. `dim_products`
Contains product-related information.

---

# Project Analysis Included

## 1. Change Over Time Analysis

### Objective
Analyze how sales change over time.

### Analysis Performed
- Monthly sales trends
- Running cumulative sales
- Sales growth tracking
- Time-series analysis

### SQL Concepts Used
- `GROUP BY`
- `SUM()`
- Window Functions
- `OVER()`
- Date Functions

---

## 2. Cumulative Sales Analysis

### Objective
Track cumulative sales performance over time.

### Analysis Performed
- Running total sales
- Progressive revenue tracking
- Monthly cumulative growth

### SQL Concepts Used
- Window Functions
- `SUM() OVER()`

---

## 3. Moving Average Analysis

### Objective
Smooth sales fluctuations and identify trends.

### Analysis Performed
- Monthly average price
- Moving average price trend
- Trend stabilization analysis

### SQL Concepts Used
- `AVG()`
- Window Functions

---

## 4. Product Performance Analysis

### Objective
Evaluate yearly product performance.

### Analysis Performed
- Compare current sales with average sales
- Compare current sales with previous year sales
- Identify increasing and decreasing product performance
- Year-over-year growth analysis

### SQL Concepts Used
- CTEs
- `LAG()`
- Window Functions
- CASE Statements

---

## 5. Part-to-Whole Analysis

### Objective
Understand category contribution to total revenue.

### Analysis Performed
- Category-wise total sales
- Percentage contribution to overall sales
- Revenue distribution analysis

### SQL Concepts Used
- Window Functions
- Aggregate Functions
- Percentage Calculations

---

## 6. Product Segmentation Analysis

### Objective
Segment products based on cost ranges.

### Analysis Performed
Products classified into:
- Below 100
- 100–500
- 500–1000
- Above 1000

### SQL Concepts Used
- CASE Statements
- Aggregations

---

## 7. Customer Segmentation Analysis

### Objective
Classify customers based on spending behavior and purchase history.

### Customer Categories
- VIP Customers
- Regular Customers
- New Customers

### Segmentation Rules
- VIP → Lifespan >= 12 months and spending > 5000
- Regular → Lifespan >= 12 months and spending <= 5000
- New → Lifespan < 12 months

### SQL Concepts Used
- CTEs
- `TIMESTAMPDIFF()`
- CASE Statements
- Aggregate Functions

---

## 8. Customer Report Generation

### Objective
Create a consolidated customer analytics report.

### Metrics Included
- Total orders
- Total sales
- Total quantity purchased
- Total products purchased
- Customer lifespan
- Recency analysis
- Average order value
- Average monthly spend
- Age groups
- Customer segments

### SQL Concepts Used
- Views
- CTEs
- Aggregate Functions
- Date Functions

---

## 9. Product Report Generation

### Objective
Create a product-level business performance report.

### Metrics Included
- Total orders
- Total sales
- Total quantity sold
- Total customers
- Product lifespan
- Recency analysis
- Average selling price
- Average order revenue
- Average monthly revenue
- Product performance category

### Product Categories
- High-Performers
- Mid-Range
- Low-Performers

### SQL Concepts Used
- Views
- CTEs
- Window Functions
- KPI Calculations

---

# SQL Skills Demonstrated

This project demonstrates proficiency in:

- SQL Joins
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- CASE Statements
- Date Functions
- Views
- KPI Calculations
- Business Analysis
- Data Segmentation
- Analytical Reporting

---

# Tools Used

- MySQL
- MySQL Workbench
- GitHub

---

# Repository Structure

```text
SQL_dataanalysis_project1/
│
├── datasets/
│   ├── dim_customers.csv
│   ├── dim_products.csv
│   └── fact_sales.csv
│
├── docs/
│   ├── DA_database_creation_pro1.sql
│   ├── analysis_queries.sql
│   ├── customer_report_pro1.sql
│   ├── Product_report_pro1.sql
│   └── DA_Project1_clean.sql
│
└── README.md
```
# Author

## Goutham S

Aspiring Data Analyst focused on SQL, business analytics, and data visualization projects.

---
