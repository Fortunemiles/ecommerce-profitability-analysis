-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 03_product_analysis.sql
-- Purpose: Analyze product and product-line performance
-- Database: MySQL
-- ============================================================


-- 1. Performance by product line

SELECT
    p.`Product line`,
    ROUND(SUM(d.Quantity * d.`Unit sale price`), 2) AS revenue,
    ROUND(
        SUM(d.Quantity * p.`Unit cost`),
        2
    ) AS cost,
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
GROUP BY p.`Product line`
ORDER BY profit DESC;


-- 2. Top 10 products by profit

SELECT
    p.`Product`,
    p.`Product line`,
    p.`Product brand`,
    SUM(d.Quantity) AS units_sold,
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
GROUP BY
    p.`Product`,
    p.`Product line`,
    p.`Product brand`
ORDER BY profit DESC
LIMIT 10;


-- 3. Top 10 products by units sold

SELECT
    p.`Product`,
    p.`Product line`,
    p.`Product brand`,
    SUM(d.Quantity) AS units_sold,
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
GROUP BY
    p.`Product`,
    p.`Product line`,
    p.`Product brand`
ORDER BY units_sold DESC
LIMIT 10;


-- 4. Product line performance by units sold

SELECT
    p.`Product line`,
    SUM(d.Quantity) AS units_sold,
    COUNT(DISTINCT p.`Product number`) AS number_of_products,
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
GROUP BY p.`Product line`
ORDER BY units_sold DESC;
