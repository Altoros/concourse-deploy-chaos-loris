#!/usr/bin/env bash
set -e

### Load env

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh



cf_authenticate_and_target

cf_target_org_and_space system chaos-loris

cf_create_service_broker chaos-loris "https://chaos-loris-broker.$CF_APPS_DOMAIN"

