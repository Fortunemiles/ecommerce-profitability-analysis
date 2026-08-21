-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 01_data_validation.sql
-- Purpose: Validate the dataset before analysis
-- Database: MySQL
-- ============================================================


-- 1. Check available tables
SHOW TABLES;


-- 2. Check date range
SELECT
    MIN(Date) AS earliest_date,
    MAX(Date) AS latest_date
FROM go_daily_sales;


-- 3. Count sales records
SELECT
    COUNT(*) AS total_sales_records
FROM go_daily_sales;


-- 4. Count total quantity sold
SELECT
    SUM(Quantity) AS total_quantity_sold
FROM go_daily_sales;


-- 5. Check for duplicate sales records
SELECT
    `Retailer code`,
    `Product number`,
    Date,
    COUNT(*) AS record_count
FROM go_daily_sales
GROUP BY
    `Retailer code`,
    `Product number`,
    Date
HAVING COUNT(*) > 1;


-- 6. Check for NULL values in the main sales table
SELECT
    SUM(`Retailer code` IS NULL) AS null_retailer_code,
    SUM(`Product number` IS NULL) AS null_product_number,
    SUM(`Order method code` IS NULL) AS null_order_method_code,
    SUM(Date IS NULL) AS null_date,
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(`Unit price` IS NULL) AS null_unit_price,
    SUM(`Unit sale price` IS NULL) AS null_unit_sale_price
FROM go_daily_sales;


-- 7. Check for zero or negative quantities
SELECT
    COUNT(*) AS invalid_quantity_records
FROM go_daily_sales
WHERE Quantity <= 0;


-- 8. Check for invalid prices
SELECT
    COUNT(*) AS invalid_price_records
FROM go_daily_sales
WHERE `Unit price` <= 0
   OR `Unit sale price` <= 0;
