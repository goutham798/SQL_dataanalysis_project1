-- =============================================================
-- Product Report
-- =============================================================
-- Purpose:
--   This report consolidates key product metrics and behaviors.
-- Highlights:
--   1. Gathers essential fields such as product name, category, subcategory, and cost.
--   2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
--   3. Aggregates product-level metrics:
--        total orders, total sales, total quantity sold,
--        total customers (unique), lifespan (in months)
--   4. Calculates valuable KPIs:
--        recency (months since last sale),
--        average order revenue (AOR), average monthly revenue
-- =============================================================

CREATE VIEW product_report AS
WITH Ist_query AS (
    SELECT
        product_name,
        category,
        subcategory,
        cost,
        COUNT(DISTINCT order_number)                                          AS total_orders,
        MAX(order_date)                                                       AS latest_date,
        SUM(sales_amount)                                                     AS total_sales,
        SUM(quantity)                                                         AS total_quantity,
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date))                AS lifespan,
        ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1)      AS avg_selling_price,
        COUNT(DISTINCT customer_key)                                          AS total_customer
    FROM      dim_products p
    LEFT JOIN fact_sales   s ON s.product_key = p.product_key
    GROUP BY
        product_name,
        category,
        subcategory,
        cost
    HAVING total_sales IS NOT NULL
       AND lifespan    IS NOT NULL
)
SELECT
    product_name,
    category,
    subcategory,
    cost,
    total_orders,
    total_customer,
    total_sales,
    total_quantity,
    lifespan,

    CASE
        WHEN total_sales > 50000  THEN 'High-Performers'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE                           'low-performence'
    END AS performence_type,

    TIMESTAMPDIFF(MONTH, latest_date, CURDATE()) AS recency_month,
    avg_selling_price,

    -- Average Order Revenue (AOR)
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue

FROM Ist_query;

SELECT * FROM product_report;