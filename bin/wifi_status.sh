#!/bin/bash -
dev=$(iw dev | grep Interface | grep wl | head -1 | awk '{print $2}')
link="$(iw dev "$dev" link)"

RE_SSID="SSID: ([^[:space:]]*)"
RE_SIGNAL="signal: ([-[:digit:]]*)"
RE_BITRATE="tx bitrate: ([[:digit:]]*)"
[[ "$link" =~ $RE_SSID ]] && essid="${BASH_REMATCH[1]}"
[[ "$link" =~ $RE_SIGNAL ]] && signal="${BASH_REMATCH[1]}"
[[ "$link" =~ $RE_BITRATE ]] && bitrate="${BASH_REMATCH[1]}"

rfkill list | awk -v RS='^[^\\s]' '{gsub(/\n/, " "); if (NF > 0) print}' | grep -v 'yes'&> /dev/null || flight="<fn=1>✈</fn>"
[[ "$essid" ]] && printf "%s<fc=#4444ff>%03d</fc>\n" "$essid" "$signal" || echo $flight
