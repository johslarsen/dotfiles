#!/usr/bin/env ruby
require 'fileutils'
require 'optparse'
require 'set'
require 'socket'

$opts = {}
OptionParser.new do |o|
  $opts[:root] = File.realpath File.dirname(File.dirname(__FILE__))
  o.on "-r", "--root DIR", "The DIR hierarchy to symlink to" do |p|
    $opts[:root] = File.realpath p
  end

  $opts[:target] = File.expand_path('~')
  o.on "-t", "--target DIR", "The DIR hierarchy to put links in" do |p|
    $opts[:target] = File.realpath p
  end

  $opts[:blacklist] = ["README.md", "LICENSE", "script/**/*", "test/**/*"]
  o.on "-b", "--blacklist PATERN,...", Array,
      "Do not link to the following filename PATTERN,... relative to root.",
      "Default: #{$opts[:blacklist].join ","}" do |patterns|
    $opts[:blacklist] = patterns
  end
end.permute!
BLACKLISTED = Set.new $opts[:blacklist].map{|p| Dir.glob File.join($opts[:root], p)}.flatten

def link_for(target)
  File.expand_path File.join($opts[:target], ".#{target[($opts[:root].size + 1)..-1]}")
end

OVERRIDE_SUFFIX = "@#{Socket.gethostname}"
overridden = Set.new
Dir.glob(File.join($opts[:root], "**", "*@*")).each do |target|
  l = link_for target
  FileUtils.mkdir_p File.dirname(l), verbose: true unless Dir.exist?(File.dirname(l))
end
Dir.glob(File.join($opts[:root], "**", "*#{OVERRIDE_SUFFIX}")).each do |target|
  overridden << (t = target[0..-OVERRIDE_SUFFIX.length-1])
  l = link_for t
  FileUtils.ln_s target, l, verbose: true unless File.exist? l
end

Dir.glob(File.join($opts[:root], "**", "*")).sort.reverse_each do |target|
  next if BLACKLISTED.include? target
  next if target =~ /@/ # the host-specific glob handles those
  next unless File.symlink?(target) || File.file?(target) # skip intermediate directories

  link, target = loop.reduce(nil) do |shallowest_link_point|
    break shallowest_link_point if target == $opts[:root]
    break nil if overridden.include? target

    l = link_for(target)
    if File.symlink?(l)
      unless File.exist?(File.readlink(l))
        break nil # broken link, so just ignore it
      end
      if target.start_with?(File.realpath(l))
        break nil # an intermediate directory have already been linked
      end
    end

    shallowest_link_point ||=  Dir.exist?(File.dirname(l)) && [l, target]
    target = File.dirname(target) # traverse up the hierarchy
    shallowest_link_point
  end
  FileUtils.ln_s target, link, verbose: true if link && !File.exist?(link)
end
