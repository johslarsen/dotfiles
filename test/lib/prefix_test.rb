#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative '../../lib/prefix'

class PrefixTest < Minitest::Test
  def test_si_prefix
    assert_equal "1e-06yg", Prefix.si(10**-30, "g")
    assert_equal "1yg", Prefix.si(10**-24, "g")
    assert_equal "1zg", Prefix.si(10**-21, "g")
    assert_equal "1ag", Prefix.si(10**-18, "g")
    assert_equal "1fg", Prefix.si(10**-15, "g")
    assert_equal "1pg", Prefix.si(10**-12, "g")
    assert_equal "1ng", Prefix.si(10**-9, "g")
    assert_equal "1ug", Prefix.si(10**-6, "g")
    assert_equal "1mg", Prefix.si(10**-3, "g")
    assert_equal "1g", Prefix.si(1, "g")
    assert_equal "1kg", Prefix.si(10**3, "g")
    assert_equal "1.024kB", Prefix.si(2**10, "B")
    assert_equal "1Mg", Prefix.si(10**6, "g")
    assert_equal "1.04858MB", Prefix.si(2**20, "B")
    assert_equal "1Gg", Prefix.si(10**9, "g")
    assert_equal "1.07374GB", Prefix.si(2**30, "B")
    assert_equal "1Tg", Prefix.si(10**12, "g")
    assert_equal "1.09951TB", Prefix.si(2**40, "B")
    assert_equal "1Pg", Prefix.si(10**15, "g")
    assert_equal "1.1259PB", Prefix.si(2**50, "B")
    assert_equal "1Eg", Prefix.si(10**18, "g")
    assert_equal "1.15292EB", Prefix.si(2**60, "B")
    assert_equal "1Zg", Prefix.si(10**21, "g")
    assert_equal "1Yg", Prefix.si(10**24, "g")
    assert_equal "1e+06Yg", Prefix.si(10**30, "g")
  end

  def test_binary_prefix
    assert_equal "9.53674e-07B", Prefix.bin(1.0/2**20)
    assert_equal "1B", Prefix.bin(2**0)
    assert_equal "1", Prefix.bin(2**0, nil)
    assert_equal "1000B", Prefix.bin(10**3)
    assert_equal "1KiB", Prefix.bin(2**10)
    assert_equal "1K", Prefix.bin(2**10, nil)
    assert_equal "976.562KiB", Prefix.bin(10**6)
    assert_equal "1MiB", Prefix.bin(2**20)
    assert_equal "1M", Prefix.bin(2**20, nil)
    assert_equal "953.674MiB", Prefix.bin(10**9)
    assert_equal "1GiB", Prefix.bin(2**30)
    assert_equal "1G", Prefix.bin(2**30, nil)
    assert_equal "931.323GiB", Prefix.bin(10**12)
    assert_equal "1TiB", Prefix.bin(2**40)
    assert_equal "1T", Prefix.bin(2**40, nil)
    assert_equal "909.495TiB", Prefix.bin(10**15)
    assert_equal "1PiB", Prefix.bin(2**50)
    assert_equal "1P", Prefix.bin(2**50, nil)
    assert_equal "888.178PiB", Prefix.bin(10**18)
    assert_equal "1EiB", Prefix.bin(2**60)
    assert_equal "1E", Prefix.bin(2**60, nil)
    assert_equal "867.362EiB", Prefix.bin(10**21)
    assert_equal "1.04858e+06EiB", Prefix.bin(2**80)
  end
end
