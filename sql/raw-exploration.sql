-- 1) Identify key fields + missingness (edit field names if needed)
SELECT
  COUNT(*) AS n_rows,
  COUNTIF(State IS NULL) AS missing_state,
  COUNTIF(HIREDATE_STRING IS NULL) AS missing_hiredate,
  COUNTIF(YEARLY_INCOME IS NULL) AS missing_yearly_income,
  COUNTIF(COMPRATE IS NULL) AS missing_comprate
FROM `dc-income.DC_Income_Data.raw_dc_income_data`;

-- 2) Basic distributions (helps choose outlier thresholds)
SELECT
  APPROX_QUANTILES(YEARLY_INCOME, 20) AS yearly_income_quantiles,
  APPROX_QUANTILES(COMPRATE, 20) AS comprate_quantiles
FROM `dc-income.DC_Income_Data.raw_dc_income_data`;

-- 3) Employee type/category distribution (adjust field if yours is named differently)
-- Common candidates: employee_type, Type, EMPLOYEE_TYPE, status
SELECT
  Type,
  COUNT(*) AS n
FROM `dc-income.DC_Income_Data.raw_dc_income_data`
GROUP BY Type
ORDER BY n DESC;

-- 4) Check hire date parsing readiness (sample)
SELECT
  HIREDATE_STRING,
  SAFE_CAST(HIREDATE_STRING AS DATE) AS hiredate_date_guess
FROM `dc-income.DC_Income_Data.raw_dc_income_data`
WHERE HIREDATE_STRING IS NOT NULL
LIMIT 50;
