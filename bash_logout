#!/bin/bash -
for f in ~/.bash_logout.d/*; do
	[ -f "$f" ] && . "$f"
done
