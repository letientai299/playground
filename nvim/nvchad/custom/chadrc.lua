-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "tokyonight",
}

M.plugins = {
  ["williamboman/mason.nvim"] = {
    ensure_installed = {
      -- lua stuff
      "lua-language-server",
      "stylua",
      -- web dev
      "json-lsp",
      -- shell
      "shfmt",
      "shellcheck",
      -- go
      ["gopls"] = {}
    },
  },
}

return M
