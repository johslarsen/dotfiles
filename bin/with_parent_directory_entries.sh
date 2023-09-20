#!/bin/bash -
with_parent_directory_entries() {
    declare -A printed
    while read e; do
        e="${e//\/\//\/}"
        while true; do
            [ -z "${printed[$e]}" ] || break

            echo "$e"
            printed["$e"]=$e

            e="${e%/*}"
        done
    done
}
