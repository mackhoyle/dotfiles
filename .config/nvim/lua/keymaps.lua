-- lua/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<F2>", ":set invpaste paste?<CR>", opts)

map("n", "gb", ":MRU<CR>", opts)
map("n", "mf", ":!cd $VDXDIR && make fast<CR>", opts)
map("n", "mm", ":!cd $VDXDIR && make<CR>", opts)
map("n", "mc", ":!cd $VDXDIR && make clean all<CR>", opts)

map("n", "<Space>", ":", { noremap = true })
map("n", ",t", ":ToggleTerm<CR>", opts)
map("t", ",t", "<C-\\><C-n>:ToggleTerm<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", opts)
map("t", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", opts)
map("t", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", opts)
map("t", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", opts)
map("t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
map("t", "<C-w>j", "<C-\\><C-n><C-w>j", opts)
map("t", "<C-w>k", "<C-\\><C-n><C-w>k", opts)
map("t", "<C-w>l", "<C-\\><C-n><C-w>l", opts)

map("v", "<C-r>", [["hy:%s/<C-r>h//gc<left><left><left>"]], {})
map("v", "<C-e>", [["hy:.,$s/<C-r>h//gc<left><left><left>"]], {})

map("i", "j", 'pumvisible() ? "\\<C-n>" : "j"', { expr = true })
map("i", "k", 'pumvisible() ? "\\<C-p>" : "k"', { expr = true })

-- ~/.config/nvim/lua/config/keymaps.lua
-- Open Neo-tree with 'gn'
vim.keymap.set("n", "gn", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-Space>", function()
  if vim.fn["copilot#GetDisplayedSuggestion"]() ~= "" then
    return vim.fn["copilot#Accept"]("<CR>")
  else
    return " "
  end
end, { expr = true, replace_keycodes = false })


vim.cmd('command! Term split term://bash')
vim.cmd('command! VTerm vsplit term://bash')

local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }

-- Files
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    file_ignore_patterns = {
      "%.42m",
      "%.42f",
    },
  })
end, { desc = "Find files (filtered)" })

vim.keymap.set('n', '<leader>fr', builtin.oldfiles, opts)          -- Recently opened files
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)           -- List open buffers

-- Text search
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)         -- Search text in project
vim.keymap.set('n', '<leader>fd', builtin.grep_string, opts)       -- Search word under cursor
vim.keymap.set('n', '<leader>fk', builtin.keymaps, opts)           -- Show keymaps
vim.keymap.set('n', '<leader>fc', builtin.commands, opts)          -- List available commands

-- Help and docs
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)         -- Search help tags
vim.keymap.set('n', '<leader>fm', builtin.man_pages, opts)         -- Search man pages
vim.keymap.set('n', '<leader>ft', builtin.treesitter, opts)        -- Search symbols via Treesitter

-- Git
vim.keymap.set('n', '<leader>gs', builtin.git_status, opts)        -- Git modified files
vim.keymap.set('n', '<leader>gc', builtin.git_commits, opts)       -- Git commit history
vim.keymap.set('n', '<leader>gb', builtin.git_branches, opts)      -- Git branches

-- Other pickers
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, opts)          -- Old files
vim.keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find, opts) -- Search in current buffer

-- LSP keymaps (attach to any buffer with an LSP client)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local o = { buffer = buf, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, o)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, o)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, o)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o)
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, o)
    vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, o)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, o)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, o)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, o)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, o)
    vim.keymap.set({"n", "v"}, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, o)
  end,
})

