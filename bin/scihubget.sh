#!/bin/bash -
me=`basename "$0"`
mydir=`dirname "$0"`

username=johslarsen
password=$(printf "%s" "$(pass website/scihub.copernicus.eu | head -1)")

for uuid in "$@"; do
	if wget  --content-disposition -O $uuid.zip --no-verbose --show-progress --no-check-certificate --continue --user=$username --password=$password "https://scihub.copernicus.eu/dhus/odata/v1/Products('$uuid')/\$value"; then
		name=$(unzip -l $uuid.zip | head -4 | tail -1 | awk '{print $4}' | cut -d '.' -f 1)
		[ -e $name.zip ] || ln -s $uuid.zip $name.zip

		wget  --content-disposition -O - --no-verbose --show-progress --no-check-certificate --user=$username --password=$password "https://scihub.copernicus.eu/dhus/odata/v1/Products('$uuid')/Checksum/Value/\$value" | tr 'A-Z' 'a-z' > $uuid.md5
		[ -e $name.md5 ] || ln -s $uuid.md5 $name.md5

		md5expected="$(cat $uuid.md5)"
		md5actual="$(md5sum $uuid.zip)"
		[[ "${md5expected%% *}" == "${md5actual%% *}" ]] || echo "$uuid: "$'\e[0;31m'"MD5 MISMATCH"$'\e[0m'
	fi
done
