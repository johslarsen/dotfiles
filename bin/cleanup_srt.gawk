#!/bin/gawk -f
/www\.OpenSubtitles\.org/ || /osdb\.link\/brave/ || /YTS\.(MX|LT)/ {next} # ads
/^WEBVTT/ || /^X-TIMESTAMP/ {next} # WEBVTT spam

# deduplicate records at VTT chunk boundaries:
/^[0-9]+$/{skip = $1 == prev; prev=$1}
!skip {print}
