
-- Project:  A/B Test Marketing Analysis
-- Description: Analysis of ad campaign effectiveness, exposure frequency, 
--              and timing patterns to inform performance marketing strategy.

-- Set the active database
USE agoda_project;

--  Data Quality & Sanity Check
-- Purpose: Confirm the total row count matches the raw CSV 
-- and verify there are no duplicate users in the dataset.

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT user_id) AS unique_users
FROM marketing_ab;

--  Headline Conversion Rate by Group
-- Purpose: Calculate the baseline conversion rate for the Ad group vs 
-- the PSA (control) group to measure overall campaign success.

SELECT 
    test_group,
    COUNT(*) AS users,
    SUM(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) AS conversions,
    ROUND(AVG(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) * 100, 2) AS conv_rate_pct
FROM marketing_ab
GROUP BY test_group;

--  Ad Exposure Frequency Analysis
-- Purpose: Determine if seeing more ads drives higher conversion rates. 

SELECT
    CASE
        WHEN total_ads BETWEEN 1 AND 5   THEN '1-5'
        WHEN total_ads BETWEEN 6 AND 20  THEN '6-20'
        WHEN total_ads BETWEEN 21 AND 50 THEN '21-50'
        WHEN total_ads > 50              THEN '50+'
        ELSE '0'
    END                        AS ads_bucket,
    COUNT(*)                   AS users,
    ROUND(AVG(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) * 100, 2) AS conv_rate_pct
FROM marketing_ab
WHERE test_group = 'ad'
GROUP BY ads_bucket
ORDER BY MIN(total_ads);

-- iming Analysis - Day of Week
-- Purpose: Identify which days of the week have the highest conversion.

SELECT
    most_ads_day,
    COUNT(*) AS users,
    ROUND(AVG(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) * 100, 2) AS conv_rate_pct
FROM marketing_ab
WHERE test_group = 'ad'
GROUP BY most_ads_day
ORDER BY FIELD(most_ads_day,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- Timing Analysis - Hour of Day
-- Purpose: Identify which hours of the day have the highest conversion.

SELECT
    most_ads_hour,
    COUNT(*) AS users,
    ROUND(AVG(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) * 100, 2) AS conv_rate_pct
FROM marketing_ab
WHERE test_group = 'ad'
GROUP BY most_ads_hour
ORDER BY most_ads_hour;

-- 2x2 Contingency Table for R (Statistical Significance)
-- Purpose: Extract raw counts of conversions and non-conversions 
-- to feed into R for a Two-Proportion Z-Test.

SELECT
    test_group,
    SUM(CASE WHEN converted = 'True' THEN 1 ELSE 0 END) AS converted_n,
    SUM(CASE WHEN converted = 'False' THEN 1 ELSE 0 END) AS not_converted_n,
    COUNT(*) AS total_n
FROM marketing_ab
GROUP BY test_group;