# Johs' dotfiles

Here be dragons, but those who dare explore may discover lots of useful stuff.

This repository is my current method for distributing and syncing the scripts
and configuration for how I like to personalize my systems across the different
machines and installations I use. Over the years I have accumulated bits and
pieces from configuration examples all over the internet, so lots of this is
based (at least initially) on copy-and-paste, and as such I feel no right to
claim any ownership to the contents of this repository. I am publishing all of
this to serve as examples and inspirational sources for anyone who tinkers with
their system, and anyone is free to use all of this however they see fit.

## Install
```sh
git clone --recurse-submodules https://github.com/johslarsen/dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/install.rb
```

This will symbolically link all the files/directories there does not already
exist any corresponding dotfiles for as dotfiles in your home directory. Files
suffixed with `@HOSTNAME` are host-specific overrides, which are only linked to
on those particular hosts, and they take precedence over any equivalent files
without the host suffix.

### Uninstall
```sh
~/.dotfiles/scripts/find_links.sh | xargs rm -v
```

## Bugs

Feedback and pull-requests are welcome, but this is my personal configuration,
so I do not feel any obligation to merge anything I do not like.
