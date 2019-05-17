set history filename ~/.gdb_history
set history save

set verbose off
set confirm off

set output-radix 0x10
set input-radix 0x10

define frame
  info frame
  info args
  info locals
end

define rbbt
  call (void)rb_backtrace()
end
