#! /usr/bin/env bash

# This script takes a container identifier as its stdin,
# and installs a script given in the parameters in the container,
# as well as running it

CONTAINER_ID=$(cat)
SCRIPT_PATH="$1"

if [ -z $SCRIPT_PATH ]; then
  echo "Error, missing script path"
  exit 1
fi

# Get the basename for the script
SCRIPT_NAME=$(basename $SCRIPT_PATH)

CONTAINER_TEMP_DIRECTORY=$(docker exec $CONTAINER_ID /bin/bash -c "mktemp -d")
# Copy the script to our container
docker cp $SCRIPT_PATH $CONTAINER_ID:$CONTAINER_TEMP_DIRECTORY
# Execute the script on our container
docker exec $CONTAINER_ID /bin/bash -c "/$CONTAINER_TEMP_DIRECTORY/$SCRIPT_NAME"
