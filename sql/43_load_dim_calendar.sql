-- 43_load_dim_calendar.sql
USE DATABASE MILLER_DW;
USE SCHEMA DW;

TRUNCATE TABLE DW.DIM_CALENDAR;

INSERT INTO DW.DIM_CALENDAR (
    date_key,
    full_date,
    day_of_month,
    month_number,
    month_name,
    year_number,
    quarter_number
)
SELECT
    TO_NUMBER(TO_CHAR(d, 'YYYYMMDD'))        AS date_key,
    d                                        AS full_date,
    EXTRACT(DAY    FROM d)                   AS day_of_month,
    EXTRACT(MONTH  FROM d)                   AS month_number,
    TO_CHAR(d, 'MON')                        AS month_name,
    EXTRACT(YEAR   FROM d)                   AS year_number,
    EXTRACT(QUARTER FROM d)                  AS quarter_number
FROM (
    SELECT DATEADD(DAY, SEQ4(), '2024-01-01') AS d
    FROM TABLE(GENERATOR(ROWCOUNT => 365 * 3))  -- 3 years of dates
) t;