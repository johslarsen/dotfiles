if !exists("*ModuleString")
  function ModuleString(dirname)
    if (expand("%:p:h") == getcwd())
      return ""
    endif
    let l:without_prefix = substitute(a:dirname, '^\(\(\(src\)\|\(test\)\|\(lib\)\)\/\)*', '', '')
    return SlashToColons(ToCamel(l:without_prefix))
  endfunction
endif
if !exists("*ModuleAndClass")
  function ModuleAndClass()
    if (expand("%:p:h") == getcwd())
      return RPath('%:t:r')
    else
      return ModuleString(RPath('%:h')).'::'.ToCamel(RPath('%:t:r'))
    endif
  endfunction
endif
if !exists("*ModuleDeclaration")
  function ModuleDeclaration()
    if (expand("%:p:h") == getcwd())
      return ""
    endif
    let l:declaration = "\n"
    for ns in split(ModuleString(RPath("%:h")), '::')
      let l:declaration .= 'module '.ns."\n"
    endfor
    return l:declaration
  endfunction
endif
if !exists("*ModuleDeclarationEnd")
  function ModuleDeclarationEnd()
    if (expand("%:p:h") == getcwd())
      return ""
    endif
    let l:declaration = "\n"
    let l:namespace = ModuleString(RPath('%:h'))
    for ns in split(ModuleString(RPath("%:h")), '::')
      let l:declaration .= "\nend # ".l:namespace
      let l:namespace = substitute(l:namespace, '::[^:]*$', '', '')
    endfor
    return l:declaration
  endfunction
endif
