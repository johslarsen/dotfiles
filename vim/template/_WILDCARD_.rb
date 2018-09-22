:silent %s/#CLASS#/\=ToCamel(RPath('%:t:r'))/g
:silent %s/#MODULE_DECL#/\=ModuleDeclaration()/g
:silent %s/#MODULE_DECL_END#/\=ModuleDeclarationEnd()/g
:silent %s/#I#/\=IndentationString(1)/g
:silent %s/#MI#/\=empty(ModuleString(RPath('%:h')))?'':IndentationString(1)/g
#!/usr/bin/env ruby
#MODULE_DECL#
#MI#class #CLASS#
#MI##I#def initialize
#MI##I##I##CURSOR#
#MI##I#end
#MI#end#MODULE_DECL_END#
