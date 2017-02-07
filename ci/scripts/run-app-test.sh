#!/usr/bin/env bash
#
#
set -e


project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh


CF_CL_URL=chaos-loris.$CF_APPS_DOMAIN
VICTIM_APP_NAME=$1
APP_GUID=$(cf curl "/v2/apps" -X GET -H "Content-Type: application/x-www-form-urlencoded" -d "q=name:$VICTIM_APP_NAME" | jq -r .resources[0].metadata.guid)




