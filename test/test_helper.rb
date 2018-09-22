#!/usr/bin/env ruby

DOTFILES = File.realpath File.dirname(File.dirname(__FILE__))

def pipe(*cmd, stdin: nil)
  IO.popen(cmd, "r+", err: [:child, :out]) do |io|
    io.write stdin if stdin
    io.close_write
    io.read
  end
end
