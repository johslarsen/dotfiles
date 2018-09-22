#!/bin/bash -
for f in ~/.bash_profile.d/*; do
	[ -f "$f" ] && . "$f"
done
