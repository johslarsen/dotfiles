#!/bin/bash

# SOURCE: http://blog.waan.name/pulseaudio-setting-volume-from-command-line/
# AUTHOR: tom
# AUTHOR: mhasko

VOL_MAX="0x10000"
STEPS="32" # 2^n

if [ -e ~/.pulseaudio_output ]; then
	source ~/.pulseaudio_output
else
	IFS=$'\n' sinks=( $(pacmd dump | grep alsa_output | cut -d ' ' -f2 | grep -v '.monitor' | sort | uniq) )
	if [[ ${#sinks[@]} -eq 1 ]]; then
		SINK_NAME="${sinks[0]}"
	else
		if [[ ${#sinks[@]} -gt 0 ]]; then
			echo "Write one of the following lines to \"~/.pulseaudio_output\"" >&2
			for s in "${sinks[@]}"; do
				echo "SINK_NAME=\"$s\"" >&2
			done
		else
			echo "Can not find any pulseaudio sinks, manual write it into \"~.pulseaudio_output\"" >&2
		fi
		exit
	fi
fi
if [ -z "$SINK_NAME" ]; then
	echo "No configured sink!" >&2
	exit
fi

VOL_STEP=$((VOL_MAX / STEPS))
VOL_NOW=`pacmd dump | grep -P "^set-sink-volume $SINK_NAME\s+" | perl -p -i -e 's/.+\s(.x.+)$/$1/' 2>/dev/null`
MUTE_STATE=`pacmd dump | grep -P "^set-sink-mute $SINK_NAME\s+" | perl -p -i -e 's/.+\s(yes|no)$/$1/' 2>/dev/null`

function plus() {
        VOL_NEW=$((VOL_NOW + VOL_STEP))
        if [ $VOL_NEW -gt $((VOL_MAX)) ]; then
                VOL_NEW=$((VOL_MAX))
        fi
        pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
}

function minus() {
        VOL_NEW=$((VOL_NOW - VOL_STEP))
        if [ $(($VOL_NEW)) -lt $((0x00000)) ]; then
                VOL_NEW=$((0x00000))
        fi
        pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
}

function mute() {
        if [ $MUTE_STATE = no ]; then
                pactl set-sink-mute $SINK_NAME 1
        elif [ $MUTE_STATE = yes ]; then
                pactl set-sink-mute $SINK_NAME 0
        fi
}

function get() {
        BAR=""
        if [ $MUTE_STATE = yes ]; then
                BAR="mute"
                ITERATOR=$((STEPS / 2 - 2))
                while [ $ITERATOR -gt 0 ]; do
                        BAR=" ${BAR} "
                        ITERATOR=$((ITERATOR - 1))
                done
        else
                DENOMINATOR=$((VOL_MAX / STEPS))
                LINES=$((VOL_NOW / DENOMINATOR))
                DOTS=$((STEPS - LINES))
                while [ $LINES -gt 0 ]; do
                        BAR="${BAR}|"
                        LINES=$((LINES - 1))
                done
                while [ $DOTS -gt 0 ]; do
                        BAR="${BAR}."
                        DOTS=$((DOTS - 1))
                done
        fi
        echo "$BAR"
}

function xmobar_indicator() {
        percent=$(((VOL_NOW*100)/VOL_MAX))
        if [ $percent -le 20 ]; then
            color="#00cc00"
        elif [ $percent -le 60 ]; then
            color="#cccc00"
        else
            color="#cc0000"
        fi

        if [ $MUTE_STATE = yes ]; then
            echo -n '<fc=#cc0000>V</fc>'
        else
            echo -n 'V'
        fi
        echo "<fc=$color>$percent</fc>"
}

case "$1" in
        plus)
                plus
        ;;
        minus)
                minus
        ;;
        mute)
                mute
        ;;
        get)
                get
        ;;
        xmobar)
                xmobar_indicator
        ;;
esac
