
-- 10_raw_tables.sql
USE DATABASE MILLER_DW;
USE SCHEMA RAW;

-- BROKER RAW (from broker_ref.csv)
CREATE OR REPLACE TABLE RAW_BROKER (
    broker_code         STRING,
    broker_name         STRING,
    office              STRING,
    region              STRING,
    country             STRING,
    active_from         DATE,
    active_to           DATE,
    load_date           DATE DEFAULT CURRENT_DATE(),
    source_file_name    STRING
);

-- CLIENT RAW (from client_ref.csv)
CREATE OR REPLACE TABLE RAW_CLIENT (
    client_code        STRING,
    client_name        STRING,
    industry_code      STRING,
    country            STRING,
    segment            STRING,
    active_from        DATE,
    active_to          DATE,
    load_date          DATE DEFAULT CURRENT_DATE(),
    source_file_name   STRING
);

-- POLICY RAW (from policy_2025-01-01.csv)
CREATE OR REPLACE TABLE RAW_POLICY (
    policy_code        STRING,
    broker_code        STRING,
    client_code        STRING,
    lob_code           STRING,
    inception_date     DATE,
    expiry_date        DATE,
    written_premium    NUMBER(18,2),
    currency           STRING,
    status             STRING,
    territory          STRING,
    underwriter_name   STRING,
    load_date          DATE DEFAULT CURRENT_DATE(),
    source_file_name   STRING
);

-- CLAIMS RAW (from claims_2025-01-01.csv)
CREATE OR REPLACE TABLE RAW_CLAIMS (
    claim_code         STRING,
    policy_code        STRING,
    incident_date      DATE,
    reported_date      DATE,
    claim_status       STRING,
    paid_amount        NUMBER(18,2),
    outstanding_reserve NUMBER(18,2),
    currency           STRING,
    cause_of_loss      STRING,
    claim_handler      STRING,
    load_date          DATE DEFAULT CURRENT_DATE(),
    source_file_name   STRING
);

/*
USE DATABASE MILLER_DW;
CREATE OR REPLACE SCHEMA STAGING;
USE SCHEMA STAGING;

-- Example: Policy staging
CREATE OR REPLACE TABLE STG_POLICY AS
SELECT
    policy_id,
    policy_number,
    broker_code,
    client_code,
    lob_code,
    CAST(inception_date AS DATE)      AS inception_date,
    CAST(expiry_date    AS DATE)      AS expiry_date,
    CAST(written_premium AS NUMBER(18,2)) AS written_premium,
    UPPER(currency)                   AS currency,
    UPPER(status)                     AS status,
    underwriting_year,
    UPPER(territory)                  AS territory,
    underwriter_name,
    load_date,
    source_file_name
FROM RAW.RAW_POLICY;
*/