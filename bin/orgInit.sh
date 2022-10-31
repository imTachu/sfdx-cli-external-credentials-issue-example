#!/usr/bin/env bash
: 'To execute, do:  ./orgInit.sh [-d DURATION] [-n NAME]'

DEFAULT_DURATION=3
DEFAULT_NAME=Issue_With_External_Credentials_Scratch

while getopts ":d:n:" opt; do
  case $opt in
  d) duration="$OPTARG";;
  n) name="$OPTARG";;
  \?) echo "Unknown option -$OPTARG" >&2; exit;;
  esac
done

scratchOrgDuration=${duration:-$DEFAULT_DURATION}
scratchOrgName=${name:-$DEFAULT_NAME}

sfdx force:org:create -a "$scratchOrgName" -s -f config/project-scratch-def.json -d "$scratchOrgDuration"

# Pushes source to scratch org
sfdx force:source:push -f

# Generates password (running `force:org:open` after this command should result in an automatic log in)
sfdx force:user:password:generate

# Enables Debug Mode for the default user
sfdx force:data:record:update -s User -i "$(sfdx force:user:display --json | jq '.result.id' -r)" -v "UserPreferencesUserDebugModePref=true"

# Opens the org in browser
sfdx force:org:open -p /lightning/page/home
echo "Org is set up"

# Displays scratch org authentication data lastly so it's not shadowed by other logs
sfdx force:user:display
