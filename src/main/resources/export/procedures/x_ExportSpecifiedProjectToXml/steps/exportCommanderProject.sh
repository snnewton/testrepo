set -eux
ls -al $COMMANDER_WORKSPACE
ectool export "$COMMANDER_WORKSPACE/serverProject.xml" --path "/projects/$[exportProjectName]" --compress false --relocatable true --withNotifiers true --withAcls true
