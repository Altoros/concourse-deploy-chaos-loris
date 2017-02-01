#!/usr/bin/env bash
set -e

### Load env

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/ci/utils/load-cf-env.sh
source $project_dir/ci/utils/cf-helpers.sh

cf_authenticate_and_target
if [ $? != 0 ];
then
    echo "Error authenticating with cf"
fi
cf_target_org_and_space system chaos-loris

cf_create_service p-mysql 100mb-dev chaos-loris-db



# create manifest.yml:
# ---
# applications:
# - name: chaos-loris
#   memory: 1G
#   instances: 2
#   path: build-binary/chaos-loris.jar
#   buildpack: https://github.com/cloudfoundry/java-buildpack.git
#   env:
#     LORIS_CLOUDFOUNDRY_HOST: ...
#     LORIS_CLOUDFOUNDRY_PASSWORD: ...
#     LORIS_CLOUDFOUNDRY_SKIPSSLVALIDATION: true
#     LORIS_CLOUDFOUNDRY_USERNAME: admin
#   services:
#   - chaos-loris-db

cf push

# cf curl /v2/apps
