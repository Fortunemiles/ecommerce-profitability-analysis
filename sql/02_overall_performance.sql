-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 02_overall_performance.sql
-- Purpose: Calculate overall business performance KPIs
-- Database: MySQL
-- ============================================================


-- 1. Overall business performance

SELECT
    COUNT(*) AS total_sales_records,
    SUM(Quantity) AS total_units_sold,
    ROUND(SUM(Quantity * `Unit sale price`), 2) AS total_revenue,
    ROUND(SUM(Quantity * `Unit price`), 2) AS total_list_value,
    ROUND(
        SUM(Quantity * `Unit price`)
        - SUM(Quantity * `Unit sale price`),
        2
    ) AS total_discount_value,
    ROUND(
        (
            SUM(
                Quantity * (`Unit price` - `Unit sale price`)
            )
            / SUM(Quantity * `Unit price`)
        ) * 100,
        2
    ) AS discount_percentage
FROM go_daily_sales;


-- 2. Revenue, cost and profit

SELECT
    ROUND(
        SUM(d.Quantity * d.`Unit sale price`),
        2
    ) AS total_revenue,

    ROUND(
        SUM(d.Quantity * p.`Unit cost`),
        2
    ) AS total_cost,

    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ),
        2
    ) AS total_profit,

    ROUND(
        (
            SUM(
                d.Quantity *
                (d.`Unit sale price` - p.`Unit cost`)
            )
            /
            SUM(d.Quantity * d.`Unit sale price`)
        ) * 100,
        2
    ) AS profit_margin_percentage

FROM go_daily_sales d
JOIN go_products p
    ON d.`Product number` = p.`Product number`;


-- 3. Date range

SELECT
    MIN(Date) AS earliest_date,
    MAX(Date) AS latest_date
FROM go_daily_sales;
