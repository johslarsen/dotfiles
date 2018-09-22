" folding for php slows down vim, so that it is pretty much useless for files
" larger than 1000 lines of code

" set nofoldenable " disabling it does not actually help, because it still parses the file to create the folds
set foldmethod=manual
