#!/bin/gawk -f
!last || substr($0, 0, length(last) + length(sep)) != last sep && last != $0 {
  print
  last = $0
}
