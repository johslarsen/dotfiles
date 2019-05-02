#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"

case "${FILE_EXTENSION,,}" in
  doc|docx) doctotxt < "${FILE_PATH}" && exit 5;;
  gpg) gpg --batch --pinentry-mode loopback --list-packets "${FILE_PATH}" && exit 5;;
  ini) cat "${FILE_PATH}" && exit 5;;
  pyc) strings "${FILE_PATH}" && exit 5;;
  xlsx) xlsx2csv -i "${FILE_PATH}" && exit 5;;

esac

MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
case "$MIMETYPE" in
  video/*) [[ "$PV_IMAGE_ENABLED" ]] && ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6;;
  *application|*object) readelf -hnsW "${FILE_PATH}" && exit 5;;
  *gzip) zcat "${FILE_PATH}" | head -${PV_HEIGHT} && exit 3;;
  *pcap) tcpdump -ttttnnr "${FILE_PATH}" | head -${PV_HEIGHT} && exit 3;;
  *sqlite3) sqlite3 -readonly "${FILE_PATH}" ".schema" && exit 0;;
  application/json) json_pp < "${FILE_PATH}" && exit 5;;
  application/octet-stream) xxd "${FILE_PATH}" | head -${PV_HEIGHT} && exit 3;;
esac

. /usr/share/doc/ranger/config/scope.sh
