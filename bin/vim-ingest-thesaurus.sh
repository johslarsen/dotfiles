#!/bin/bash -
url=${1:-https://github.com/vim/vim/files/2634525/thesaurus_pkg.zip}
name=${2:-english.txt}
mkdir -p ~/.vim/thesaurus
tmp="/tmp/thesaurus_$name.zip"
wget -O "$tmp" "$url" && unzip -qc "$tmp" thesaurus_pkg/thesaurus.txt | awk 'NR>2' | iconv -f iso-8859-1 -t utf-8 > ~/.vim/thesaurus/"$name"
