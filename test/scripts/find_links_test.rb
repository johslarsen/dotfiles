#!/usr/bin/env ruby
require 'minitest/autorun'

require_relative '../test_helper'

class FindLinksTest < Minitest::Test

  FIND_LINKS = File.join DOTFILES, "scripts", "find_links.sh"

  def test_links_from_tmpdir
    tmpdir_with("config/mc", "vimrc", "bashrc", "bashrc.d") do |dotfiles|
      tmpdir_with(".config/") do |hier|
        ["vimrc", "bashrc", "bashrc.d", "config/mc"].each do |p|
          link = File.join(hier, ".#{p}")
          FileUtils.ln_s File.join(dotfiles, p), link
        end
        assert_equal <<EOF, pipe("#{DOTFILES}/scripts/find_links.sh", dotfiles, hier)
#{hier}/.bashrc
#{hier}/.bashrc.d
#{hier}/.config/mc
#{hier}/.vimrc
EOF
      end
    end
  end
end
