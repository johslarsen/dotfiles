local function pedit_definition()
  vim.lsp.buf_request(0, 'textDocument/definition', vim.lsp.util.make_position_params(), function(_, result, _, _)
    if result == nil or vim.tbl_isempty(result) then
      return
    end
    local definition = (vim.tbl_islist(result) and result[1] or result)
    local pos = definition.range.start
    vim.cmd("pedit +:call\\ cursor(" .. pos.line + 1 .. "," .. pos.character + 1 .. ") " .. definition.uri)
  end)
end

local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<Leader>id", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<Leader>iD", pedit_definition, bufopts)
  vim.keymap.set("n", "<Leader>i<C-d>", vim.lsp.buf.declaration, bufopts)
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<Leader>if", function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set("x", "<Leader>if", function()
      vim.lsp.buf.format({
        async = true,
        range = { ["start"] = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">") }
      })
    end, bufopts)
  end
  vim.keymap.set("n", "<Leader>ih", function()
    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
  end, bufopts)
  vim.keymap.set("n", "<Leader>ii", "<cmd>LspInfo<CR>", bufopts)
  vim.keymap.set("n", "<Leader>ik", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<Leader>il", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<Leader>iL", function() vim.lsp.buf.references({ includeDeclaration = false }) end, bufopts)
  vim.keymap.set('n', '<Leader>iq', function() vim.lsp.buf.code_action { apply = true } end, bufopts)
  vim.keymap.set("n", "<Leader>ir", vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ "n", "i" }, "<C-Space>", vim.lsp.buf.hover, bufopts)
  vim.keymap.set({ "n", "i" }, "<C-S-Space>", vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<Leader>h', vim.cmd.ClangdSwitchSourceHeader, bufopts)
  vim.keymap.set('n', '<Leader>H', function()
    vim.cmd.vsplit()
    vim.cmd.ClangdSwitchSourceHeader()
  end, bufopts)
  vim.keymap.set('n', '<Leader><C-h>', function()
    vim.cmd.split()
    vim.cmd.ClangdSwitchSourceHeader()
  end, bufopts)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

local capabilites = require("cmp_nvim_lsp").default_capabilities()
local function with_defaults(table)
  table["on_attach"] = on_attach
  table["capabilities"] = capabilites
  return table
end

local lspconfig = require('lspconfig')
lspconfig.bashls.setup(with_defaults {})
lspconfig.clangd.setup(with_defaults {
  cmd = { "clangd", "--completion-style=detailed" }
})
lspconfig.cmake.setup(with_defaults {})
lspconfig.dockerls.setup(with_defaults {})
lspconfig.gopls.setup(with_defaults {})
lspconfig.html.setup(with_defaults {})
lspconfig.jsonls.setup(with_defaults {
  init_options = {
    provideFormatter = true
  }
})
lspconfig.lua_ls.setup(with_defaults {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = { vim.env.VIMRUNTIME } },
      telemetry = { enable = false }
    }
  }
})
--lspconfig.neocmake.setup(with_defaults {})
lspconfig.openscad_lsp.setup(with_defaults {})
lspconfig.pylsp.setup(with_defaults {})
lspconfig.rust_analyzer.setup(with_defaults {})
lspconfig.salt_ls.setup(with_defaults {})
lspconfig.solargraph.setup(with_defaults {})
lspconfig.yamlls.setup(with_defaults {})
lspconfig.vimls.setup(with_defaults {})
