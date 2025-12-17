-- 30_fact_tables.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

-- Policy fact (one row per policy per snapshot_date)
CREATE OR REPLACE TABLE FACT_POLICY (
    policy_fact_id      NUMBER AUTOINCREMENT PRIMARY KEY,
    policy_code         STRING,
    broker_code         STRING,
    client_code         STRING,
    lob_code            STRING,
    snapshot_date_key   NUMBER(8,0),
    inception_date_key  NUMBER(8,0),
    written_premium     NUMBER(18,2),
    currency            STRING,
    status              STRING,
    load_date           DATE,
    source_system       STRING
);

-- Claim fact (one row per claim as-of snapshot)
CREATE OR REPLACE TABLE FACT_CLAIM (
    claim_fact_id        NUMBER AUTOINCREMENT PRIMARY KEY,
    claim_code           STRING,
    policy_code          STRING,
    broker_code          STRING,
    client_code          STRING,
    lob_code             STRING,
    snapshot_date_key    NUMBER(8,0),
    incident_date_key    NUMBER(8,0),
    reported_date_key    NUMBER(8,0),
    claim_status         STRING,
    paid_amount          NUMBER(18,2),
    outstanding_reserve  NUMBER(18,2),
    incurred_amount      NUMBER(18,2),
    currency             STRING,
    cause_of_loss        STRING,
    load_date            DATE,
    source_system        STRING
);
