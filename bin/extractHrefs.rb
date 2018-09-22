#!/usr/bin/env ruby

content = ARGF.read
tags = content.split(">")

urls = tags.grep(/href[[:space:]]*=[[:space:]]*(["'])((?:\\\1|.)*?)\1/) {$2}
puts urls.sort.uniq
