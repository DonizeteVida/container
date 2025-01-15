#!/bin/bash

set -x

SCRIPT_PATH=$0
FILE=$1

SCRIPT_FOLDER=${SCRIPT_PATH%/*}
FOLDER=.

USER=$(id -un)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

podman build \
    --build-arg USER=$USER \
    --build-arg USER_ID=$USER_ID \
    --build-arg GROUP_ID=$GROUP_ID \
    --tag $FILE \
    --file $SCRIPT_FOLDER/$FILE.Dockerfile \
    .

podman run \
    --userns=keep-id \
    --volume $(pwd):$(pwd) \
    --workdir $(pwd) \
    --rm \
    -it \
    $FILE