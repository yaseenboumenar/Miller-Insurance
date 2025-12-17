-- 40_initial_load_from_raw.sql
USE DATABASE MILLER_DW;

TRUNCATE TABLE DW.DIM_BROKER;
-------------------------
-- Load DIM_BROKER
-------------------------
INSERT INTO DW.DIM_BROKER (
    broker_code,
    broker_name,
    office,
    region,
    country,
    effective_from,
    effective_to,
    latest_flag,
    load_date,
    source_system
)
SELECT
    rb.broker_code,
    rb.broker_name,
    rb.office,
    rb.region,
    rb.country,
    COALESCE(rb.active_from, CURRENT_DATE())      AS effective_from,
    COALESCE(rb.active_to, TO_DATE('9999-12-31')) AS effective_to,
    rb.active_to IS NULL                          AS latest_flag,
    CURRENT_DATE()                                AS load_date,
    'POLICY_ADMIN'                                AS source_system
FROM RAW.RAW_BROKER rb;


TRUNCATE TABLE DW.DIM_CLIENT;

-------------------------
-- Load DIM_CLIENT
-------------------------
INSERT INTO DW.DIM_CLIENT (
    client_code,
    client_name,
    industry_code,
    country,
    segment,
    effective_from,
    effective_to,
    latest_flag,
    load_date,
    source_system
)
SELECT
    rc.client_code,
    rc.client_name,
    rc.industry_code,
    rc.country,
    rc.segment,
    COALESCE(rc.active_from, CURRENT_DATE())        AS effective_from,
    COALESCE(rc.active_to, TO_DATE('9999-12-31'))   AS effective_to,
    rc.active_to IS NULL                            AS latest_flag,
    CURRENT_DATE()                                  AS load_date,
    'POLICY_ADMIN'                                  AS source_system
FROM RAW.RAW_CLIENT rc;
