-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_python_lsp = "jedi"

-- Prefer a git repo root; otherwise fall back to current working directory.
vim.g.root_spec = { ".git", "cwd" }

-- b/c I'm managing extras in my plugins.
vim.g.lazyvim_check_order = false
