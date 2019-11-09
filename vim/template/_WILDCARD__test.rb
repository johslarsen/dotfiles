:silent %s/#SOURCE#/\=ToSnake(ColonsToSlash(substitute(ModuleAndClass(), 'Test$', '', '')))/g
:silent %s/#MODULE_DECL#/\=ModuleDeclaration()/g
:silent %s/#MODULE_DECL_END#/\=ModuleDeclarationEnd()/g
#!#SNIPPET#
require 'minitest/autorun'
require '#SOURCE#'
#MODULE_DECL#
tc#SNIPPET_ACTIVE##MODULE_DECL_END#
