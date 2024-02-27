-- bootstrap missing packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- recompile on updated plugins config
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'

  use 'neovim/nvim-lspconfig' -- preconfigured LSP integrations
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  --  use 'ray-x/lsp_signature.nvim'
  use 'hedyhli/outline.nvim'
  use 'tpope/vim-dispatch' -- :Make

  use 'sjl/badwolf'
  use 'altercation/vim-colors-solarized'
  use 'guns/xterm-color-table.vim'

  use 'chrisbra/csv.vim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'     -- :SudoWrite
  use 'tpope/vim-unimpaired' -- e.g. [q
  use 'ibhagwan/fzf-lua'

  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  use 'sjl/gundo.vim' -- undo history

  if packer_bootstrap then
    require('packer').sync()
  end
end)
