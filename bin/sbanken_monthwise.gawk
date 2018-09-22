#!/bin/gawk -f
BEGIN{FS=";"}
match($0, /^"([0-9]{4}-[0-9]{2})-[0-9]{2}";/, m) {
	gsub(/,/, ".", $7)
	gsub(/,/, ".", $8)
	expense[m[1]] += $7
	income[m[1]] += $8
}

END {
	for (month in income) {
		print month, "+"income[month], "-"expense[month]
	}
}
