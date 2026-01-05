-- 02_data_cleaning.sql
-- Purpose: create a cleaned base table with standardized types and basic validity rules.
-- Output table: organized_dc_data

CREATE OR REPLACE TABLE `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data` AS
SELECT
  * EXCEPT(HIREDATE_STRING),
  SAFE_CAST(HIREDATE_STRING AS DATE) AS hiredate,
  SAFE_CAST(YEARLY_INCOME AS FLOAT64) AS yearly_income,
  SAFE_CAST(COMPRATE AS FLOAT64) AS comprate

FROM `dc-income.DC_Income_Data.raw_dc_income_data`
WHERE TRUE
  AND HIREDATE_STRING IS NOT NULL
  AND YEARLY_INCOME IS NOT NULL;
