#!/bin/bash

set -x

SCRIPT_PATH=$0
SCRIPT_FOLDER=${SCRIPT_PATH%/*}

MACHINE=$1
FOLDER=.

USER=$(id -un)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

docker build \
    --build-arg USER=$USER \
    --build-arg USER_ID=$USER_ID \
    --build-arg GROUP_ID=$GROUP_ID \
    --tag $MACHINE \
    --file $SCRIPT_FOLDER/$MACHINE.Dockerfile \
    .

docker run \
    --user $USER_ID:$GROUP_ID \
    --volume $FOLDER:/src \
    --workdir /src \
    --add-host=host.docker.internal:host-gateway \
    --env "ANDROID_ADB_SERVER_ADDRESS=host.docker.internal" \
    --rm \
    -it \
    $MACHINE