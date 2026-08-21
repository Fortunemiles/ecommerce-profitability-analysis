-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 07_order_method_analysis.sql
-- Purpose: Analyze performance by order method
-- Database: MySQL
-- ============================================================


-- 1. Performance by order method

SELECT
    m.`Order method type` AS order_method,
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
JOIN go_methods m
    ON d.`Order method code` = m.`Order method code`
GROUP BY m.`Order method type`
ORDER BY profit DESC;


-- 2. Order methods ranked by revenue

SELECT
    m.`Order method type` AS order_method,
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
JOIN go_methods m
    ON d.`Order method code` = m.`Order method code`
GROUP BY m.`Order method type`
ORDER BY revenue DESC;


-- 3. Order methods ranked by profit margin

SELECT
    m.`Order method type` AS order_method,
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
JOIN go_methods m
    ON d.`Order method code` = m.`Order method code`
GROUP BY m.`Order method type`
ORDER BY profit_margin_percentage DESC;
