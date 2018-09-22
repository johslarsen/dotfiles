function! getopts#includeCurrentHeaders#getopts()
  let b:clang_user_options = '-include '.shellescape(fnamemodify(expand('%:r').'.hpp', ':p'))
endfunction
