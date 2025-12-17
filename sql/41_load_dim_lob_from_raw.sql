-- 41_load_dim_lob_from_raw.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.DIM_LOB;

INSERT INTO DW.DIM_LOB (
    lob_code,
    lob_name,
    load_date,
    source_system
)
SELECT DISTINCT
    p.lob_code,
    NULL                      AS lob_name,
    CURRENT_DATE()            AS load_date,
    'POLICY_ADMIN'            AS source_system
FROM RAW.RAW_POLICY p
WHERE p.lob_code IS NOT NULL;
