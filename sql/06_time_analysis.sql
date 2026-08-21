-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 06_time_analysis.sql
-- Purpose: Analyze revenue and profitability over time
-- Database: MySQL
-- ============================================================


-- 1. Annual performance

SELECT
    YEAR(d.Date) AS sales_year,
    ROUND(
        SUM(d.Quantity * d.`Unit sale price`),
        2
    ) AS revenue,
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ),
        2
    ) AS profit,
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        )
        / SUM(d.Quantity * d.`Unit sale price`) * 100,
        2
    ) AS profit_margin_percentage
FROM go_daily_sales d
JOIN go_products p
    ON d.`Product number` = p.`Product number`
GROUP BY YEAR(d.Date)
ORDER BY sales_year;


-- 2. Year-over-year revenue and profit growth

WITH yearly_sales AS (
    SELECT
        YEAR(d.Date) AS sales_year,
        SUM(d.Quantity * d.`Unit sale price`) AS revenue,
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ) AS profit
    FROM go_daily_sales d
    JOIN go_products p
        ON d.`Product number` = p.`Product number`
    GROUP BY YEAR(d.Date)
)

SELECT
    sales_year,
    ROUND(revenue, 2) AS revenue,
    ROUND(profit, 2) AS profit,
    ROUND(
        (
            revenue -
            LAG(revenue) OVER (ORDER BY sales_year)
        )
        /
        LAG(revenue) OVER (ORDER BY sales_year) * 100,
        2
    ) AS revenue_yoy_growth,
    ROUND(
        (
            profit -
            LAG(profit) OVER (ORDER BY sales_year)
        )
        /
        LAG(profit) OVER (ORDER BY sales_year) * 100,
        2
    ) AS profit_yoy_growth
FROM yearly_sales
ORDER BY sales_year;


-- 3. Monthly performance by year

SELECT
    YEAR(d.Date) AS sales_year,
    MONTH(d.Date) AS sales_month,
    MONTHNAME(d.Date) AS month_name,
    ROUND(
        SUM(d.Quantity * d.`Unit sale price`),
        2
    ) AS revenue,
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ),
        2
    ) AS profit
FROM go_daily_sales d
JOIN go_products p
    ON d.`Product number` = p.`Product number`
GROUP BY
    YEAR(d.Date),
    MONTH(d.Date),
    MONTHNAME(d.Date)
ORDER BY
    sales_year,
    sales_month;


-- 4. Overall monthly performance across all years

SELECT
    MONTH(d.Date) AS month_number,
    MONTHNAME(d.Date) AS month_name,
    ROUND(
        SUM(d.Quantity * d.`Unit sale price`),
        2
    ) AS total_revenue,
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ),
        2
    ) AS total_profit
FROM go_daily_sales d
JOIN go_products p
    ON d.`Product number` = p.`Product number`
GROUP BY
    MONTH(d.Date),
    MONTHNAME(d.Date)
ORDER BY total_revenue DESC;


-- 5. Average monthly performance across years

WITH monthly_data AS (
    SELECT
        YEAR(d.Date) AS sales_year,
        MONTH(d.Date) AS month_number,
        MONTHNAME(d.Date) AS month_name,
        SUM(d.Quantity * d.`Unit sale price`) AS monthly_revenue,
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        ) AS monthly_profit
    FROM go_daily_sales d
    JOIN go_products p
        ON d.`Product number` = p.`Product number`
    GROUP BY
        YEAR(d.Date),
        MONTH(d.Date),
        MONTHNAME(d.Date)
)

SELECT
    month_number,
    month_name,
    ROUND(
        AVG(monthly_revenue),
        2
    ) AS avg_monthly_revenue,
    ROUND(
        AVG(monthly_profit),
        2
    ) AS avg_monthly_profit
FROM monthly_data
GROUP BY
    month_number,
    month_name
ORDER BY avg_monthly_revenue DESC;
