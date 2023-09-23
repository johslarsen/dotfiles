#!/bin/bash -
dest=${1:?USAGE $0 OUTPUT_DIR DOCKER_IMAGES...}
images=( "${@:2}" )

mkdir -p "$dest"
chmod 777 "$dest"
for image in "${images[@]}"; do
    docker run --rm -v "$(readlink -f "$dest"):/mnt" "$image" rsync -a /usr/include/ /mnt/
done
