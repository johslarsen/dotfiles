vim.diagnostic.config {
  severity_sort = true,
  float = { source = "if_many" },
}

local virtual_text = false --- @type boolean|vim.diagnostic.Opts.VirtualText
local function toggle_virtual_text()
  if virtual_text == false then
    virtual_text = {}
  else
    virtual_text = false
  end
  vim.diagnostic.config({ virtual_text = virtual_text })
end
toggle_virtual_text() -- enable it by default

vim.keymap.set('n', '<Leader>i<C-w>', toggle_virtual_text)
