#! /usr/bin/env bash

# Exit on the first error
set -e

# This script takes a collection of script names (not paths), and runs them
# on the container ID specified via stdin

CONTAINER_ID=$(cat)

# Loop through our script names

for SCRIPT_NAME in "$@"
do
  SCRIPT_PATH=$(which $SCRIPT_NAME)
  if [ -n $SCRIPT_PATH ]; then
    # Run the script on the container
    echo -n $CONTAINER_ID | run_script_on_container.sh $SCRIPT_PATH
  fi
done
