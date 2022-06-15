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

rsync -av --progress --delete --ignore-existing --include-from=<(awk '{print gensub(/[\[\]*?]/, "\\\\\\\\\\0", "g", $0)}' "${playlists[@]}" | with_parent_directory_entries) --exclude="*" "$from" "$to"
