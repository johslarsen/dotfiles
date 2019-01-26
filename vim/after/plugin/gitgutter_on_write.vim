augroup gitgutter_user
  autocmd! gitgutter CursorHold,CursorHoldI
  autocmd BufWritePost * GitGutter
augroup END
