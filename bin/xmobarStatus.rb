#!/usr/bin/env ruby
require 'etc'
NPROC = Etc.nprocessors
LOW = "#00aa00"
MEDIUM = "#aaaa00"
HIGH = "#aa0000"

def colored(color, content)
  "<fc=#{color}>#{content}</fc>"
end

def pcolored(percent, content)
  colored(percent < 20 ? LOW : percent > 60 ? HIGH : MEDIUM, content)
end

def ncolored(bytes, content)
  colored(bytes < 250e3 ? LOW : bytes < 2e6 ? MEDIUM : HIGH, content)
end

def dcolored(bytes, content)
  colored(bytes < 3e6 ? LOW : bytes < 20e6 ? MEDIUM : HIGH, content)
end

def used(idle)
  [100 - idle, 99].min
end

class CPU
  def initialize
    @then = nil
    @previous = []
  end

  def sample
    now = Time.now
    current = File.open("/proc/stat").each_line.reduce([]) do |idles, l|
      break idles unless l.start_with? "cpu"

      idles << l.split[4].to_i
    end.compact
    if @then
      dt = now - @then
      idles = current.zip(@previous).map { |c, p| (c - p) / dt }
      total = used(idles[0] / (idles.size - 1))
      per_core = idles[1..-1].map do |i|
        u = used(i)
        pcolored(u, format("%d", (u / 10)))
      end
      "C#{pcolored(total, '%2d' % total)}(#{per_core.join})"
    end
  ensure
    @then = now
    @previous = current
  end
end

class Network
  def initialize
    @then = nil
    @previous = []
  end

  def sample
    now = Time.now
    current = File.open("/proc/net/dev").readlines.grep(/^ *[we]/).reduce([0, 0]) do |rt, l|
      tokens = l.split
      [rt[0] + tokens[1].to_i, rt[1] + tokens[9].to_i]
    end
    if @then
      dt = now - @then
      r, t = current.zip(@previous).map do |c, p|
        b = (c - p) / dt
        ncolored(b, (format("%.3f", (b / 1e6)))[0..4])
      end
      "#{r}RT#{t}"
    end
  ensure
    @then = now
    @previous = current
  end
end

class Disk
  def initialize
    @then = nil
    @previous = []
  end

  def sample
    now = Time.now
    current = File.open("/proc/diskstats").readlines.grep_v(/ 0 (nvm|mm|hd|sd)/).reduce([0, 0]) do |rw, l|
      tokens = l.split
      [rw[0] + 512 * tokens[5].to_i, rw[1] + 512 * tokens[9].to_i]
    end
    if @then
      dt = now - @then
      r, t = current.zip(@previous).map do |c, p|
        b = (c - p) / dt
        dcolored(b, (format("%.1f", (b / 1e6)))[0..2])
      end
      "#{r}RW#{t}"
    end
  ensure
    @then = now
    @previous = current
  end
end

def mem
  total, _, available = File.open("/proc/meminfo").reduce([]) do |kbs, line|
    break kbs if kbs.size == 3

    kbs << line.split[1].to_f
  end
  used = used(100 * available / total)
  "M#{pcolored(used, '%2d' % [used, 99].min)}"
end

def load_avg
  l1 = File.read("/proc/loadavg").split[0].to_f
  "#{colored(l1 < 1 ? LOW : l1 < NPROC ? MEDIUM : HIGH, '%1.1f' % l1)}L"
end

cpu = CPU.new
network = Network.new
disk = Disk.new
loop do
  puts ["#{load_avg}#{cpu.sample}", mem, network.sample, disk.sample].compact.join(" ")
  $stdout.flush
  sleep 1
end
