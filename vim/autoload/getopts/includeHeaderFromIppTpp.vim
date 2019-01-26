function! getopts#includeHeaderFromIppTpp#getopts()
  if index(['ipp', 'tpp'], expand('%:e')) < 0
    return
  endif

  for suffix in ['h', 'hpp']
    let l:header = fnamemodify(expand('%:r').'.'.suffix, ':p')
    if (filereadable(l:header))
      let b:clang_user_options .= ' -include '.shellescape(l:header)
    endif
  endfor
endfunction
