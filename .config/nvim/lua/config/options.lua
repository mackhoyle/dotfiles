-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
  end,
})
