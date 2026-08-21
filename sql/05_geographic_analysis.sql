-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 05_geographic_analysis.sql
-- Purpose: Analyze revenue and profitability by country
-- Database: MySQL
-- ============================================================


-- 1. Performance by country

SELECT
    r.Country,
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
GROUP BY r.Country
ORDER BY profit DESC;


-- 2. Top 10 countries by revenue

SELECT
    r.Country,
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
GROUP BY r.Country
ORDER BY revenue DESC
LIMIT 10;


-- 3. Top 10 countries by profit margin
-- Countries with very small revenue can produce misleadingly
-- high margins, so revenue is included for context.

SELECT
    r.Country,
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
GROUP BY r.Country
ORDER BY profit_margin_percentage DESC
LIMIT 10;
