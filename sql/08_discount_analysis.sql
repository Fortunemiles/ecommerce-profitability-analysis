-- ============================================================
-- E-Commerce Profitability Analysis
-- File: 08_discount_analysis.sql
-- Purpose: Analyze discounts and their relationship with
--          profitability
-- Database: MySQL
-- ============================================================


-- 1. Overall discount performance

SELECT
    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit price` - d.`Unit sale price`)
        ),
        2
    ) AS total_discount_value,

    ROUND(
        SUM(
            d.Quantity *
            (d.`Unit price` - d.`Unit sale price`)
        )
        /
        SUM(d.Quantity * d.`Unit price`) * 100,
        2
    ) AS overall_discount_percentage
FROM go_daily_sales d;


-- 2. Profitability by discount band

WITH discount_analysis AS (
    SELECT
        d.Quantity,
        d.`Unit price`,
        d.`Unit sale price`,
        p.`Unit cost`,
        CASE
            WHEN d.`Unit price` = 0 THEN 'Unknown'

            WHEN (
                (d.`Unit price` - d.`Unit sale price`)
                / d.`Unit price`
            ) = 0
                THEN '0%'

            WHEN (
                (d.`Unit price` - d.`Unit sale price`)
                / d.`Unit price`
            ) <= 0.05
                THEN '0-5%'

            WHEN (
                (d.`Unit price` - d.`Unit sale price`)
                / d.`Unit price`
            ) <= 0.10
                THEN '5-10%'

            WHEN (
                (d.`Unit price` - d.`Unit sale price`)
                / d.`Unit price`
            ) <= 0.15
                THEN '10-15%'

            ELSE '15%+'
        END AS discount_band

    FROM go_daily_sales d
    JOIN go_products p
        ON d.`Product number` = p.`Product number`
)

SELECT
    discount_band,

    ROUND(
        SUM(Quantity * `Unit sale price`),
        2
    ) AS revenue,

    ROUND(
        SUM(
            Quantity *
            (`Unit sale price` - `Unit cost`)
        ),
        2
    ) AS profit,

    ROUND(
        SUM(
            Quantity *
            (`Unit sale price` - `Unit cost`)
        )
        /
        SUM(Quantity * `Unit sale price`) * 100,
        2
    ) AS profit_margin_percentage

FROM discount_analysis

GROUP BY discount_band

ORDER BY
    CASE discount_band
        WHEN '0%' THEN 1
        WHEN '0-5%' THEN 2
        WHEN '5-10%' THEN 3
        WHEN '10-15%' THEN 4
        WHEN '15%+' THEN 5
        ELSE 6
    END;
