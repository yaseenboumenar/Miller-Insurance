-- 00_create_db_and_schemas.sql

-- 1. Create the database
CREATE OR REPLACE DATABASE MILLER_DW;

-- 2. Create core schemas inside MILLER_DW
CREATE OR REPLACE SCHEMA MILLER_DW.RAW;     -- raw loaded data
CREATE OR REPLACE SCHEMA MILLER_DW.STAGING;   -- lightly transformed
CREATE OR REPLACE SCHEMA MILLER_DW.DW;      -- dims/facts
CREATE OR REPLACE SCHEMA MILLER_DW.META;    -- metadata, dq results, pipeline logs

-- ALTER SCHEMA MILLER_DW.STAGE RENAME TO STAGING;
