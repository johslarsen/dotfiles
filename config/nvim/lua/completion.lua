local luasnip = require 'luasnip'
local cmp = require 'cmp'
local confirm = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Replace,
}
local select_and_confirm = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Replace,
  select = true,
}
cmp.setup {
  window = { documentation = { max_width = 100, } },
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
    ['<C-l>'] = cmp.mapping(select_and_confirm, { 'i', 's' }),
    ['<C-x><C-x>'] = cmp.mapping.complete({ config = { sources = {
      { name = 'luasnip', option = { show_autosnippets = true } },
      { name = 'nvim_lsp', entry_filter = function(entry)
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] == 'Snippet'
      end },
    } } }, { 'i', 's' }),
    ['<CR>'] = cmp.mapping(confirm, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        select_and_confirm()
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
    ['<C-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip', option = { show_autosnippets = true } },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'path' },
  },
}
