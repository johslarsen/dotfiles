#!/bin/bash -

skip_binaries() {
    cat | grep -v '^-'
}

echo -e "#ncommit_touched	nline+	nline-	filename"
git log "$@" --pretty=tformat: --numstat | skip_binaries | sort -k 3 | awk 'BEGIN{prev=""} prev!="" && prev!=$3 {print n"\t"a"\t"s"\t"prev; n=0;a=0;s=0} {n+=1;a+=$1;s+=$2;prev=$3;}'
