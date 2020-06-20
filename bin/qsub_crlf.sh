#!/bin/bash -
replacement="${1:-\\n}"
awk -v ORS=\" -v RS=\" -v r="${replacement//\\/\\\\}" 'NR%2 == 0{gsub(/\n/, r)} {print}'
