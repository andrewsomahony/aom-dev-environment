#! /usr/bin/env bash

# Stops the development container running in the current directory
# We can use our "detect_dir_container.sh" script to figure out the container
# id

CONTAINER_ID=$(detect_dir_container.sh)


if [ -n "$CONTAINER_ID" ]; then
  docker stop $CONTAINER_ID
  docker rm $CONTAINER_ID
fi
