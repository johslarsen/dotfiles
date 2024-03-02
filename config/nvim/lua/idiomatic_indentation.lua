vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "c", "cpp", -- https://google.github.io/styleguide/cppguide.html#Spaces_vs._Tabs
    "cmake", "json", "lua", "poke", "ruby", "verilog", "vim", "yaml", "xml",
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "php", "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "mail" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 8
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "csv" },
  callback = function()
    vim.opt_local.expandtab = false
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions + "q"
  end
})
