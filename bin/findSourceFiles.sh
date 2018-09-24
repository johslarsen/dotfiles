#!/bin/bash -
find "$@" \( -false\
		-o -name .bzr -o -name CVS -o -name .git -o -name .hg -o -iname .svn\
		-o -iname __pycache__ -o -iname py-env\
		-o -name '.#*' -o -name '*.swp' -o -name '*~'\
		-o -regex '.*\.\(aux\|bbl\|fls\|lof\|lot\|pdf\|ps\|toc\)'\
		-o -regex '.*\.\(bin\|exe\|class\|lo\|mem\|o\|obj\|pyc\|.pyo\|so\|sqlite.\|gpg\)'\
		-o -iregex '.*\.\(bmp\|dvi\|gif\|jpe?g\|pdf\|png\|psw\|thumb\)'\
		-o -iregex '.*\.\(avi\|divx\|flac\|mkv\|mpe?g\|mp[0-9]\|m?ts\|og.\|wav\|webm2?\|wm.\)'\
	\) -prune\
   	-o -type f -printf "%P\n"\
	2>/dev/null
