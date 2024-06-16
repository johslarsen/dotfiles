#!/bin/bash -
old=$(brightnessctl -q g)
function when_killed() {
    brightnessctl -q s $old
    exit 0
}
trap when_killed INT TERM HUP EXIT

while true; do
    brightnessctl -q s 1
    sleep 0.5
    brightnessctl -q s $old
    sleep 0.5
done
