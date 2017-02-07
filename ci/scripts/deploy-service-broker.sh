#!/usr/bin/env bash

### Load env

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh
source $project_dir/common/utils/cf-helpers.sh


cf_authenticate_and_target
cf_target_org_and_space system chaos-loris

cat > manifest.yml <<EOS
---
applications:
- name: chaos-loris-broker
  memory: 512M
  instances: 2
  buildpack: https://github.com/ryandotsmith/null-buildpack
  path: .
  command: ./cf-chaos-loris-broker -c plans.yml
  env:
    CHAOS_LORIS_HOST: https://chaos-loris.$CF_APPS_DOMAIN
  services:
  - chaos-loris-broker-db
EOS

set -e -x
echo "##############################"
cf push
exit_on_error "Error pushing app"
echo "##############################"
