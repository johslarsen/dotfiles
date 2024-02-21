vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.env.BUILD_IMAGE then
      vim.opt.makeprg = "dmake " .. vim.env.BUILD_IMAGE
    elseif vim.fn.filereadable('build') then
      vim.opt.makeprg = "cmake --build build --"
    end
  end
})
