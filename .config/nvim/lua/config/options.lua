-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Python: use basedpyright (installed via Mason) instead of LazyVim's
-- default pyright, and ruff for linting/formatting. Must be set before the
-- lang.python extra loads (options.lua loads pre-lazy).
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
