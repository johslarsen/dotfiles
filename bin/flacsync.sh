#!/bin/bash -
rsync -av --exclude "unclassified" --exclude "barn" --exclude "jul" repos:/pub/flac/ ${1:-~/.mpd/music/flac}
