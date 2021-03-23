nnoremap <silent> <leader>ct :Dispatch -compiler=gcc cltidy %<cr>
noremap           <leader>cr :py3f /usr/share/clang/clang-rename.py<cr>

let g:clang_rename_path = expand('~/.bin/clrename')
let b:syntastic_mode = 'passive'
