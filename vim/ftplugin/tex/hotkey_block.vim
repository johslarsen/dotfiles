if !exists("*g:SubEndTex")
    function g:SubEndTex()
        silent! s/^\([[:space:]]*\)\(.*\)\\begin\(\[.*\]\)\?{\([^}]*\)}\(.*\)$/\1\2\\begin\3{\4}\5\r\r\1\\end{\4}/
    endfunction
endif
imap <silent> <buffer> <NL> <Esc>:silent! call g:SubEndTex()<CR>-cc
