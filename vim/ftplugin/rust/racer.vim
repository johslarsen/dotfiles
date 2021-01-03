nmap <buffer> <leader>m  :Make<Cr>
nmap <buffer> <leader>M  :Make
nmap <buffer> <CR>       <Plug>(rust-def)
nmap <buffer> <C-w>}     :call racer#GoToDefinition(1)<CR>
nmap <buffer> <leader>ck <Plug>(rust-doc)
nmap <buffer> <leader>cK <Plug>(rust-doc-tab)
