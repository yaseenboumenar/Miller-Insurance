-- 50_load_fact_policy.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.FACT_POLICY;

INSERT INTO DW.FACT_POLICY (
    policy_code,
    broker_code,
    client_code,
    lob_code,
    inception_date_key,
    snapshot_date_key,
    written_premium,
    currency,
    status,
    load_date,
    source_system
)
SELECT
    rp.policy_code,
    rp.broker_code,
    rp.client_code,
    rp.lob_code,
    TO_NUMBER(TO_CHAR(rp.inception_date, 'YYYYMMDD')) AS inception_date_key,
    TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'YYYYMMDD'))    AS snapshot_date_key,
    rp.written_premium,
    rp.currency,
    rp.status,
    CURRENT_DATE()                     AS load_date,
    'POLICY_ADMIN'                     AS source_system
FROM RAW.RAW_POLICY rp