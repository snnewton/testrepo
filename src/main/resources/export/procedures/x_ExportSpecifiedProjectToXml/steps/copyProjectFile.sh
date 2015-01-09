set -eux
mkdir -p $(dirname $[destinationFile])
cp "$COMMANDER_WORKSPACE/serverProject.xml" "$[destinationFile]"
rm "$COMMANDER_WORKSPACE/serverProject.xml"
