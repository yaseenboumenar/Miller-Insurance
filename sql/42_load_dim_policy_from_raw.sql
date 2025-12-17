-- 42_load_dim_policy_from_raw.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.DIM_POLICY;

-- Initial load of DIM_POLICY from RAW.RAW_POLICY
-- Assumes one row per policy_code in RAW_POLICY.

INSERT INTO DW.DIM_POLICY (
    policy_code,
    broker_code,
    client_code,
    lob_code,
    inception_date,
    expiry_date,
    status,
    territory,
    underwriter_name,
    load_date,
    source_system
)
SELECT
    rp.policy_code,
    rp.broker_code,
    rp.client_code,
    rp.lob_code,
    rp.inception_date,
    rp.expiry_date,
    rp.status,
    rp.territory,
    rp.underwriter_name,
    CURRENT_DATE()      AS load_date,
    'POLICY_ADMIN'      AS source_system
FROM RAW.RAW_POLICY rp;