#!/bin/bash -
a="$1"
b="${2:?USAGE: $0 [[user@]host]:file [[user@]host]:file CMD...}"
cmd=( "${@:3}" )

output() {
	auth="${1%:*}"
	if [[ "$auth" != "$1" ]]; then
		ssh "$auth" "${cmd[@]}" "${1##*:}"
	else
		"${cmd[@]}" "$1"
	fi
}
${DIFF:-diff -u} <(output "$a") <(output "$b")
