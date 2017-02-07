#!/usr/bin/env bash
set -e

### Load env

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh

cf_authenticate_and_target
exit_on_error "Error in auth"

cf_target_org_and_space system chaos-loris
exit_on_error "Error in cf taget command"

cf_create_service p-mysql 100mb-dev chaos-loris-broker-db
exit_on_error "Error creating service"

register_broker p-mysql admin $CF_ADMIN_PASSWORD chaos-loris-broker.apps.wdc1.itcna.vmware.com
exit_on_error "Error registering broker"

enable_global_access "100mb-dev"
exit_on_error "Error enabling global access"
