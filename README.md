# SQL Sales & Exploratory Data Analysis Project

## Project Overview

This project focuses on performing comprehensive sales data analysis and exploratory data analysis (EDA) using MySQL.

The objective of the project is to transform raw transactional data into meaningful business insights through SQL queries, analytical reporting, KPI tracking, segmentation analysis, and trend analysis.

The project combines:
- Exploratory Data Analysis (EDA)
- Business KPI Reporting
- Customer Analytics
- Product Performance Analysis
- Sales Trend Analysis
- Segmentation Analysis
- Reporting Views

The project demonstrates practical SQL skills commonly used in real-world data analyst and business intelligence roles.

---

# Project Objectives

The main goals of this project are:

- Explore and understand the dataset structure
- Analyze customer behavior and purchasing trends
- Evaluate product and category performance
- Generate business KPIs
- Perform trend and time-series analysis
- Build customer and product reports
- Apply advanced SQL analytical techniques

---

# Database Tables Used

## 1. `fact_sales`
Contains transactional sales records.

## 2. `dim_customers`
Contains customer demographic and profile information.

## 3. `dim_products`
Contains product and category information.

---

# 2. Dimension Exploration

## Objective
Understand customer and product dimensions.

## Analysis Performed
- Explore customer countries
- Explore product categories and subcategories
- Analyze product catalog structure

# 3. Date Exploration

## Objective
Analyze date ranges and customer age information.

## Analysis Performed
- Find first and last sales dates
- Calculate business operational timeline
- Find youngest and oldest customers

---

# 4. Measure Exploration

## Objective
Generate core business KPIs.

## Analysis Performed
- Total sales
- Total quantity sold
- Average selling price
- Total orders
- Total products
- Total customers
- Business KPI summary report

## SQL Concepts Used
- `SUM()`
- `AVG()`
- `COUNT()`
- `UNION ALL`

---

# 5. Magnitude Analysis

## Objective
Analyze business performance distribution across dimensions.

## Analysis Performed
- Customers by country
- Customers by gender
- Products by category
- Average product cost per category
- Revenue by category
- Revenue by customer
- Product sales distribution across countries

## SQL Concepts Used
- `GROUP BY`
- Aggregate Functions
- Joins

---

# 6. Rank Analysis

## Objective
Identify top and bottom business performers.

## Analysis Performed
- Top 5 revenue-generating products
- Lowest-performing products
- Customers with the fewest orders

## SQL Concepts Used
- Window Functions
- `ROW_NUMBER()`
- Ranking Analysis

---

# 7. Change Over Time Analysis

## Objective
Analyze sales performance over time.

## Analysis Performed
- Monthly sales trends
- Running cumulative sales
- Sales growth tracking
- Time-series analysis

## SQL Concepts Used
- `GROUP BY`
- `SUM()`
- Window Functions
- `OVER()`
- Date Functions

---

# 8. Cumulative Sales Analysis

## Objective
Track cumulative business performance.

## Analysis Performed
- Running total sales
- Progressive revenue tracking
- Monthly cumulative growth

## SQL Concepts Used
- Window Functions
- `SUM() OVER()`

---

# 9. Moving Average Analysis

## Objective
Smooth fluctuations and identify sales trends.

## Analysis Performed
- Monthly average price
- Moving average trend analysis
- Trend stabilization analysis

## SQL Concepts Used
- `AVG()`
- Window Functions

---

# 10. Product Performance Analysis

## Objective
Evaluate yearly product sales performance.

## Analysis Performed
- Compare yearly sales to average product sales
- Compare yearly sales with previous year performance
- Identify increasing and decreasing product trends
- Year-over-year analysis

## SQL Concepts Used
- CTEs
- `LAG()`
- Window Functions
- CASE Statements

---

# 11. Part-to-Whole Analysis

## Objective
Understand category contribution to total business revenue.

## Analysis Performed
- Category-wise sales contribution
- Percentage contribution analysis
- Revenue distribution tracking

## SQL Concepts Used
- Window Functions
- Aggregate Functions
- Percentage Calculations

---

# 12. Product Segmentation Analysis

## Objective
Segment products based on cost ranges.

## Analysis Performed

### Product Segments
- Below 100
- 100–500
- 500–1000
- Above 1000

## SQL Concepts Used
- CASE Statements
- Aggregations

---

# 13. Customer Segmentation Analysis

## Objective
Classify customers based on purchasing behavior and lifespan.

## Customer Categories
- VIP Customers
- Regular Customers
- New Customers

## Segmentation Rules
- VIP → Lifespan >= 12 months and spending > 5000
- Regular → Lifespan >= 12 months and spending <= 5000
- New → Lifespan < 12 months

## SQL Concepts Used
- CTEs
- `TIMESTAMPDIFF()`
- CASE Statements
- Aggregate Functions

---

# 14. Customer Report Generation

## Objective
Build a consolidated customer analytics report.

## Metrics Included
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

## SQL Concepts Used
- Views
- CTEs
- Aggregate Functions
- Date Functions

---

# 15. Product Report Generation

## Objective
Build a product-level business performance report.

## Metrics Included
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

## Product Categories
- High-Performers
- Mid-Range
- Low-Performers

## SQL Concepts Used
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
- KPI Reporting
- Data Segmentation
- Ranking Analysis
- Time-Series Analysis
- Business Analysis
- Exploratory Data Analysis (EDA)
- Analytical Reporting

---

# Tools Used

- MySQL
- MySQL Workbench
- GitHub

---

# Repository Structure

```text
SQL_sales_eda_project/
│
├── datasets/
│   ├── dim_customers.csv
│   ├── dim_products.csv
│   └── fact_sales.csv
│
├── docs/
│   ├── database_creation.sql
│   ├── exploratory_data_analysis.sql
│   ├── sales_analysis.sql
│   ├── customer_report.sql
│   ├── product_report.sql
│   └── final_clean_project.sql
│
└── README.md
```

---

# Key Business Insights Generated

- Identified top-performing products and categories
- Tracked monthly sales growth trends
- Evaluated customer purchasing behavior
- Segmented customers based on value and loyalty
- Generated business KPI dashboards using SQL
- Measured category contribution to total revenue
- Evaluated product sales performance over time

---

# Learning Outcomes

Through this project, I improved skills in:

- Writing advanced SQL queries
- Solving business problems with SQL
- Building analytical reports
- Using window functions effectively
- Performing exploratory data analysis
- Creating reusable SQL views
- Understanding real-world business metrics

---

# Author

## Goutham S

Aspiring Data Analyst focused on SQL, business analytics, and data visualization projects.
