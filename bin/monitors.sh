#!/bin/bash -

declare -A monitors
disks=
monitors[dstat]="while true; do disks=; DSTAT_TIMEFMT=%H:%M:%S dstat -f -tlcmn --socket -d -D \"\$(\\ls -1 /dev/nvme?n? /dev/[hs]d? /dev/mmcblk? 2>/dev/null | tr $'\n' ,)\" --fs --lock -pygi 10 3; done"
monitors[iotop]="sudo iotop"
monitors[iftop]="sudo iftop"
monitors[htop]="htop"
monitors[journal]="journalctl -af | ccze -A"

if ! tmux list-sessions 2>/dev/null | grep '^monitor:' &>/dev/null; then
    tmux new -x$(tput cols) -y$(tput lines) -d -n main -s monitor "${monitors[dstat]}"
    tmux select-pane -t monitor
    tmux split -vp 90 "${monitors[journal]}"
    tmux split -vp 75 "${monitors[htop]}"
    tmux split -h -p 50 "${monitors[iftop]}"
    tmux split -v -p 50 "${monitors[iotop]}"
fi

tmux attach -t monitor
