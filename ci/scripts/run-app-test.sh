#!/usr/bin/env bash
#
#
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/common/utils/load-cf-env.sh

cd simple-victim-app

cat > manifest.yml <<EOS
---
applications:
- name: simple-victim-app
  memory: 1G
  instances: 3
  path: .
EOS
cf push
set -x
CF_CL_URL=chaos-loris.$CF_APPS_DOMAIN
VICTIM_APP_NAME=simple-victim-app
APP_GUID=`cf curl "/v2/apps" -X GET -H "Content-Type: application/x-www-form-urlencoded" -d "q=name:$VICTIM_APP_NAME" | jq -r .resources[0].metadata.guid`

curl -k "https://$CF_CL_URL/applications" -i -X POST -H 'Content-Type: application/json' -d "{
  \"applicationId\" : \"$APP_GUID\"
}"

#APP_URL=`curl -k "https://$CF_CL_URL/applications" -i -X GET -H 'Content-Type: application/json' | tail -1 | jq -r '._embedded.applications[] | select ( .applicationId == "$APP_GUID") ._links.self.href'`;

#if [ -z echo $APP_URL ];
#then          
#   curl -k "https://$CF_CL_URL/applications/$APP_GUID" -i -X DELETE -H 'Content-Type: application/json'
#fi   
echo $APP_URL;  

SCHED_HASH=`cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 12 | head -n 1`                                                                
echo "########################################"                                                                                         
echo " SCHEDULE HASH IS: $SCHED_HASH"                                                                                                   
echo "########################################"                                                                                         
                                                                                                                                        
curl -k "https://$CF_CL_URL/schedules" -i -X POST -H 'Content-Type: application/json' -d "{                                             
  \"name\" : \"$SCHED_HASH\",                                                                                                           
  \"expression\" : \"*/3 * * * * *\"                                                                                                    
}" | grep Location | awk '{print $2}' | tr -d '"';                                                                                      
                                                                                                                                        
echo "********************************"                                                                                                 
SCHEDULE_URL=`curl -k "https://$CF_CL_URL/schedules" -i -X GET -H 'Content-Type: application/json' | tail -1 | jq -r "._embedded.schedules[] | select ( .name == "$SCHED_HASH") ._links.self.href";`
echo "********************************"                                                                                                 

set -x                                                                                                                                  
echo " create a chaos ** "                                                                                                              
curl -k "https://$CF_CL_URL/chaoses" -i -X POST -H 'Content-Type: application/json' -d "{                                               
  \"schedule\" : \"$SCHEDULE_URL\",                                                                                                     
  \"application\" : \"$APP_URL\",                                                                                                       
  \"probability\" : 0.3                                                                                                                 
}" 1> /dev/null;                                                                                                                        
                                                                                                                                        
# List Chaoses                                                                                                                          
                                                                                                                                        
curl -k "https://$CF_CL_URL/chaoses" -i -X GET -H 'Content-Type: application/json' | tail -1 | jq '.'                                 

exit 0
                                                                                                                                        
curl -k "https://$CHAOS_LORIS_DOMAIN/chaoses/$CHAOS_NUMBER -i -X DELETE -H 'Content-Type: application/json'  
