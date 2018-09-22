:silent %s/#CLASS#/\=ToCamel(RPath('%:t:r'))/g
:silent %s/#SOURCE#/\=ToSnake(ColonsToSlash(substitute(ModuleAndClass(), 'Test$', '', '')))/g
:silent %s/#MODULE_DECL#/\=ModuleDeclaration()/g
:silent %s/#MODULE_DECL_END#/\=ModuleDeclarationEnd()/g
:silent %s/#I#/\=IndentationString(1)/g
:silent %s/#MI#/\=empty(ModuleString(RPath('%:h')))?'':IndentationString(1)/g
#!/usr/bin/env ruby
require 'minitest/autorun'

require '#SOURCE#'
#MODULE_DECL#
#MI#class #CLASS# < MiniTest::Test
#MI##I#def setup
#MI##I#end

#MI##I#def teardown
#MI##I#end

#MI##I#def test_#CURSOR#
#MI##I#end
#MI#end#MODULE_DECL_END#
