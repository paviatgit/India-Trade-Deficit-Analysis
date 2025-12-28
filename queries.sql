/* Project: India Trade Deficit Analysis (2021-2023)
   Author: [Your Name]
   Description: SQL scripts for data cleaning, deficit calculation, and unit economics analysis.
*/

-- 1. IDENTIFYING TOP 10 COMMODITIES BY TRADE DEFICIT
-- This query calculates the net balance and identifies the biggest drivers of the deficit.
SELECT 
    commodity,
    SUM(export_value) AS total_exports,
    SUM(import_value) AS total_imports,
    SUM(export_value - import_value) AS trade_balance
FROM india_trade_data
GROUP BY commodity
ORDER BY trade_balance ASC
LIMIT 10;

-- 2. GOLD SUPPLY CHAIN ANALYSIS
-- Identifying the top partner countries specifically for Gold imports.
SELECT 
    country,
    SUM(import_value) AS total_gold_import_value
FROM india_trade_data
WHERE commodity = 'GOLD'
GROUP BY country
ORDER BY total_gold_import_value DESC;

-- 3. UNIT ECONOMICS: VOLUME VS. VALUE COMPARISON
-- Calculating unit price to compare the financial impact of Petroleum vs. Gold.
SELECT 
    commodity,
    SUM(quantity) AS total_qty,
    SUM(import_value) AS total_value,
    (SUM(import_value) / NULLIF(SUM(quantity), 0)) AS unit_price
FROM india_trade_data
WHERE commodity IN ('GOLD', 'PETROLEUM PRODUCTS')
GROUP BY commodity;