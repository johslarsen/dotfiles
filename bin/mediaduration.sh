#!/bin/bash -
mediainfo --Output="Video;%Duration%\n" "$@" | awk 'BEGIN{ms=0} NF>0{ms+=$1} END{printf "%.3f\n", ms/1000.0}'
