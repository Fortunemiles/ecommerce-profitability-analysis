# Data

This folder contains the dataset used for the E-Commerce Profitability Analysis project.

## Dataset Description

The dataset contains transactional e-commerce data used to analyze sales performance, profitability, geographical performance, and product performance.

## Source Tables 

The analysis used the following tables:

- go_daily_sales – Transaction-level sales records
- go_products – Product information and product classifications
- go_retailers – Retailer information and retailer types
- go_methods – Order method information

## Data Privacy

The dataset used in this project does not contain sensitive personal information.

## Data Preparation

The transaction data was combined with the supporting product, retailer, and order method tables using the appropriate keys.

The final dataset was created by joining:

- go_daily_sales with go_products using Product number
- go_daily_sales with go_retailers using Retailer code
- go_daily_sales with go_methods using Order method code

The final dataset contains 149,257 transaction records, covering the period from January 12, 2015 to July 20, 2018.

The resulting dataset was then exported for visualization and dashboard development in Tableau.
