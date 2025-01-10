#!/usr/bin/env ruby
require 'json'

# https://regex101.com/r/tA9pM8/1 rewritten to Ruby syntax, and remove final /\A.../\z/ to search for any substr that matches JSON
JSON_SUBSTR = /
(?:wannabe DEFINE, but Ruby does not support that, so lots of unlikely text then the relevant groups
(?<NUMBER>(?>-?(?>0|[1-9][0-9]*)(?>\.[0-9]+)?(?>[eE][+-]?[0-9]+)?))
(?<STRING>(?>"(?>\\(?>["\\\/bfnrt]|u[a-fA-F0-9]{4})|[^"\\\0-\x1F\x7F]+)*"))
(?<value>(?>true|false|null|\g<STRING>|\g<NUMBER>|\g<object>|\g<array>))
(?<array>(?>\[\s*(?>\g<value>(?>\s*,\s*\g<value>)*)?\s*\]))
(?<pair>(?>\g<STRING>\s*:\s*\g<value>))
(?<object>(?>\{\s*(?>\g<pair>(?>\s*,\s*\g<pair>)*)?\s*\}))
(?<json>(?>\s*\g<object>\s*|\s*\g<array>\s*))
)?
\g<json>/x

ARGF.read.scan(JSON_SUBSTR) do
  parsed = JSON.parse($&) rescue next
  puts JSON.fast_generate(parsed) # generates compact single-line json
end
