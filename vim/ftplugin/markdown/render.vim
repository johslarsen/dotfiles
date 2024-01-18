function Pandoc(type, output = v:null)
  let l:src = EnvOr('DOCROOT', expand('%'))
  let l:dest = a:output == '+' ? '>(xclip -selection clipboard)' : !empty(a:output) ? a:output : substitute(l:src, '\.[^.]*$', '.'.a:type, '')
  execute 'Dispatch pandoc -t '.a:type.' -o '.l:dest.' '.l:src
endfunction
nnoremap <silent> <leader>m     :execute Pandoc('html')<CR>
nnoremap          <leader>M     :execute Pandoc('')<Left><Left>
nnoremap          <leader><C-m> :execute Pandoc('jira', '+')<Left><Left><Left><Left><Left><Left><Left>
