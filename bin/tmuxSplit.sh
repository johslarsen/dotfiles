#!/bin/bash -

h=`tmux display -p -F '#{pane_height}'`
w=`tmux display -p -F '#{pane_width}'`

if [[ $((10*w)) -gt $((30*h)) ]]; then # normalizing as characters are rectangular
    splitDirection="-h"
else
    splitDirection="-v"
fi
tmux split-window "$splitDirection" "$@"
