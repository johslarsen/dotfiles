#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../test_helper'

class DolatestTest < Minitest::Test

  DOLATEST = File.join DOTFILES, "bin", "dolatest"

  def test_in_current_directory
    tmpdir_with "3", "1" do |root|
      sleep 0.01
      FileUtils.touch File.join(root, "2")
      Dir.chdir root do
        assert_equal "foo ./2\n", pipe(DOLATEST, "echo", "foo")
      end
    end
  end

  def test_with_dir_arg
    tmpdir_with "3", "1" do |root|
      sleep 0.01
      FileUtils.touch File.join(root, "2")
      assert_equal "#{root}/2\n", pipe(DOLATEST, "\ls", "---", root)
    end
  end

  def test_with_dir_args
    tmpdir_with "1/3", "1/1", "3" do |root|
      sleep 0.01
      FileUtils.touch File.join(root, "2")
      sleep 0.01
      FileUtils.touch File.join(root, "1/2") # NOTE: this updates access on 1/
      assert_equal <<EOF, pipe(DOLATEST, "echo", "foo", "---", root, File.join(root, "1"))
foo #{root}/1 #{root}/1/2
EOF
    end
  end
end
