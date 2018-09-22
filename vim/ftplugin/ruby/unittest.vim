nnoremap <silent> <leader>ye    :MiniTestToggle<cr>
nnoremap <silent> <leader>yy    :RakeTest * '//'<cr>
nnoremap          <leader>yY    :RakeTest * '//'<Left><Left>
nnoremap <silent> <leader>yf    :RakeTest % '//'<cr>
nnoremap <silent> <leader>yF    :RakeTest % '//'<Left><Left>
nnoremap <silent> <leader>yt    :RakeTest % <C-r>=MiniTestName()<CR><CR>
nnoremap          <leader>yT    :RakeTest * '/<C-r>=MiniTestName()<CR>/'<Left><Left>

if !exists("*_MiniTestToggle")
  command MiniTestToggle call _MiniTestToggle()
  function _MiniTestToggle()
    let l:cursor = getcurpos()
    if match(getline('.'), '^[[:space:]]*def[[:space:]]', '')
      :keeppatterns ?^[[:space:]]*def[[:space:]]
    endif
    s/def\([[:space:]]\+\)\(disabled_\)\?test_/\='def'.submatch(1).ToggleEmptyOr('disabled_', submatch(2)).'test_'/
    call setpos('.', l:cursor)
  endfunction
endif
if !exists("*MiniTestName")
  function MiniTestName()
    let l:i = getcurpos()[1]
    while l:i > 0
      let l:match = matchlist(getline(l:i), '^[[:space:]]*def[[:space:]]\+\([^[:space:]]\+\)')
      if !empty(l:match)
        return l:match[1]
      endif
      let l:i -= 1
    endwhile
    return "//" " pattern matching all
  endfunction
endif
if !exists("*_RakeTest")
  command -nargs=+ RakeTest call _RakeTest(<f-args>)
  function _RakeTest(file_pattern, method_pattern)
    if filereadable('Rakefile')
      let l:rakefile = 'Rakefile'
    elseif filereadable('test/Rakefile')
      let l:rakefile = 'test/Rakefile'
    else
      exec 'MakeCheckGTest' a:method_pattern
      return
    endif

    let l:fp = a:file_pattern == '*' ? fnamemodify(l:rakefile, ':h').'/**/*_test.rb' : a:file_pattern

    let l:makeprg=&makeprg
    let &makeprg='rake'

    let l:errorformat=&errorformat

    let &errorformat   =  '%.%#: %f:%l: %tarning %m'
    let &errorformat  .= ',%[%^/]%#%f:%l: %tarning: %m'
    let &errorformat  .= ',%.%#: %f:%l: %m%trror)'
    let &errorformat  .= ',%[%^/]%#%f:%l: %m%trror)'
    let &errorformat  .= ',%A%[ ]%#%n) %tailure:'
    let &errorformat  .= ',%C%.%##%m [%f:%l]:'
    let &errorformat  .= ',%C%m but nothing was raised.'
    let &errorformat  .= ',%CExpected %m'
    let &errorformat  .= ',%C[%m'
    let &errorformat  .= ',%CClass: <%m>'
    let &errorformat  .= ',%CMessage: %m'

    let &errorformat  .= ',%A%[ ]%#%l) %trror:'
    let &errorformat  .= ',%C%f#%m:'
    " backtrace lines as new general info
    let &errorformat  .= ',%-Z---Backtrace---'
    let &errorformat  .= ',%-G------%.%#'
    let &errorformat  .= ',%[[:space:]]%#from %f:%l:%m'
    let &errorformat  .= ',%[[:space:]]%#%f:%l:%m'
    let &errorformat  .= ',%Z'

    let &errorformat  .= ',%-G'
    let &errorformat  .= ',%-G# Running:'
    let &errorformat  .= ',%-Grake aborted!'
    let &errorformat  .= ',%-GCommand failed with status (%.%#'
    let &errorformat  .= ',%-G/usr%.%#lib:test" -I%.%#'
    let &errorformat  .= ',%-GTasks: %.%#'
    let &errorformat  .= ',%-G(See full trace by running task with --trace)'

    let &errorformat  .= ',%C%m'
    let &errorformat  .= ',%C%p'

    exec 'Make' '-f'.l:rakefile 'test' 'TEST='.l:fp.'' "TESTOPTS=-n".a:method_pattern
    let &errorformat=l:errorformat
    let &makeprg=l:makeprg
  endfunction
endif
