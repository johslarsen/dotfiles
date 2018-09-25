#!/bin/gawk -f
NF < 4
NF >= 4 {
	count = 1
	printf "%s", $1
	if ($1 != $2) printf "%s", OFS $2
	else count = 2
	for (i = 3; i <= NF; i++) {
		p = i-1
		if ($p == $i) {
			count += 1
		} else {
		    if (count == 1) printf "%s", OFS $i
			else if (count == 2) printf "%s", OFS $p OFS $i
			else printf "*%d%s", count, OFS $i
			count = 1
		}
	}
	if (count == 2) printf "%s", OFS $NF
	if (count > 2) printf "*%d", count
	printf "\n"
}
