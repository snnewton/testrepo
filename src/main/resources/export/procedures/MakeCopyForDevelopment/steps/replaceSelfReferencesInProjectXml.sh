set -eux

OLD_NAME="$[/myProject/projectName]"
NEW_NAME="$[newProjectName]"
sed --in-place "s#${OLD_NAME}#${NEW_NAME}#g" $[/myProcedure/procedureName]-project.xml
