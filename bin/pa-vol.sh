#!/bin/bash -

[ -e ~/.pulseaudio_output ] && source ~/.pulseaudio_output
SINK_NAME=${SINK_NAME:=$(pacmd dump | awk '/set-default-sink/{print $2}')}
SINK_NAME=${SINK_NAME:?No configured sink!}
SOURCE_NAME=${SOURCE_NAME:=$(pacmd dump | awk '/set-default-source/{print $2}')}

VOL_MAX="0x10000"
VOL_STEP=$((VOL_MAX / 32)) # divisor should be power of 2

VOL_NOW=$(pacmd dump | awk "/set-sink-volume $SINK_NAME/{print \$3}")
MUTE_STATE=$(pacmd dump | awk "/set-sink-mute $SINK_NAME/{print \$3==\"yes\"}")

MIC_ANY_ACTIVE=$(pacmd dump | grep -v monitor | grep 'set-source-mute.*no$' && echo 1 || echo 0)
MIC_MUTE=$(pacmd dump | awk "/set-source-mute $SOURCE_NAME/{print \$3==\"yes\"}")

case "$1" in
    plus)
        VOL_NEW=$((VOL_NOW + VOL_STEP))
        [ $VOL_NEW -gt $((VOL_MAX)) ] && VOL_NEW=$VOL_MAX
        pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
        ;;
    minus)
        VOL_NEW=$((VOL_NOW - VOL_STEP))
        [ $VOL_NEW -lt 0 ] && VOL_NEW=0
        pactl set-sink-volume $SINK_NAME `printf "0x%X" $VOL_NEW`
        ;;
    mute)
        pactl set-sink-mute $SINK_NAME $((MUTE_STATE^1))
        ;;
    mic)
        pactl set-source-mute $SOURCE_NAME $((MIC_MUTE^1))
        ;;
    xmobar)
        percent=$(((VOL_NOW*100)/VOL_MAX))
        if [ $percent -le 20 ]; then
            color="#00cc00"
        elif [ $percent -le 60 ]; then
            color="#cccc00"
        else SINK_NAME
            color="#cc0000"
        fi

        if [ $MIC_ANY_ACTIVE -ne 1 ]; then
            echo -n "<fc=#cc0000>M</fc>"
        elif [ $MIC_MUTE -eq 1 ]; then
            echo -n "<fc=#cc7700>M</fc>"
        else
            echo -n "M"
        fi
        if [ $MUTE_STATE -eq 1 ]; then
            echo -n '<fc=#cc0000>V</fc>'
        else
            echo -n 'V'
        fi
        echo "<fc=$color>$percent</fc>"

        ;;
esac
