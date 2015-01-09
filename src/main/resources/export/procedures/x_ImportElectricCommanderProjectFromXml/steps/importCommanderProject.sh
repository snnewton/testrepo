set -eux

ectool import --file "$[sourceFile]" --path "/projects/$[importProjectName]" --force $[overwriteIfAlreadyExists] --disableSchedules true
