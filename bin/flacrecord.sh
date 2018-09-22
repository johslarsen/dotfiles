#!/bin/bash -

output_directory=${1:-.}
duration=${2:-600} # seconds

mkdir -p "$output_directory" || exit 1

while true; do
	arecord -f cd -d $duration | flac -8 - > "$output_directory/$(date +%Y%m%d_%H%M%S).flac" &
	sleep $duration
done
