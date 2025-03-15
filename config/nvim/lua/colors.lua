vim.opt.termguicolors = false
vim.cmd [[silent! colorscheme badwolf]]
vim.cmd [[
  highlight Normal ctermfg=darkgreen guifg=#00cd00 guibg=#121212
  highlight Special ctermfg=lightgreen guifg=#87ffaf

  highlight DiffText ctermfg=NONE guifg=NONE cterm=bold,underline gui=bold,undercurl guisp=blue
  highlight DiffAdd ctermfg=NONE guifg=NONE
  highlight DiffChange ctermfg=NONE guifg=NONE

  highlight SpellBad term=reverse cterm=bold,underline gui=bold,undercurl ctermbg=NONE guisp=NONE
  highlight SpellLocal term=reverse cterm=underline ctermfg=brown guifg=#ffaf00 ctermbg=NONE guisp=NONE
  highlight SpellRare term=reverse cterm=underline ctermfg=yellow guifg=yellow ctermbg=NONE guisp=NONE

  highlight NonText    cterm=bold ctermfg=magenta guifg=magenta
  highlight SpecialKey cterm=NONE ctermfg=black guifg=black ctermbg=brown guibg=#ffaf00

  highlight Pmenu cterm=NONE
  highlight CmpItemAbbr ctermfg=28 guifg=#008d00
  highlight CmpItemAbbrDeprecated ctermfg=240 guifg=#666666
  highlight CmpItemAbbrMatch ctermfg=darkcyan guifg=darkcyan
  highlight CmpItemKind ctermfg=magenta guifg=magenta

  highlight Function ctermfg=210 guifg=#ff8787
  highlight @lsp.type.method ctermfg=216 guifg=#ffaf87
  highlight Structure ctermfg=205 guifg=#df5eaf
  highlight @module ctermfg=133 guifg=#ae5a88
  highlight @lsp.type.class ctermfg=lightgreen guifg=#87ffaf
  highlight @lsp.type.typeParameter ctermfg=205 guifg=#ffbbb8
  highlight @property ctermfg=202 guifg=#ff5f00
  highlight! link @variable Identifier
  highlight @variable.parameter ctermfg=208 guifg=#ff7500
  highlight LspInlayHint ctermfg=237 guifg=#3a3a3a

  highlight StatusLine term=bold cterm=bold gui=bold ctermfg=yellow guifg=yellow ctermbg=88 guibg=darkred
  highlight ColorColumn ctermbg=magenta guibg=magenta
  highlight CursorColumn guibg=#333333
  highlight CursorLine guibg=#333333

  highlight Indent1 ctermfg=235
  highlight Indent2 ctermfg=236
  highlight Indent3 ctermfg=237
  highlight IblScope ctermfg=240
]]

vim.opt.colorcolumn = "+1"
