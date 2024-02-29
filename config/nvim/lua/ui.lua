vim.opt.statusline = "%<" -- truncate from left
    .. "%{fugitive#statusline()}"
    .. "%y[%{&fo}][%{strlen(&fenc)?&fenc:&enc},%{&ff}][%{&spl}]"
    .. " %f "
    .. "%#ModeMsg#%h%m%*"
    .. "%#WarningMsg#%{&paste?'[PASTE]':''}%q%w%r%a%*"
    .. "%=0x%B (%4l/%-4L,%2c%-2V) %P" -- on right side

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.title = true
vim.opt.showmode = false -- keep info when cmdline is not in use

vim.opt.updatetime = 300 -- speed up CursorHold feedback

vim.api.nvim_create_autocmd({ "BufReadPost" }, { -- jump to previous position
  callback = function()
    local previous = vim.api.nvim_buf_get_mark(0, '"')
    pcall(vim.api.nvim_win_set_cursor, 0, previous)
  end
})

vim.opt.previewheight = 5
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    if vim.o.previewwindow then
      vim.opt.cursorline = true
      vim.opt.cursorcolumn = true
    end
  end,
})
