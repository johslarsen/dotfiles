nnoremap <buffer> <leader>yy :MakeRustTest ''<CR>
nnoremap <buffer> <leader>yY :MakeRustTest ''<Left>
nnoremap <buffer> <leader>yt :MakeRustTest '<C-r>=RustTestName()<CR>'<CR>
nnoremap <buffer> <leader>yT :MakeRustTest '<C-r>=RustTestName()<CR>'<Left>

if !exists("*RustTestName")
  function RustTestName()
    let l:i = getcurpos()[1]
    while l:i > 0
      let l:match = matchlist(getline(l:i), '^[[:space:]]*fn[[:space:]]\+\([^([:space:]]\+\)')
      if !empty(l:match)
        return l:match[1]
      endif
      let l:i -= 1
    endwhile
    return '' " pattern matching all
  endfunction
endif
if !exists("*_MakeRustTest")
  command -nargs=+ MakeRustTest call _MakeRustTest(<f-args>)
  function _MakeRustTest(method_pattern)
    if filereadable('Cargo.toml')
      exec 'Make' 'test' a:method_pattern
      return
    endif

    let l:makeprg=&makeprg
    let l:testsuite = tempname()
    let l:rustc = exists('g:rustc_path') ? g:rustc_path : 'sccache rustc'
    let &makeprg = l:rustc.' --test -o '.l:testsuite.' %:S && '.l:testsuite

    exec 'Make' a:method_pattern

    let &makeprg=l:makeprg
  endfunction
endif
