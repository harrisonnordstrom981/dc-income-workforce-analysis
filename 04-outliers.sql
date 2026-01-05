-- 04_outlier_handling.sql
-- Purpose: remove temps + obvious outliers so tenure vs pay analysis makes sense.
-- Output table: organized_dc_data_analysis_ready

CREATE OR REPLACE TABLE `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_analysis_ready` AS
WITH base AS (
  SELECT *
  FROM `dc-income.DC_INCOME_PROJET_DATASET.organized_dc_data_with_tenure`
),
filtered AS (
  SELECT *
  FROM base
  WHERE TRUE
    -- Remove temporary employees (edit matching logic to your real labels)
    AND NOT REGEXP_CONTAINS(UPPER(CAST(Type AS STRING)), r'\bTEMP\b|TEMPORARY')
    AND yearly_income >= 20000
    AND yearly_income <= 500000

    -- Comprate sanity check:
    -- If comprate is a ratio, typical values ~0.0–3.0. If yours is percent-like, adjust.
    AND (comprate IS NULL OR (comprate >= 0 AND comprate <= 3))
)

SELECT *
FROM filtered;
