#!/usr/bin/env ruby
require 'fileutils'
require 'minitest/autorun'
require 'tmpdir'

require_relative '../test_helper'

class FindLinksTest < Minitest::Test

  FIND_LINKS = File.join DOTFILES, "scripts", "find_links.sh"

  def test_links_from_tmpdir
    Dir.mktmpdir do |dotfiles|
      FileUtils.mkdir_p File.join(dotfiles, "config")
      ["vimrc", "bashrc", "bashrc.d", "config/mc"]
        .each{|f| FileUtils.touch File.join(dotfiles, f)}
      Dir.mktmpdir do |hier|
        ["vimrc", "bashrc", "bashrc.d", "config/mc"].each do |p|
          link = File.join(hier, ".#{p}")
          FileUtils.mkdir_p File.dirname(link)
          FileUtils.ln_s File.join(DOTFILES, p), link
        end
        `ls #{hier}`
        assert_equal <<EOF, pipe("#{DOTFILES}/scripts/find_links.sh", DOTFILES, hier)
#{hier}/.bashrc
#{hier}/.bashrc.d
#{hier}/.config/mc
#{hier}/.vimrc
EOF
      end
    end
  end
end
