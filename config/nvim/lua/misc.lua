vim.opt.swapfile = false
vim.opt.backupdir = "~/tmp,/tmp"

vim.opt.history = 1000
vim.opt.undolevels = 1000

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.tabstop = 4

vim.opt.spell = true
vim.opt.spellcapcheck = ""
vim.opt.spelllang = "en_us"

vim.opt.nrformats = "hex,alpha"
vim.opt.joinspaces = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false

local trail = "trail:#,tab:  " -- needs spaces for tab to avoid it written as ^I
vim.opt.list = true
vim.opt.listchars = trail
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function() vim.wo.listchars = vim.o.listchars:gsub('trail:#', 'trail: ') end
})
vim.api.nvim_create_autocmd({ "InsertLeavePre" }, {
  callback = function() vim.wo.listchars = nil end
})
vim.keymap.set('n', '<Leader>L', function()
  vim.opt.listchars = vim.o.listchars == trail and 'eol:$,tab:>-,nbsp:%,precedes:<,extends:>,trail:#' or trail
end)

vim.opt.completeopt = "menu,noinsert,popup"

vim.api.nvim_create_autocmd({ "FileType" }, { -- use K for man-pages regardless of language defaults
  callback = function() vim.bo.keywordprg = ":Man" end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})
