USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.FACT_BROKER_DAILY_AGG;

-- Aggregate table: daily written premium per broker
CREATE OR REPLACE TABLE DW.FACT_BROKER_DAILY_AGG AS
SELECT
    f.snapshot_date_key                  AS date_key,
    f.broker_code                        AS broker_code,
    SUM(f.written_premium)               AS total_written_premium,
    COUNT(DISTINCT f.policy_code)        AS policy_count,
    CURRENT_DATE()                       AS load_date,
    'AGG_POLICY_DAILY'                   AS source_system
FROM DW.FACT_POLICY f
GROUP BY
    f.snapshot_date_key,
    f.broker_code;
