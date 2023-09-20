#!/bin/bash -
shopt -s globstar

repo_root=`dirname "$(dirname "$0")"`
root=`readlink -f "${1:-$repo_root}"`
link_hier=${2:-$HOME}

for target in "$root"/**; do
    target="${target%@*}" # look for links without host-specific override syntax
    link="$link_hier/.${target#$root/}"
    [ -h "$link" ] && [[ "$(readlink -f "$link")" =~ "$root"  ]] && echo "$link"
done | sort | "$repo_root"/bin/uniq_prefix.gawk -v sep=/
