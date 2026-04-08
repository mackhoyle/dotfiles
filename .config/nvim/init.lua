-- init.lua

require("options")
require("autocmds")
require("plugins")
require("statusline")
require("keymaps")

-- Plugin config
require("plugin-config.dbui")
require("plugin-config.gitgutter")

-- Add FGLDIR vimfiles to Neovim runtimepath
local fgldir = os.getenv("FGLDIR")
if fgldir and #fgldir > 0 then
    local fglvim = fgldir .. "/vimfiles"
    local uv = vim.loop
    local stat = uv.fs_stat(fglvim)
    if stat and stat.type == "directory" then
        -- Prepend to runtimepath
        vim.opt.runtimepath:prepend(fglvim)
        vim.notify("DEBUG: Added " .. fglvim .. " to runtimepath", vim.log.levels.INFO)
    else
        vim.notify("DEBUG: " .. fglvim .. " does not exist", vim.log.levels.WARN)
    end
else
    vim.notify("DEBUG: $FGLDIR is not set", vim.log.levels.WARN)
end


-- 4GL-specific: Tab triggers omnicomplete only in 4GL files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fgl",
  callback = function()
    vim.keymap.set('i', '<Tab>', '<C-x><C-o>', { buffer = true, noremap = true, silent = true })
  end,
})

-- Enable LSP servers (Neovim 0.11+ native config from lsp/ directory)
vim.lsp.enable('fglcomp')
vim.lsp.enable('omnisharp')
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('jsonls')

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

