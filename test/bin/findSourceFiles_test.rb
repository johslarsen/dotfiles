#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../test_helper'

class FindSourceFilesTest < Minitest::Test

  FIND = File.join DOTFILES, "bin", "findSourceFiles.sh"

  SRC_SUFFIXES = %w{c cpp rb sh py java txt proto vim js html md json xml conf sql} # common ones
  SOURCES = ["config", "bar/ini", "baz/foorc",
             SRC_SUFFIXES.map{|s| ["foo.#{s}", "bar/baz/foo.#{s}"]}].flatten.sort

  BIN_SUFFIXES = %w{bin exe o obj pyc class pdf jpeg jpg mkv swp sqlite3} # common ones
  BINARIES = [".#foo", "bar/.#baz", "foo.txt~", "bar/baz.c~",
              BIN_SUFFIXES.map{|s| ["foo.#{s}", "bar/baz/foo.#{s}"]}].flatten.sort

  UNDER_REPO = SOURCES.map{|p| [".git/#{p}", "bar/.git/#{p}", ".svn/#{p}"]}.flatten.sort

  def test_with_some_common_files
    tmpdir_with(*BINARIES, *SOURCES, *UNDER_REPO) do |root|
      assert_equal(SOURCES, pipe(FIND, root).split("\n").sort)
    end
  end
end
