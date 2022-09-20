#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../test_helper'

class UniqPrefixTest < Minitest::Test
  UNIQ = File.join DOTFILES, "bin", "uniq_prefix.gawk"
  SORTED_INPUT = <<~EOF
    foo
    foo
    foo/bar
    bar/baz
    bar/baz.d
  EOF

  def test_without_separator
    assert_equal <<~EOF, pipe(UNIQ, stdin: SORTED_INPUT)
      foo
      bar/baz
    EOF
  end

  def test_with_separator
    assert_equal <<~EOF, pipe(UNIQ, "-vsep=/", stdin: SORTED_INPUT)
      foo
      bar/baz
      bar/baz.d
    EOF
  end
end
