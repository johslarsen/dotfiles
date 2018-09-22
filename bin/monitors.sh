#!/bin/bash -

declare -A monitors
monitors[iostat]="iostat -dNm 1"
monitors[iotop]="sudo iotop"
monitors[iftop]="sudo iftop"
monitors[htop]="htop"
monitors[journal]="journalctl -af | ccze -A"

case "$HOSTNAME" in
	trx) monitors[iftop]+=" -i wls4"
esac

if ! tmux list-sessions 2>/dev/null | grep '^monitor:' &>/dev/null; then
	tmux new -d -n main -s monitor "${monitors[journal]}"
	tmux select-pane -t monitor
	tmux split -h "${monitors[htop]}"
	tmux split -v -p 62 "${monitors[iftop]}"
	tmux split -v -p 67 "${monitors[iotop]}"
	tmux split -v "${monitors[iostat]}"
fi

tmux attach -t monitor
