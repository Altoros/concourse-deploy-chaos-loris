#!/usr/bin/env bash
set -e

# TODO: Add timezone to container

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh

CHAOS_LORIS_HOST=chaos-loris.$CF_APPS_DOMAIN
CHAOS_LORIS_SCHEDULE="0 0 * * * *"
CHAOS_LORIS_PROBOBILITY="0.1"

# env with CF creds sould be loaded
# CHAOS_LORIS_HOST=https://chaos-loris.$CF_APPS_DOMAIN
# 
chaos-loris-client $CHAOS_LORIS_COMMAND 

# Create schedule
# delete chaos if it is already exist?
# curl -k "https://$CHAOS_LORIS_HOST/schedules" -i -X POST -H 'Content-Type: application/json' -d '{
#   "name" : "default123",
#   "expression" : "*/10 * * * * *"
# }'

# 

# Create an app
# CF_APP_GUID=3cab9f56-39a2-4d11-9880-a4e7b56a68f8
# curl -k "https://$CHAOS_LORIS_HOST/applications" -i -X POST -H 'Content-Type: application/json' -d "{\"applicationId\" : \"$CF_APP_GUID\"}"

# Create chaoses
# curl -k "https://$CHAOS_LORIS_HOST/chaoses" -i -X POST -H 'Content-Type: application/json' -d "{
#   \"schedule\" : \"https://$CHAOS_LORIS_HOST/schedules/1\",
#   \"application\" : \"http://localhost/applications/1\",
#   \"probability\" : 0.1
# }"

# List events

# Clean up the env
