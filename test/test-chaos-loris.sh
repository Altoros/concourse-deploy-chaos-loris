#!/usr/bin/env bash
set -e


CF_APPS_DOMAIN=
CHAOS_LORIS_DOMAIN=chaos-loris.$CF_APPS_DOMAIN

CHAOS_LORIS_DOMAIN=chaos-loris.apps.wdc1.itcna.vmware.com

APP_NAME=victim
APP_GUID=$(cf curl "/v2/apps" -X GET -H "Content-Type: application/x-www-form-urlencoded" -d "q=name:$APP_NAME" | jq -r .resources[0].metadata.guid)

# APPS

# create an app
# See Location header for URL of the app that was already created
curl -k "https://$CHAOS_LORIS_DOMAIN/applications" -i -X POST -H 'Content-Type: application/json' -d "{
  \"applicationId\" : \"$APP_GUID\"
}"

# list apps
curl -k "https://$CHAOS_LORIS_DOMAIN/applications" -i -X GET -H 'Content-Type: application/json'

# delete an app
# Use relevant URL here, with correct ID instead of 1
curl -k "https://$CHAOS_LORIS_DOMAIN/applications/1" -i -X DELETE -H 'Content-Type: application/json'

# SCHEDULES

# create a schedule
# the name field should be uniq
curl -k "https://$CHAOS_LORIS_DOMAIN/schedules" -i -X POST -H 'Content-Type: application/json' -d "{
  \"name\" : \"every-10-secs\",
  \"expression\" : \"*/10 * * * * *\"
}"

# list schedules
curl -k "https://$CHAOS_LORIS_DOMAIN/schedules" -i -X GET -H 'Content-Type: application/json'

# delete a schedule
# Use relevant URL here, with correct ID instead of 1
curl -k "https://$CHAOS_LORIS_DOMAIN/schedules/1" -i -X DELETE -H 'Content-Type: application/json'

# CHAOSES

# create a new schedule and new chaos 

# create a chaos
# the name field should be uniq
curl -k "https://$CHAOS_LORIS_DOMAIN/chaoses" -i -X POST -H 'Content-Type: application/json' -d "{
  \"schedule\" : \"http://localhost/schedules/2\",
  \"application\" : \"http://localhost/applications/2\",
  \"probability\" : 0.3
}"

# list schedules
curl -k "https://$CHAOS_LORIS_DOMAIN/chaoses" -i -X GET -H 'Content-Type: application/json'

# delete a schedule
# wait until several events occures (~ 20 secs) before removing it
# Use relevant URL here, with correct ID instead of 1
curl -k "https://$CHAOS_LORIS_DOMAIN/chaoses/1" -i -X DELETE -H 'Content-Type: application/json'


# EVENTS
# List events
curl -k "https://$CHAOS_LORIS_DOMAIN/events" -i -X GET -H 'Content-Type: application/json'
