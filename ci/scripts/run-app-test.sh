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

if curl -k "https://$CF_CL_URL/applications" -i -X GET -H 'Content-Type: application/json' | grep $APP_GUID;
then
   curl -k "https://$CF_CL_URL/applications/$APP_GUID" -i -X DELETE -H 'Content-Type: application/json'
fi

# This curl will return the url of all apps
APP_URL=`curl -k "https://$CF_CL_URL/applications" -i -X POST -H 'Content-Type: application/json' -d "{ 
  \"applicationId\" : \"$APP_GUID\"
}" | grep applicationID | awk -F: '{print $2}'`
echo $APP_URL;
