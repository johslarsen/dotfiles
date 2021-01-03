#!/bin/bash -
awk '/^References$/{ref=1} ref' "$@" | less
