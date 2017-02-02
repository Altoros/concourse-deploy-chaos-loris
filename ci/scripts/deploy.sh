#!/usr/bin/env bash
set -e

### Load env

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh

cf_authenticate_and_target
cf_target_org_and_space system chaos-loris
cf_create_service p-mysql 100mb-dev chaos-loris-db


pushd binary
cat > manifest.yml <<EOS
---
applications:
- name: chaos-loris
  memory: 1G
  instances: 2
  path: build-binary/chaos-loris.jar
  buildpack: https://github.com/cloudfoundry/java-buildpack.git
  env:
    LORIS_CLOUDFOUNDRY_HOST: $CF_API_URL
    LORIS_CLOUDFOUNDRY_PASSWORD: $CF_ADMIN_PASSWORD
    LORIS_CLOUDFOUNDRY_SKIPSSLVALIDATION: true
    LORIS_CLOUDFOUNDRY_USERNAME: $CF_ADMIN_USERNAME
  services:
  - chaos-loris-db
EOS
cf push
exit_on_error "Error pushing app"
popd
