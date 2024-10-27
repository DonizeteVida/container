#!/bin/bash

#start.sh android-8 ../android-7.1.1_r4

set -x

MACHINE=$1
AOSP=$(realpath $2)

USER=$(id -un)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

docker build \
    --build-arg USER=$USER \
    --build-arg USER_ID=$USER_ID \
    --build-arg GROUP_ID=$GROUP_ID \
    --tag $MACHINE \
    --file $MACHINE.Dockerfile \
    .

docker run \
    --user $USER_ID:$GROUP_ID \
    --volume $AOSP:/src \
    --workdir /src \
    --rm \
    -it \
    $MACHINE