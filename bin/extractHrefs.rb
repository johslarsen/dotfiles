#!/usr/bin/env ruby
require 'optparse'

OptionParser.new do |o|
  o.on("-a", "--attr NAME[,...]", Array, "Extract urls from these attrs (defaults to href,src)")
end.permute!(into: $opts ||= {})

content = ARGF.read
tags = content.split(">")

urls = $opts.fetch(:attr, ["href", "src"]).map do |attr|
  tags.grep(/#{attr}[[:space:]]*=[[:space:]]*(["'])((?:\\\1|.)*?)\1/) { Regexp.last_match(2) }
end.compact.sort.uniq
puts urls
