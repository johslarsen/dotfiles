#!/bin/bash -
me=`basename "$0"`
mydir=`dirname "$0"`

die() {
    echo >&2 "$*"
    exit 1
}

if [ $# -lt 1 ]; then
    die "USAGE: $0 {o,al,ac,ar,bl,bc,br,lt,lc,lb,rt,rc,rb}"
fi

primary_relative_to_secondary=$1

screens=( $(xrandr -q | grep ' connected ' | cut -d ' ' -f 1) )
resolutions=( $(xrandr -q | grep -E '^[[:digit:][:space:]*.x]*\+' | awk '{print $1}') )

primary=${screens[0]}
secondary=${screens[1]}

if [ ${#resolutions[@]} -lt 2 ]; then
    die "Only ${#resolutions[@]} screens connected, and I need 2"
elif [ ${#resolutions[@]} -ne 2 ]; then
    echo -n "There are ${#resolutions[@]}, but I will only use the 2 first (${resolutions[0]} and ${resolutions[1]}), continue? [y/N]"
    read move_along
    lower=${move_along,,}
    [ "${move_along:0:1}" == "y" ] || exit 1
fi

pw=${resolutions[0]%x*}
sw=${resolutions[1]%x*}
ph=${resolutions[0]#*x}
sh=${resolutions[1]#*x}

case $primary_relative_to_secondary in
    o) coords=(0 0 0 0);;
    al) coords=(0 0 0 $ph);;
    ac) coords=($((sw/2-pw/2)) 0 0 $ph);;
    ar) coords=($((sw-pw)) 0 0 $ph);;
    bl) coords=(0 $sh 0 0);;
    bc) coords=($((sw/2-pw/2)) $sh 0 0);;
    br) coords=($((sw-pw)) $sh 0 0);;
    lt) coords=(0 0 $pw 0);;
    lc) coords=(0 $((sh/2-ph/2)) $pw 0);;
    lb) coords=(0 $((sh-ph)) $pw 0);;
    rt) coords=($sw 0 0 0);;
    rc) coords=($sw $((sh/2-ph/2)) 0 0);;
    rb) coords=($sw $((sh-ph)) 0 0);;
    *)
        die "\"$primary_relative_to_secondary\" is not a known relationship"
        ;;
esac

px=${coords[0]}
py=${coords[1]}
sx=${coords[2]}
sy=${coords[3]}

disable_disconnected_screens=$(xrandr -q | awk '/disconnected/{print "--output", $1, "--off"}')

xrandr $disable_disconnected_screens --output "$primary" --primary --mode ${pw}x${ph} --pos ${px}x${py} --rotate normal --output "$secondary" --mode ${sw}x${sh} --pos ${sx}x${sy} --rotate normal
