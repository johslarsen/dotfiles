#!/bin/bash -
sed 's/align="center"//g' | elinks -dump -dump-width ${COLUMNS:-$(tput cols)} -force-html -no-home -eval "set document.codepage.assume=\"${CHARSET:-UTF-8}\"" -eval "set document.css.enable=0"
