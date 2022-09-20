#!/usr/bin/env ruby
require 'fileutils'
require 'minitest/autorun'
require 'socket'
require 'tmpdir'

require_relative '../test_helper'

class InstallTest < Minitest::Test
  INSTALL = File.join DOTFILES, "scripts", "install.rb"

  DEFUALT_DOTFILES = [
    "1.rc", "1/2.rc", "1/2/3.rc", "foo", "foo.d/bar"
  ]

  def test_install_into_empty_dir
    tmpdir_with(*DEFUALT_DOTFILES) do |root|
      Dir.mktmpdir do |target|
        assert_equal([
                       "ln -s #{root}/1 #{target}/.1",
                       "ln -s #{root}/1.rc #{target}/.1.rc",
                       "ln -s #{root}/foo #{target}/.foo",
                       "ln -s #{root}/foo.d #{target}/.foo.d",
                     ], pipe(INSTALL, "-r", root, "-t", target).split("\n").sort)
      end
    end
  end

  def test_install_with_content
    tmpdir_with(*DEFUALT_DOTFILES) do |root|
      tmpdir_with ".1.rc", ".1/2.rc", ".foo.d/" do |target|
        assert_equal([
                       "ln -s #{root}/1/2 #{target}/.1/2",
                       "ln -s #{root}/foo #{target}/.foo",
                       "ln -s #{root}/foo.d/bar #{target}/.foo.d/bar",
                     ], pipe(INSTALL, "-r", root, "-t", target).split("\n").sort)
      end
    end
  end

  HOST = Socket.gethostname
  OTHER = "UNCOMMON_HOSTNAME"

  def test_host_specific_overrides
    tmpdir_with(*DEFUALT_DOTFILES, "1/2@#{HOST}/3.rc", "1/2@#{OTHER}/3.rc",
                "new@#{OTHER}", "1.rc@#{OTHER}", "1/2/new",
                "foo.d@#{HOST}/bar", "foo@#{HOST}", "foo@#{OTHER}") do |root|
      Dir.mktmpdir do |target|
        assert_equal([
                       "ln -s #{root}/1.rc #{target}/.1.rc",
                       "ln -s #{root}/1/2.rc #{target}/.1/2.rc",
                       "ln -s #{root}/1/2@#{HOST} #{target}/.1/2",
                       "ln -s #{root}/foo.d@#{HOST} #{target}/.foo.d",
                       "ln -s #{root}/foo@#{HOST} #{target}/.foo",
                       "mkdir -p #{target}/.1",
                     ], pipe(INSTALL, "-r", root, "-t", target).split("\n").sort)
      end
    end
  end
end
