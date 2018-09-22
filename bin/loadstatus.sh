#!/bin/bash -
l=( $(cat /proc/loadavg) )
nproc=$(nproc)

color() {
	scalar=${2:-1}
	if [ $1 -lt $((1*scalar)) ]; then
		echo "00cc00"
	elif [ $1 -lt $((nproc*scalar)) ]; then
		echo "cccc00"
	else
		echo "cc0000"
	fi
}

l5=${l[1]}

# subtract the measuring process
nrun=$((${l[3]%/*}-1))
ntot=$((${l[3]#*/}-1))

printf "L<fc=#%s>%.1f</fc> <fc=#%s>%i</fc>/<fc=#%s>%i</fc>\n" $(color ${l5%.*}) ${l5} $(color $nrun) $nrun $(color $ntot 300) $ntot
