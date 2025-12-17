-- 51_load_fact_claim.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.FACT_CLAIM;

INSERT INTO DW.FACT_CLAIM (
    claim_code,
    policy_code,
    broker_code,
    client_code,
    lob_code,
    incident_date_key,
    reported_date_key,
    snapshot_date_key,
    claim_status,
    paid_amount,
    outstanding_reserve,
    incurred_amount,
    currency,
    cause_of_loss,
    load_date,
    source_system
)
SELECT
    rc.claim_code,
    rc.policy_code,
    rp.broker_code,
    rp.client_code,
    rp.lob_code,
    TO_NUMBER(TO_CHAR(rc.incident_date, 'YYYYMMDD'))                    AS incident_date_key,
    TO_NUMBER(TO_CHAR(rc.reported_date, 'YYYYMMDD'))                    AS reported_date_key,
    TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'YYYYMMDD'))                      AS snapshot_date_key,
    rc.claim_status,
    rc.paid_amount,
    rc.outstanding_reserve,
    rc.paid_amount + rc.outstanding_reserve AS incurred_amount,
    rc.currency,
    rc.cause_of_loss,
    CURRENT_DATE()                     AS load_date,
    'CLAIMS_SYSTEM'                    AS source_system
FROM RAW.RAW_CLAIMS rc
JOIN RAW.RAW_POLICY rp
    ON rp.policy_code = rc.policy_code