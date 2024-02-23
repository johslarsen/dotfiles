local luasnip = require 'luasnip'
local cmp = require 'cmp'
local confirm = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Replace,
  select = true,
}
cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
    ['<C-l>'] = cmp.mapping(confirm, { 'i', 's' }),
    ['<CR>'] = cmp.mapping(confirm, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        confirm()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip', option = { show_autosnippets = true } },
  },
}
