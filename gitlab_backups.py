"""
    @author: Linor Ben Yossef
    @description: Backups of repository from Gitlab
"""

from datetime import datetime

from airflow import DAG
from airflow.models import Variable
from airflow.operators.bash import BashOperator

with DAG(
    dag_id='gitlab_backups',
    description=' backups of gitlab',
    schedule_interval="@weekly",
    start_date=datetime(2022, 1, 1),
    catchup=False,
    tags=['gitlab', 'backup'],
    default_args= {
      'owner': 'Linor Ben Yossef'
    },

)as dag:
    config = Variable.get('gitlab_backups'),
    run_this = BashOperator(
    task_id = 'gitlab_backups',
    bash_command = r'path_to_file/gitlab_backup.sh --ACCESS_TOKEN{{config}} ',
    dag = dag,    
    )
