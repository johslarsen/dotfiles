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
vim.opt.list = true
vim.opt.listchars = "trail:#"

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
