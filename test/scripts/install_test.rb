#!/usr/bin/env ruby
require 'fileutils'
require 'minitest/autorun'
require 'socket'
require 'tmpdir'

require_relative '../test_helper'


class InstallTest < Minitest::Test

  INSTALL = File.join DOTFILES, "scripts", "install.rb"

  def test_install_into_empty_dir
    with_root_and_target_tmpdirs do |root, target|
      assert_equal([
        "ln -s #{root}/1 #{target}/.1",
        "ln -s #{root}/1.rc #{target}/.1.rc",
        "ln -s #{root}/foo #{target}/.foo",
        "ln -s #{root}/foo.d #{target}/.foo.d",
      ], pipe(INSTALL, "-r", root, "-t", target).split("\n").sort)
    end
  end

  def test_install_with_content
    with_root_and_target_tmpdirs do |root, target|
      ['.1', '.foo.d'].each{|d| FileUtils.mkdir_p File.join(target, d)}
      ['.1.rc', '.1/2.rc'].each{|f| FileUtils.touch File.join(target, f)}
      assert_equal([
        "ln -s #{root}/1/2 #{target}/.1/2",
        "ln -s #{root}/foo #{target}/.foo",
        "ln -s #{root}/foo.d/bar #{target}/.foo.d/bar",
      ], pipe(INSTALL, "-r", root, "-t", target).split("\n").sort)
    end
  end

  HOST = Socket.gethostname
  OTHER = "UNCOMMON_HOSTNAME"

  def test_host_specific_overrides
    with_root_and_target_tmpdirs do |root, target|
      ["1/2@#{HOST}", "1/2@#{OTHER}", "foo.d@#{HOST}", "foo.d@#{OTHER}"]
        .each{|d| FileUtils.mkdir_p File.join(root, d)}
      ["1.rc@#{OTHER}", "new@#{OTHER}", "1/2@#{HOST}/3.rc", "1/2@#{OTHER}/3.rc",
       "1/2@#{OTHER}/new", "foo.d@#{HOST}/bar", "foo@#{HOST}", "foo@#{OTHER}"]
        .each{|f| FileUtils.touch File.join(root, f)}
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

  private

  def with_root_and_target_tmpdirs
    Dir.mktmpdir do |root|
      ['1/2', 'foo.d'].each{|d| FileUtils.mkdir_p File.join(root, d)}
      ['1.rc', '1/2.rc', '1/2/3.rc', 'foo', 'foo.d/bar']
        .each{|f| FileUtils.touch File.join(root, f)}
      Dir.mktmpdir do |target|
        yield root, target
      end
    end
  end
end
