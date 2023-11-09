#!/bin/bash -
me=`basename "$0"`
mydir=`dirname "$0"`

. "$mydir/with_parent_directory_entries.sh"

die() {
    echo >&2 "USAGE: $0 FROM TO PLAYLIST..."
    exit 1
}

from=$1
to=$2
playlists=( "${@:3:$#}" )


[[ $# -lt 3 ]] && die

while read missing; do
    adb push "$from/$missing" "$to/$missing"
done < <(comm -23 <(sort $playlists) <(adb shell "cd '$to'; find * -type f" | sort))
