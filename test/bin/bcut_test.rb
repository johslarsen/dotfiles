#!/usr/bin/env ruby
require 'minitest/autorun'
require 'tempfile'
require_relative '../test_helper'

class BcutTest < Minitest::Test

  BCUT = File.join DOTFILES, 'bin', 'bcut'
  XD = File.join DOTFILES, 'bin', 'xd'

  def test_pass_along
    tmprecord hexmatrix(4, 16) do |f|
      assert_equal <<EOL, `#{BCUT} -f- #{f.path} | #{XD}`
000000 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
000010 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
000020 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
000030 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
000040
EOL
    end
  end

  def test_fields_and_count
    tmprecord hexmatrix(4, 16) do |f|
      # NOTE: -fLISTs are concatenated, and 0x prefix for hex
      assert_equal <<EOL, `#{BCUT} -c2 -f-2,0xd- -f1-2,6 #{f.path} | #{XD} -w9`
000000 00 01 02 0d 0e 0f 01 02 06
000009 10 11 12 1d 1e 1f 11 12 16
000012
EOL
    end
  end

  def test_width
    tmprecord hexmatrix(4, 16) do |f|
      # NOTE: the diagonals (i.e. misaligned by one)
      assert_equal <<EOL, `#{BCUT} -f-3 -w15 #{f.path} | #{XD} -w4`
000000 00 01 02 03
000004 0f 10 11 12
000008 1e 1f 20 21
00000c 2d 2e 2f 30
000010 3c 3d 3e 3f
000014
EOL
    end
  end

  def test_skip_and_partial_end_of_record
    tmprecord hexmatrix(4, 16) do |f|
      # NOTE: skip does not have to be a multiple of the width
      assert_equal <<EOL, `#{BCUT} -f0- -s7 #{f.path} | #{XD}`
000000 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16
000010 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26
000020 27 28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36
000030 37 38 39 3a 3b 3c 3d 3e 3f
000039
EOL
    end
  end

  def test_multiple_files
    tmprecord hexmatrix(4, 16) do |f|
      Tempfile.create do |rev|
        rev.write(f.read.reverse)
        rev.flush
        assert_equal <<EOL, `#{BCUT} -f0- -s8 #{f.path} #{rev.path} | #{XD}`
000000 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17
000010 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27
000020 28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37
000030 38 39 3a 3b 3c 3d 3e 3f 37 36 35 34 33 32 31 30
000040 2f 2e 2d 2c 2b 2a 29 28 27 26 25 24 23 22 21 20
000050 1f 1e 1d 1c 1b 1a 19 18 17 16 15 14 13 12 11 10
000060 0f 0e 0d 0c 0b 0a 09 08 07 06 05 04 03 02 01 00
000070
EOL
      end
    end
  end

  def test_stdin
    assert_equal <<EOL, pipe(BCUT, "-w#{16*3}", "-f0-1,4,7-", stdin: ascii(hexmatrix(4,16)))
0012 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
1012 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
2012 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
3012 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
EOL
  end

  def test_stdin_and_other_files
    Tempfile.create do |rev|
      input = ascii hexmatrix(4,16)
      rev.write input.chomp.reverse + "\n"
      rev.flush
      # NOTE: only reverse, need '-' parameter to read stdin and other files
      assert_equal <<EOL, pipe(BCUT, "-w#{16*3}", "-f0-47", rev.path, stdin: ascii(hexmatrix(4,16)))
f3 e3 d3 c3 b3 a3 93 83 73 63 53 43 33 23 13 03
f2 e2 d2 c2 b2 a2 92 82 72 62 52 42 32 22 12 02
f1 e1 d1 c1 b1 a1 91 81 71 61 51 41 31 21 11 01
f0 e0 d0 c0 b0 a0 90 80 70 60 50 40 30 20 10 00
EOL

      assert_equal <<EOL, pipe(BCUT, "-w#{16*3}", "-f-", rev.path, '-', stdin: ascii(hexmatrix(4,16)))
f3 e3 d3 c3 b3 a3 93 83 73 63 53 43 33 23 13 03
f2 e2 d2 c2 b2 a2 92 82 72 62 52 42 32 22 12 02
f1 e1 d1 c1 b1 a1 91 81 71 61 51 41 31 21 11 01
f0 e0 d0 c0 b0 a0 90 80 70 60 50 40 30 20 10 00
00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
EOL
    end
  end

  DEVNULL = {out: '/dev/null', err: '/dev/null', in: '/dev/null'}
  def test_errors
    refute system BCUT, '-w-1', DEVNULL # NonNegative, same for -c,-s
    refute system BCUT, DEVNULL # needs a field descriptor
    refute system BCUT, '-fa', DEVNULL # not a number
    refute system BCUT, '-f-1-1', DEVNULL # negative from
    refute system BCUT, '-f3-2', DEVNULL # from > to
    refute system BCUT, '-w3', '-f3', DEVNULL # fields must be < width
  end

  private

  def hexmatrix(nrow, ncol)
    (0...nrow).map do |row|
      (0...ncol).map{|col| (row<<4) + col}
    end
  end

  def ascii(matrix)
    matrix.map{|r| r.map{|c|"%02x"%[c]}.join(" ")}.join("\n") << "\n"
  end

  def tmprecord(matrix)
    Tempfile.create do |f|
      matrix.each do |row|
        f.write row.pack("c*")
      end
      f.rewind
      f.flush
      yield f
    end
  end
end
