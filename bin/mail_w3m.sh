#!/bin/bash -
rel=$(dirname "$0")
for path in "$@"; do
    while read part_charset; do
        "$rel/mail_mimepart.py" "${part_charset%% *}" < "$path" | w3m -I "${part_charset##* }" -T text/html
    done < <("$rel/mail_mimepart.py" < "$path" | awk '/html/{print $1, $3; exit}')
done

