from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator

# DAG definition
default_args = {
    "owner": "data_team",
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="miller_insurance_dw",
    default_args=default_args,
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,      # "0 3 * * *"  # 03:00 every day, Airflow server time
    catchup=False,
    tags=["miller", "snowflake", "dq"],
) as dag:

        # 1. Load DW from RAW using Python + Snowflake connector
    load_dw = BashOperator(
        task_id="load_dw_from_raw",
        bash_command=(
            "cd /opt/airflow/miller-insurance-data-platform/python && "
            "python run_load_dw.py"
        ),
    )

    # 2. Build aggregates
    build_aggreagates = BashOperator(
        task_id="run_build_aggregates",
        bash_command=(
            "cd /opt/airflow/miller-insurance-data-platform/python && "
            "python run_build_aggregates.py"
        ),
    )

    # 3. Run DQ checks
    dq_checks = BashOperator(
        task_id="run_dq_checks",
        bash_command=(
            "cd /opt/airflow/miller-insurance-data-platform/python && "
            "python run_dq_checks.py"
        ),
    )

    load_dw >> build_aggreagates >> dq_checks
