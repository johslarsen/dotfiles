require 'fzf-lua'.setup {
  'fzf-tmux',
  fzf_tmux_opts = { ["-d"] = "30%" },
  fzf_opts = {
    ["--border"] = "none",
    ["--color"] = "dark",
    ["--layout"] = "default",
  },
  winopts = {
    -- split = "belowright new" , -- currently not compatible with fzf-tmux
    preview = {
      horizontal = "right:50%",
      layout = "flex",
      flip_columns = 160,
    },
  },
  keymap = {
    fzf = {
      ["alt-a"]      = "toggle-all",
      ["alt-w"]      = "toggle-preview-wrap",
      ["alt-z"]      = "toggle-preview",
      ["ctrl-f"]     = "half-page-down",
      ["ctrl-b"]     = "half-page-up",
      ["shift-down"] = "preview-page-down",
      ["shift-up"]   = "preview-page-up",
    }
  },
  previewers = {
    man_native = { cmd = "man %s | bat -l man -p --color=always" },
  },
  helptags = {
    fzf_opts = { ["--tiebreak"] = "begin,length,index" }
  }
}
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown" },
  auto_install = true,
}
require 'outline'.setup {
  symbol_folding = { markers = { '+', '-' } },
  symbols = {
    icons = {
      Class = { icon = 'C' },
      Enum = { icon = 'E' },
      File = { icon = 'F' },
      Interface = { icon = 'I' },
      Module = { icon = 'M' },
      Namespace = { icon = 'N' },
      Package = { icon = 'P' },
      Struct = { icon = 'S' },

      Method = { icon = 'f' },
      Function = { icon = 'f' },
      Constructor = { icon = 'fc' },
      StaticMethod = { icon = 'fs' },
      Operator = { icon = 'fo' },
      Macro = { icon = 'fm' },

      Property = { icon = 'p' },
      Field = { icon = 'p' },
      Variable = { icon = 'v' },
      Constant = { icon = 'c' },
      TypeParameter = { icon = 't' },
      TypeAlias = { icon = 't' },
      Parameter = { icon = 'a' },
      EnumMember = { icon = 'e' },

      String = { icon = '"' },
      Number = { icon = '#' },
      Boolean = { icon = 'b' },
      Array = { icon = '[' },
      Object = { icon = '{' },
      Null = { icon = '0' },
    },
  },
}

vim.g.dispatch_no_maps = true
vim.g.dispatch_no_tmux_make = true

vim.g.gitgutter_diff_args = '-w'
vim.g.gitgutter_escape_grep = 1
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_priority = 5
vim.g.gitgutter_use_location_list = true

vim.g.gundo_prefer_python3 = true
