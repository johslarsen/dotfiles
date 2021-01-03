#!/bin/gawk -f
function quotes() {
    return gensub(/ /, ">", "g", sprintf("%*s", qlevel, ""))
}

/<blockquote/ {
    qlevel += 1
    if ($0 ~ /<br/) $0 = gensub(/(<blockquote[^/>]*>)/, "\\1"quotes()" ", "g", $0)
}
/<\/blockquote>/{qlevel -= 1}

qlevel > 0 && /<pre/ {
    in_pre = $0 !~ /<\/pre>/
    if (in_pre) print gensub(/(<pre[^>]*>)/, "\\1"quotes()" ", "g", $0)
    next
}
in_pre {
    $0 = quotes() OFS $0
}
qlevel > 0 && /<br/ && $0 !~ /<blockquote/ {
    $0 = gensub(/(<br[^>]*>)/, "\\1"quotes()" ", "g", $0)
}

{print}
