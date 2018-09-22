#!/bin/bash -
for f in ~/.xinitrc.d/*; do
	[ -f "$f" ] && . "$f"
done
