#!/usr/bin/env ruby
module Prefix
  SI2LOG10 = {y: -24, z: -21, a: -18, f: -15, p: -12, n: -9, u: -6, m: -3,
              "": 0, k: 3, M: 6, G: 9, T: 12, P: 15, E: 18, Z: 21, Y: 24}
  LOG102SI = SI2LOG10.map{|p,l10|(l10...(l10+3)).map{|l| [l,p]}}.flatten(1).to_h
  def self.si(n, unit="", format:"%g")
    l10 = Math.log10(n).to_i
    p = LOG102SI[l10] || (l10 < -24 ? :y : :Y)
    "#{format}%s%s" % [n.to_r / 10**SI2LOG10[p], p, unit]
  end
  BIN2LOG2 = {"": 0, Ki: 10, Mi: 20, Gi: 30, Ti: 40, Pi: 50, Ei: 60}
  LOG22BIN = BIN2LOG2.map{|p,l2|(l2...(l2+10)).map{|l| [l,p]}}.flatten(1).to_h
  def self.bin(n, unit="B", format:"%g")
    l2 = Math.log2(n).to_i
    p = LOG22BIN[l2] || (l2 < 0 ? :"" : :Ei)
    "#{format}%s%s" % [n.to_r / 2**BIN2LOG2[p], unit.nil? ? p.to_s[0] : p, unit]
  end
end
