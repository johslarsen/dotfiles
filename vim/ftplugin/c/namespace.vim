if !exists("*NamespaceString")
  function NamespaceString(dirname)
    if (expand("%:p:h") == getcwd())
      return ""
    endif
    return substitute(substitute(a:dirname, "+", "", "g"), '\/', '::', 'g')
  endfunction
endif
if !exists("*NamespaceDeclaration")
  function NamespaceDeclaration()
    if (expand("%:p:h") == getcwd())
      return ""
    endif
    let l:declaration = ""
    let l:i = 0
    for ns in split(NamespaceString(RPath("%:h")), "::")
      let l:declaration .= IndentationString(l:i)."namespace ".ns." {\n"
      let l:i += 1
    endfor
    let l:declaration .= IndentationString(l:i)."class ".RPath('%:t:r').";\n"
    for ns in split(NamespaceString(RPath("%:h")), "::")
      let l:i -= 1
      let l:declaration .= IndentationString(l:i)."}\n"
    endfor
    return l:declaration
  endfunction
endif
if !exists("*NamespaceUsing")
  function NamespaceUsing(dirname)
    if (NamespaceString(a:dirname) == "")
      return ""
    endif
    return "using namespace ".NamespaceString(a:dirname).";\n\n"
  endfunction
endif
if !exists("*NamespaceAndClass")
  function NamespaceAndClass()
    if (NamespaceString(RPath("%:h")) == "")
      return RPath('%:t:r')
    else
      return NamespaceString(RPath("%:h"))."::".RPath('%:t:r')
    endif
  endfunction
endif
function! NamespaceInject(prefix, namespace)
  0
  norm zR
  let l:namespaceDeclHier = '^namespace\s\+'.join(split(a:prefix, '::'), '[[:space:]\n]*{[[:space:]\n]*namespace\s\+').'[[:space:]\n]*{'
  while(search(l:namespaceDeclHier, 'We') > 0)
    call search('namespace', 'b')
    let l:lastNs = substitute(a:prefix, '.*::', '', '')
    exec 'silent! s/^\(\s*namespace\s\+\)'.l:lastNs.'\([[:space:]\n]*{\)/\0\r\1'.a:namespace.'\2/g'
    norm ]}
    exec 'silent! s/\(\s*\)}/\0\r\1}/'
    norm >i{
  endwhile
  for separator in ['::', '\.', '\/'] " namespaces, logger identifiers, paths
    exec 'silent! %s/'.substitute(a:prefix, '::', escape(separator, '\\'), 'g').separator.'/\0'.a:namespace.separator.'/g'
  endfor
  exec 'silent! %s/'.toupper(substitute(a:prefix, '::', '_', 'g')).'_/\0'.toupper(a:namespace).'_/g'
endfunction
