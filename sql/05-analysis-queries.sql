-- 05_analysis_queries.sql
-- Purpose: produce analysis outputs for Tableau + narrative insights.

-- 1) Pay summary by employee type (term/regular/etc)
SELECT
  Type,
  COUNT(*) AS n,
  AVG(yearly_income) AS avg_income,
  APPROX_QUANTILES(yearly_income, 4) AS income_quartiles,
  AVG(tenure_years) AS avg_tenure_years
FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_analysis_ready`
GROUP BY Type
ORDER BY n DESC;

-- 2) Tenure bucket vs income (great for bar chart / line chart)
SELECT
  tenure_bucket,
  COUNT(*) AS n,
  AVG(yearly_income) AS avg_income,
  APPROX_QUANTILES(yearly_income, 4) AS income_quartiles
FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_analysis_ready`
GROUP BY tenure_bucket
ORDER BY
  CASE tenure_bucket
    WHEN '<1 year' THEN 1
    WHEN '1–3 years' THEN 2
    WHEN '3–5 years' THEN 3
    WHEN '5–10 years' THEN 4
    WHEN '10+ years' THEN 5
    ELSE 99
  END;

-- 3) Tenure vs income scatter extract (tableau-friendly row-level subset)
SELECT
  yearly_income,
  tenure_years,
  Type,
  comprate
FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_analysis_ready`
WHERE tenure_years IS NOT NULL
  AND yearly_income IS NOT NULL;

-- 4) Comprate analysis by tenure bucket (nice for box plot)
SELECT
  tenure_bucket,
  COUNT(*) AS n,
  AVG(comprate) AS avg_comprate,
  APPROX_QUANTILES(comprate, 10) AS comprate_deciles
FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_analysis_ready`
WHERE comprate IS NOT NULL
GROUP BY tenure_bucket
ORDER BY
  CASE tenure_bucket
    WHEN '<1 year' THEN 1
    WHEN '1–3 years' THEN 2
    WHEN '3–5 years' THEN 3
    WHEN '5–10 years' THEN 4
    WHEN '10+ years' THEN 5
    ELSE 99
  END;
