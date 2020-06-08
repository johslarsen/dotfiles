#!/bin/bash -
rel=$(dirname "$0")

for path in "$@"; do
	subject="$(awk 'match($0, /^Subject: (.*)/, m){print m[1]; exit}' "$path")"
	ids=$("$rel/mail_mimepart.py" < "$path" | fzf-tmux +s -1 -m --prompt "${subject:0:50}> " | cut -d' ' -f 1)
	[[ "$ids" ]] && "$rel/mail_mimepart.py" $ids < "$path"
done
