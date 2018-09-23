#!/usr/bin/env ruby
require 'minitest/autorun'
require 'set'
require_relative '../test_helper'

class NrandfileTest < Minitest::Test

  def test_that_2_runs_gives_different_result
    files = Set.new(1.upto(100).map{|n| n.to_s})
    tmpdir_with(*files) do |root|
      a = nrandfile(4, root)
      assert_equal 4, a.length
      assert a.subset? files

      b = nrandfile(4, root)
      assert_equal 4, b.length
      assert b.subset? files

      if a == b # possible, but very unlike
        skip "Two 4/100 draws happens to return the same set of files"
      end
    end
  end

  private

  def nrandfile(n, dir)
    files = pipe(File.join(DOTFILES, "bin", "nrandfile"), n.to_s, dir)
              .split("\n")
              .map{|p|p[(dir.length+1)..-1]}
    Set.new files
  end
end
