#!/bin/bash -
iconv -f "${1:-utf-8}" -t utf-8 | "${0%.sh}.gawk"
