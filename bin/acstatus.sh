#!/bin/bash -
battery=${1:-/sys/class/power_supply/BAT0}
case "$(cat "$battery/status")" in
	"Full")        color="cccccc"; sign="+";;
	"Charging")    color="00cc00"; sign="+";;
	"Discharging") color="cc0000"; sign="-";;
	*)             color="0000cc"; sign"+";;
esac

if [ -f "$battery/power_now" ]; then
    P=$(echo "(0${sign}1*$(cat "$battery/power_now"))/10^6" | bc -l)
else
    I=$(cat "$battery/current_now")
    U=$(cat "$battery/voltage_now")
    P=$(echo "(0${sign}1*$I*$U)/10^12" | bc -l)
fi
printf "<fc=#$color>%+5.1f</fc>" $P
echo
