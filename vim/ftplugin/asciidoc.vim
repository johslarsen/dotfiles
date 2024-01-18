let &makeprg = 'asciidoctor '.EnvOr('DOCROOT', expand('%'))
nnoremap <silent> <leader>m :Make<cr>
nnoremap <leader>M :Make<space>
