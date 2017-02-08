#!/usr/bin/env bash
#
#
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh

cd simple-victim-app

cat > manifest.yml <<EOS
---
applications:
- name: simple-victim-app
  memory: 1G
  instances: 3
  path: .
EOS
cf push
set -x
CF_CL_URL=chaos-loris.$CF_APPS_DOMAIN
VICTIM_APP_NAME=simple-victim-app
APP_GUID=$(cf curl "/v2/apps" -X GET -H "Content-Type: application/x-www-form-urlencoded" -d "q=name:$VICTIM_APP_NAME" | jq -r .resources[0].metadata.guid)

APP_URL=`curl -k "https://$CF_CL_URL/applications" -i -X GET -H 'Content-Type: application/json' | tail -1 | jq -r ._embedded.applications[] | select ( .applicationId == "$APP_GUID") ._links.self.href`;
if echo $APP_URL | grep $APP_GUID;
then                              
   curl -k "https://$CF_CL_URL/applications/$APP_GUID" -i -X DELETE -H 'Content-Type: application/json'
fi   
echo $APP_URL;

SCHED_HASH=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`

echo "########################################"
echo " SCHEDULE HASH IS: $SCHED_HASH"
echo "########################################"

SCHEDULE_URL= `curl -k "https://$CF_CL_URL/schedules" -i -X POST -H 'Content-Type: application/json' -d "{
  \"name\" : \"$SCHED_HASH\",
  \"expression\" : \"*/3 * * * * *\"
}" | tail -1 | jq '.'`;

exit 0
curl -k "https://$CF_CL_URL -i -X POST -H 'Content-Type: application/json' -d "{
  \"schedule\" : \"$SCHEDULE_URL\",
  \"application\" : \"$APP_URL",
  \"probability\" : 0.3
}"


