#! /usr/bin/env bash

# Start a dev container in the current directory, using it
# as a bind mount

# Get the directory of the script
# !!! I could do this better, but it works for what I need it for now
SCRIPT_DIRECTORY=$(dirname -- $0)
DOCKERFILE_PATH="$SCRIPT_DIRECTORY/Dockerfile.dev"
DEVELOPMENT_DIRECTORY=$(pwd)

IMAGE_NAME=aom_dev
CONTAINER_NAME="${IMAGE_NAME}-$(basename $DEVELOPMENT_DIRECTORY)"

docker build \
       -t $IMAGE_NAME \
       -f $DOCKERFILE_PATH .

docker run -d \
       --name $CONTAINER_NAME \
       --mount type=bind,src=$DEVELOPMENT_DIRECTORY,dst=/workspace \
       $IMAGE_NAME

# Install our development environment in our container
# !!! This could be in a different step, but whatever, I am just using
# !!! it for my own usage at the moment :D

SCRIPTS_TO_RUN=( install_aom_nvim.sh install_node.sh install_go.sh )

echo -n $CONTAINER_NAME | run_scripts_on_container.sh ${SCRIPTS_TO_RUN[@]}

# Enter our container
# !!! Again, this could be in a different step, but this works for now

docker exec -it $CONTAINER_NAME /bin/bash

