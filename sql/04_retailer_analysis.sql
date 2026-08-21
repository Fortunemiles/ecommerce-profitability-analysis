-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 04_retailer_analysis.sql
-- Purpose: Analyze retailer and retailer-type performance
-- Database: MySQL
-- ============================================================


-- 1. Top 10 retailers by profit

SELECT
    r.`Retailer name`,
    r.Country,
    r.Type AS retailer_type,
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
JOIN go_retailers r
    ON d.`Retailer code` = r.`Retailer code`
GROUP BY
    r.`Retailer name`,
    r.Country,
    r.Type
ORDER BY profit DESC
LIMIT 10;


-- 2. Performance by retailer type

SELECT
    r.Type AS retailer_type,
    COUNT(DISTINCT r.`Retailer code`) AS number_of_retailers,
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
JOIN go_retailers r
    ON d.`Retailer code` = r.`Retailer code`
GROUP BY r.Type
ORDER BY profit DESC;


-- 3. Average profit per retailer by retailer type

SELECT
    r.Type AS retailer_type,
    COUNT(DISTINCT r.`Retailer code`) AS number_of_retailers,
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit sale price` - p.`Unit cost`)
        )
        / COUNT(DISTINCT r.`Retailer code`),
        2
    ) AS average_profit_per_retailer
FROM go_daily_sales d
JOIN go_products p
    ON d.`Product number` = p.`Product number`
JOIN go_retailers r
    ON d.`Retailer code` = r.`Retailer code`
GROUP BY r.Type
ORDER BY average_profit_per_retailer DESC;
