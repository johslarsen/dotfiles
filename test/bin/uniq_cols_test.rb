#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../test_helper'

class UniqColsTest < Minitest::Test

  INPUT = <<EOF
1
1 2
1 1
1 1 2
1 1 1 2
1 2 3
1 2 2 3 4
1 2 2 2 3 4
1 2 2 2 2 3 4
1 2 3 3
1 2 3 3 3
1 2 3 3 3 4
1 #{(["2"]*10).join(" ")} #{(["3"]*20).join(" ")} #{(["2"]*10).join(" ")} 1
EOF

  def test_from_stdin
    assert_equal <<EOF, pipe(File.join(DOTFILES, "bin", "uniq_cols.gawk"), stdin: INPUT)
1
1 2
1 1
1 1 2
1*3 2
1 2 3
1 2 2 3 4
1 2*3 3 4
1 2*4 3 4
1 2 3 3
1 2 3*3
1 2 3*3 4
1 2*10 3*20 2*10 1
EOF
  end
end
