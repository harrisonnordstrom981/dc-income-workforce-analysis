-- 03_tenure_calculation.sql
-- Purpose: add tenure years (assuming still employed) to support tenure vs pay analysis.
-- Output table: organized_dc_data_with_tenure

CREATE OR REPLACE TABLE `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_with_tenure` AS
SELECT
  t.*,

  -- Assumes employee hasn't left
  -- Use DATE_DIFF in days divided by 365.25 for a realistic year length.
  SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), hiredate, DAY), 365.25) AS tenure_years,
  CASE
    WHEN hiredate IS NULL THEN 'Unknown'
    WHEN SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), hiredate, DAY), 365.25) < 1 THEN '<1 year'
    WHEN SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), hiredate, DAY), 365.25) < 3 THEN '1–3 years'
    WHEN SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), hiredate, DAY), 365.25) < 5 THEN '3–5 years'
    WHEN SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), hiredate, DAY), 365.25) < 10 THEN '5–10 years'
    ELSE '10+ years'
  END AS tenure_bucket

FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data` t;
