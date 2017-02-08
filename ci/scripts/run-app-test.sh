#!/usr/bin/env bash
#
#
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh

CF_CL_URL=chaos-loris.$CF_APPS_DOMAIN
VICTIM_APP_NAME=victim1
APP_GUID=$(cf curl "/v2/apps" -X GET -H "Content-Type: application/x-www-form-urlencoded" -d "q=name:$VICTIM_APP_NAME" | jq -r .resources[0].metadata.guid)

# This curl will return the url of all apps
set -x
LIST_APPS_URL=`curl -k "https://$CF_CL_URL/applications" -i -X POST -H 'Content-Type: application/json' -d "{
  \"applicationId\" : \"$APP_GUID\"
}"`
echo $LIST_APPS_URL;
