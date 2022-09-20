#!/usr/bin/env ruby
require 'fileutils'
require 'tmpdir'

DOTFILES = File.realpath File.dirname(File.dirname(__FILE__))

# Public: Create a tmpdir filled with files/directories.
#
# paths - Strings of relative paths to touch (or mkdir if %r{/$}).
#
# Yields String with path to root of tmpdir.
# Returns whatever the block returns.
def tmpdir_with(*paths)
  Dir.mktmpdir do |root|
    paths.each do |relative|
      absolute = File.join(root, relative)
      if relative.end_with? '/'
        FileUtils.mkdir_p absolute
      else
        FileUtils.mkdir_p File.dirname(absolute)
        FileUtils.touch absolute
      end
    end
    yield root
  end
end

# Public: Run a command and get its output.
#
# *cmd - Strings with name of executable and the command arguments.
# stdin - A String to write as the commands stdin.
#
# Returns String with stdout and stderr from the command.
def pipe(*cmd, stdin: nil)
  IO.popen(cmd, "r+", err: %i[child out]) do |io|
    io.write stdin if stdin
    io.close_write
    io.read
  end
end
