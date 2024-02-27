vim.g.mapleader = ","
vim.keymap.set('', '<C-,>', ',', { remap = true })       -- easier for <Leader><C-... hotkeys
vim.keymap.set({ 'n', 'v' }, ';', ',', { remap = true }) -- easier for <Leader>A... hotkeys

local fzf = require 'fzf-lua'
local delete_man_buffers = function()
  for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(bufid):find("^man://") then
      vim.api.nvim_buf_delete(bufid, {})
    end
  end
end

vim.g.nproc = tonumber(vim.fn.system('nproc'))

vim.keymap.set('n', '<Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader>d', "<cmd>Git blame<CR>")
vim.keymap.set('n', '<Leader>D', "<cmd>Gvdiffsplit<CR>")
vim.keymap.set('n', '<Leader><C-d>', "<cmd>Ghdiffsplit<CR>")
vim.keymap.set('n', '<Leader>e', "<cmd>Explore<CR>")
vim.keymap.set('n', '<Leader>E', "<cmd>Vexplore<CR>")
vim.keymap.set('n', '<Leader><C-e>', "<cmd>Sexplore<CR>")
vim.keymap.set('n', '<Leader>f', function() fzf.lines({ search = fzf.utils.rg_escape(vim.fn.expand("<cword>")) }) end)
vim.keymap.set('v', '<Leader>f', function() fzf.lines({ search = fzf.utils.get_visual_selection() }) end)
vim.keymap.set('v', '<Leader><C-f>', '<cmd>set invcursorline invcursorcolumn<CR>')
vim.keymap.set('n', '<Leader>g', function() fzf.grep_cword({ cmd = "git grep", filespec = vim.fn.expand("%:h") }) end)
vim.keymap.set('v', '<Leader>g', function() fzf.grep_visual({ cmd = "git grep", filespec = vim.fn.expand("%:h") }) end)
vim.keymap.set('n', '<Leader>G', function() fzf.grep_cword({ cmd = "git grep" }) end)
vim.keymap.set('v', '<Leader>G', function() fzf.grep_visual({ cmd = "git grep" }) end)
vim.keymap.set('n', '<Leader><C-g>', fzf.grep_cword)
vim.keymap.set('v', '<Leader><C-g>', fzf.grep_visual)
vim.keymap.set('n', '<Leader>if', "mfgggqG`f") -- fallback, ISP overrides this if it is capable
vim.keymap.set('x', '<Leader>if', "gqgv")      -- fallback, ISP overrides this if it is capable
vim.keymap.set('n', '<Leader>io', "<cmd>Outline<CR>")
vim.keymap.set('n', '<Leader>iQ', vim.diagnostic.setloclist)
vim.keymap.set('n', '<Leader>K', delete_man_buffers)
vim.keymap.set('n', '<Leader>L', function()
  vim.opt.listchars = vim.o.listchars == 'trail:#' and 'eol:$,tab:>-,nbsp:%,precedes:<,extends:>,trail:#' or 'trail:#'
end)
vim.keymap.set('n', '<Leader><C-l>', function() vim.opt.spelllang = vim.o.spelllang == "en_us" and "nb" or "en_us" end)
vim.keymap.set('n', '<Leader>m', function() vim.cmd("Make -j" .. vim.g.nproc) end)
vim.keymap.set('n', '<Leader>M', ":Make -j<C-r>=g:nproc<CR><Space>")
vim.keymap.set('n', '<Leader>n', "<cmd>nohlsearch<CR>")
vim.keymap.set('n', '<Leader>N', function()
  return ('<cmd>set invnumber invrelativenumber signcolumn=' .. vim.o.signcolumn == 'auto' and 'no' or 'auto' .. '<CR>')
end, { expr = true })
vim.keymap.set('n', '<Leader>o', fzf.git_files)
vim.keymap.set('n', '<Leader>O', fzf.files)
vim.keymap.set('n', '<Leader>p', fzf.help_tags)
vim.keymap.set('n', '<Leader>P', "<cmd>helpclose<CR>")
vim.keymap.set('n', '<Leader><C-p>', ":lhelpgrep ")
vim.keymap.set('v', '<Leader><C-p>', function() vim.cmd("lhelpgrep " .. fzf.utils.get_visual_selection()) end)
vim.keymap.set('n', '<Leader>q', "<cmd>copen<CR>")
vim.keymap.set('n', '<Leader>Q', "<cmd>cclose<CR><cmd>clist<CR>")
vim.keymap.set('n', '<Leader><C-q>', "<cmd>cclose<CR>")
vim.keymap.set('n', '<Leader>r', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>')
vim.keymap.set('v', '<Leader>r', '"vy:%s/<C-r>v//g<Left><Left>')
vim.keymap.set('n', '<Leader>R', ':%s/\\<<C-r><C-a>\\>//g<Left><Left>')
vim.keymap.set('n', '<Leader>s', ':split ')
vim.keymap.set('n', '<Leader>S', ':vs ')
vim.keymap.set('n', '<Leader><C-s>', ':%s//gc<Left><Left><Left>')
vim.keymap.set('n', '<Leader><C-r>', ':Dispatch rifle <C-r><C-p><CR>')
vim.keymap.set('n', '<Leader>U', "<cmd>GundoToggle<CR>")
vim.keymap.set('n', '<Leader>v', fzf.git_commits)
vim.keymap.set('n', '<Leader>V', fzf.git_bcommits)
vim.keymap.set('n', '<Leader>w', "<cmd>lopen 4<CR>")
vim.keymap.set('n', '<Leader>W', "<cmd>lclose<CR><cmd>llist<CR>")
vim.keymap.set('n', '<Leader><C-w>', "<cmd>lclose<CR>")
vim.keymap.set('n', '<Leader>7', function() vim.opt.colorcolumn = vim.o.colorcolumn == "73" and "-1" or "73" end)
vim.keymap.set('n', '<Leader>8', function() vim.opt.colorcolumn = vim.o.colorcolumn == "81" and "-1" or "81" end)
vim.keymap.set('n', '<Leader>%', '%<C-space>', { remap = true })

-- US mappings that would require AltGr on a Norwegian keyboard layout
vim.keymap.set('n', '§', '~')
vim.keymap.set('n', '¤', '$')
vim.keymap.set('n', 'T', '<C-]>')
vim.keymap.set('n', '<C-w><C-t>', '<C-w>}')
vim.keymap.set('n', 'ø', '[', { remap = true })
vim.keymap.set('n', 'øø', '[[', { remap = true })
vim.keymap.set('n', 'øæ', '[]', { remap = true })
vim.keymap.set('n', 'æø', '][', { remap = true })
vim.keymap.set('n', 'æ', ']', { remap = true })
vim.keymap.set('n', 'Ø', '{', { remap = true })
vim.keymap.set('n', 'Æ', '}', { remap = true })
vim.keymap.set('n', 'ØØ', '{{', { remap = true })
vim.keymap.set('n', 'ÆÆ', '}}', { remap = true })
vim.keymap.set('n', 'ææ', ']]', { remap = true })

vim.keymap.set('n', '<CR>', '<C-]>', { remap = true }) -- enter as goto
vim.keymap.set('n', '<Space>', '<C-f>')                -- space as page down, like less

local function preview_window()
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_get_option_value('previewwindow', { win = winid }) then
      return winid
    end
  end
  return nil
end
local function pedit_qf_entry(getqflist, idx)
  local items = getqflist({ idx = idx, items = 1 }).items[1]
  local preview = preview_window()
  if preview ~= nil and vim.api.nvim_win_get_buf(preview) == items.bufnr then -- do not reload it unnecessarily
    vim.api.nvim_win_set_cursor(preview, { items.lnum, items.col })
  else
    vim.cmd("pedit +:call\\ cursor(" .. items.lnum .. "," .. items.col .. ") " .. vim.api.nvim_buf_get_name(items.bufnr))
  end
end
local function pedit_focused_qf_entry()
  local loclist = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].loclist == 1
  pedit_qf_entry(loclist and vim.fn.getloclist or vim.fn.getqflist, vim.fn.line('.'))
end
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', '<CR>', '<CR>') -- use as regular in quickfix
    vim.keymap.set('n', '<Space>', pedit_focused_qf_entry)
  end,
})
local function preview_diagnostic(getqflist, step, reset)
  local preview = preview_window()
  if preview == nil then
    pedit_qf_entry(getqflist, getqflist({ idx = 0 }).idx)
    preview = preview_window()
    if preview == nil then return end -- just to satisfy lsp-linter
  end
  if not select(1, pcall(vim.api.nvim_win_call, preview, step)) then
    vim.api.nvim_win_call(preview, reset)
  end
  pedit_qf_entry(getqflist, getqflist({ idx = 0 }).idx)
end
vim.keymap.set('n', '{Q', function() preview_diagnostic(vim.fn.getqflist, vim.cmd.cprev, vim.cmd.clast) end)
vim.keymap.set('n', '}Q', function() preview_diagnostic(vim.fn.getqflist, vim.cmd.cnext, vim.cmd.cfirst) end)
vim.keymap.set('n', '{L', function() preview_diagnostic(vim.fn.getloclist, vim.cmd.lprev, vim.cmd.llast) end)
vim.keymap.set('n', '}L', function() preview_diagnostic(vim.fn.getloclist, vim.cmd.lnext, vim.cmd.lfirst) end)

vim.keymap.set('n', 'Y', 'y$') -- to be consistent with D/C

--vim.api.nvim_create_autocmd({ "VimEnter" }, {
--  callback = function() vim.keymap.set('n', '%', '<Plug>(MatchitOperationForward)') end,
--})

vim.keymap.set('n', '<C-e>', '<cmd>:buffer #<CR>')
vim.keymap.set('n', '<C-Up>', 'gk')
vim.keymap.set('n', '<C-Down>', 'gj')

vim.keymap.set({ 'n', 'i' }, '<A-Space>', vim.diagnostic.open_float)
vim.keymap.set('n', '[i', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']i', vim.diagnostic.goto_next)

vim.keymap.set('n', '[g', '<Plug>(GitGutterPrevHunk)')
vim.keymap.set('n', ']g', '<Plug>(GitGutterNextHunk)')
vim.keymap.set('o', 'ih', '<Plug>(GitGutterTextObjectInnerPending)')
vim.keymap.set('o', 'ah', '<Plug>(GitGutterTextObjectOuterPending)')
vim.keymap.set('x', 'ih', '<Plug>(GitGutterTextObjectInnerVisual)')
vim.keymap.set('x', 'ah', '<Plug>(GitGutterTextObjectOuterVisual)')

vim.keymap.set('i', '<C-k>', '<C-x><C-n>') -- because nvim-cmp reuse <C-n> for "omnicomplete"
vim.keymap.set('i', '<C-l>', '<C-y>')      -- accepted selected completion item

-- BASH-like command line movement
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-d>', '<Delete>')
vim.keymap.set('c', '<M-b>', '<S-Left>')
vim.keymap.set('c', '<M-f>', '<S-Right>')
