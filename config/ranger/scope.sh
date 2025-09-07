#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

openscad_png() {
    [[ "$PV_IMAGE_ENABLED" ]] && openscad --colorscheme="Tomorrow Night" -o "$IMAGE_CACHE_PATH.png" "$@" && mv "$IMAGE_CACHE_PATH.png" "$IMAGE_CACHE_PATH"
}

FILE_EXTENSION="${FILE_PATH##*.}"
case "${FILE_EXTENSION,,}" in
  doc|docx) doctotxt < "${FILE_PATH}" && exit 5;;
  gpg) gpg --batch --pinentry-mode loopback --list-packets "${FILE_PATH}" && exit 5;;
  ini) cat "${FILE_PATH}" && exit 5;;
  htm|html|xhtml) elinks -dump "${FILE_PATH}" -dump-width $PV_WIDTH -dump-color-mode 3 && exit 5;;
  pyc) strings "${FILE_PATH}" && exit 5;;
  xlsx) xlsx2csv -i "${FILE_PATH}" && exit 5;;
  csg|scad) openscad_png "$FILE_PATH" && exit 6;;
  3mf|amf|dxf|off|stl) openscad_png <(echo "import(\"${FILE_PATH}\");") && exit 6;;
esac

MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
case "$MIMETYPE" in
  video/*) [[ "$PV_IMAGE_ENABLED" ]] && ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6;;
  *application|*object) readelf -hnsW "${FILE_PATH}" && exit 5;;
  *gzip) zcat "${FILE_PATH}" | head -${PV_HEIGHT} && exit 2;;
  *pcap) tcpdump -ttttnnr "${FILE_PATH}" | head -${PV_HEIGHT} && exit 3;;
  *sqlite3) sqlite3 -readonly "${FILE_PATH}" ".schema" && exit 0;;
  application/json) jq --color-output . < "${FILE_PATH}" && exit 5;;
esac

override_fallback() {
    sed 's/\(File Type Classification.*\) && exit.*/\1 \&\& xxd -R always "\${FILE_PATH}" | head -$((PV_HEIGHT-2)); exit 5/g' "$1"
}

. <(override_fallback /usr/share/doc/ranger/config/scope.sh) # arch
. <(override_fallback /usr/lib/python3.6/site-packages/ranger/data/scope.sh) # OpenSUSE 15.5
