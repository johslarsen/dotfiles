vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.env.BUILD_IMAGE then
      vim.opt.makeprg = "dmake " .. vim.env.BUILD_IMAGE
    elseif vim.fn.filereadable('build') then
      vim.opt.makeprg = "bash -c 'cmake --build build -- \"$@\"' -- "
    end
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.api.nvim_create_user_command('Pandoc', function(opts)
      local src = vim.env.DOCROOT or vim.api.nvim_buf_get_name(0)
      local type = opts.fargs[1]
      local dest = opts.fargs[2] ~= nil and opts.fargs[2] or src:gsub('[.][^.]*$', '.' .. type)
      if dest == '+' then dest = '>(xclip -selection clipboard)' end

      vim.cmd.Dispatch('pandoc -t ' .. type .. ' -o ' .. dest .. ' ' .. src)
    end, { nargs = '+' })
    vim.keymap.set('n', '<Leader>m', '<cmd>Pandoc html<CR>', { buffer = 0 })
    vim.keymap.set('n', '<Leader>M', ':Pandoc ', { buffer = 0 })
    vim.keymap.set('n', '<Leader><C-m>', '<cmd>Pandoc jira +<CR>', { buffer = 0 })
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "asciidoc" },
  callback = function()
    vim.keymap.set('n', '<Leader>m', function()
      vim.cmd.Dispatch("asciidoctor", vim.env.DOCROOT or vim.api.nvim_buf_get_name(0))
    end, { buffer = 0 })
  end
})
