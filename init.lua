-- Set leader key vim.g.mapleader = " "

-- Install Lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load Lazy.nvim plugins
require("lazy").setup({
  -- Syntax highlighting & Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP and autocompletion
  { "neovim/nvim-lspconfig" },         -- Language Server Protocol
  { "hrsh7th/nvim-cmp" },              -- Completion framework
  { "hrsh7th/cmp-nvim-lsp" },          -- LSP completion source
  { "L3MON4D3/LuaSnip" },              -- Snippets

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- Fuzzy finder (like FZF)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Color scheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },


  -- status line
  { "nvim-lualine/lualine.nvim" },

  -- git integration
  { "tpope/vim-fugitive" },
})

-- Enable Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "go", "haskell", "elixir" },
  highlight = { enable = true },
})

-- LSP Configuration
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})   -- Python
lspconfig.gopls.setup({})     -- Go
lspconfig.hls.setup({})       -- Haskell
lspconfig.elixirls.setup({})  -- Elixir

-- Keybindings
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>") -- Fuzzy finder
vim.keymap.set("i", "jj", "<Esc>")  -- jj to escape in insert mode

-- Indentation settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true

-- Auto-remove trailing spaces before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})
vim.o.background = "dark"
vim.cmd("colorscheme catppuccin-macchiato")

