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
#   "name" : "defdewault123",
#   "expression" : "*/10 * * * * *"
# }'

# 

# Create an app
# CF_APP_GUID=3e665949-6053-44d5-bf68-09c712a37687
# curl -k "https://$CHAOS_LORIS_HOST/applications" -i -X POST -H 'Content-Type: application/json' -d "{\"applicationId\" : \"$CF_APP_GUID\"}"

# Create chaoses
# curl -k "https://$CHAOS_LORIS_HOST/chaoses" -i -X POST -H 'Content-Type: application/json' -d "{
#   \"schedule\" : \"http://$CHAOS_LORIS_HOST/schedules/3\",
#   \"application\" : \"http://$CHAOS_LORIS_HOST/applications/1\",
#   \"probability\" : 0.1
# }"

# List events

# Clean up the env

# curl -k "https://$CHAOS_LORIS_HOST/chaoses" -i -H 'Accept: application/hal+json'
# curl -k -X DELETE "https://$CHAOS_LORIS_HOST/chaoses/1" -i -H 'Accept: application/hal+json'
