#!/bin/bash -
xrandr $(xrandr | awk '!off && / connected/{print "--output", $1, "--auto"; off=1; next} /connected/{print "--output", $1, "--off"}')
