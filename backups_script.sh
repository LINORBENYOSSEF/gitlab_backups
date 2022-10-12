# This script backup gitlab branches and run on DAG gitlab_backups.py
# MUST get the credentials from gitlab:
# TOKEN_NAME  = gitlab_backups
# ACCESS_TOKEN = oreinbjkfchdugd

ACCESS_TOKEN=("$@")
for branch in branch1 branch2
do
  cd '/path_for_backups'
  DATE = $(date+'%d-%m-%y')
  if git clone -b ${branch} https://gitlab_backups:${ACCESS_TOKEN[0]}@gitlab.path/path_of_repo.git
  then
    echo ${branch} "branch clone sucessfully"
  else
    echo >&2 '**************Failed**************' "An error occurred  in clone branch" ${branch}
    exit 0
  fi
  tar -a -c -f backup_${branch}_${DATE}.zip name_of_repo
  rm -f -r name_of_repo
done
