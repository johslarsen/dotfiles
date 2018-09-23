#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../test_helper'

class MarkFieldsTest < Minitest::Test

  MARK = File.join DOTFILES, "bin", "mark_fields"
  INPUT = [
    ["a","b","c"],
    [0,1,2,3,4,5,],
  ]

  def test_default_marking
    assert_equal <<EOL, pipe(MARK, "-m1,3,5", stdin: INPUT.map{|l|l.join(" ")}.join("\n"))
a >b< c
0 >1< 2 >3< 4 >5<
EOL
  end

  def test_custom_marking
    input = INPUT.reverse.map{|l|l.join(",")}.join("\n")
    assert_equal <<EOL, pipe(MARK, "-m0,2", '-p ', '-F,', '--suffix=', stdin: input)
 0,1, 2,3,4,5
 a,b, c
EOL
  end
end
