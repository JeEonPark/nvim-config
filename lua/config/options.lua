-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable transparency
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.diagnostic.enable(false)

vim.env.CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude")

vim.g.autoformat = false
