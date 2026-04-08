-- lua/options.lua

vim.g.have_nerd_font = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "" -- disables mouse
vim.opt.encoding = "utf-8"
vim.opt.nrformats:append("alpha")
vim.opt.list = true
vim.opt.listchars = { tab = "» ", extends = "›", precedes = "‹", nbsp = "·", trail = "·" }
vim.opt.updatetime = 100
vim.opt.clipboard = "unnamed"
vim.opt.background = "dark"
vim.opt.background = "dark"
vim.g.mapleader = ","
-- 4GL omnifunc is set via autocmd in autocmds.lua (only for fgl filetype)
vim.opt.ttyfast = true

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
