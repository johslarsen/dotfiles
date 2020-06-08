#!/bin/gawk -f
BEGIN {
	DARK_GRAY = "\033[1;30m"
	DARK_MAGENTA = "\033[0;35m"
	NC = "\033[0m"
}
match($0, /^([> ]*>)/, m) {
	level = split(m[1], _, ">")
	print (level % 2 == 0 ? DARK_GRAY : DARK_MAGENTA) $0 NC
	next
}
/^-- $/||/-Original Message-/,/^$/ {
	print DARK_GRAY $0 NC
	next
}
{ print }
