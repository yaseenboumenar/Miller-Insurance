-- 20_dim_tables.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

-- Date dimension (simple version)
CREATE OR REPLACE TABLE DIM_CALENDAR (
    date_key       NUMBER(8,0) PRIMARY KEY,  -- yyyymmdd
    full_date      DATE,
    day_of_month   NUMBER(2,0),
    month_number   NUMBER(2,0),
    month_name     STRING,
    year_number    NUMBER(4,0),
    quarter_number NUMBER(1,0)
);

-- Broker dimension (SCD2 ready)
CREATE OR REPLACE TABLE DIM_BROKER (
    broker_id       NUMBER AUTOINCREMENT PRIMARY KEY,
    broker_code     STRING,
    broker_name     STRING,
    office          STRING,
    region          STRING,
    country         STRING,
    effective_from  DATE,
    effective_to    DATE,
    latest_flag     BOOLEAN,
    load_date       DATE,
    source_system   STRING
);

-- Client dimension (SCD2 ready)
CREATE OR REPLACE TABLE DIM_CLIENT (
    client_id       NUMBER AUTOINCREMENT PRIMARY KEY,
    client_code     STRING,
    client_name     STRING,
    industry_code   STRING,
    country         STRING,
    segment         STRING,
    effective_from  DATE,
    effective_to    DATE,
    latest_flag     BOOLEAN,
    load_date       DATE,
    source_system   STRING
);

-- Line of Business dimension
CREATE OR REPLACE TABLE DIM_LOB (
    lob_id          NUMBER AUTOINCREMENT PRIMARY KEY,
    lob_code        STRING,
    lob_name        STRING,
    load_date       DATE,
    source_system   STRING
);

-- Policy dimension (one-to-one with policy_id for now)
CREATE OR REPLACE TABLE DIM_POLICY (
    policy_id           NUMBER AUTOINCREMENT PRIMARY KEY,
    policy_code         STRING,
    broker_code         STRING,
    client_code         STRING,
    lob_code            STRING,
    inception_date      DATE,
    expiry_date         DATE,
    status              STRING,
    territory           STRING,
    underwriter_name    STRING,
    load_date           DATE,
    source_system       STRING
);
