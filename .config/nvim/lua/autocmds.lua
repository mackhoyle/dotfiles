-- lua/autocmds.lua

-- Highlight trailing whitespace in red
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000" })
  end,
})
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000" })
vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.4gl", "*.all", "*.err", "*.inc" },
    pattern = "fgl",
    callback = function()
        vim.schedule(function()  -- schedule to run after all FileType hooks
            vim.bo.omnifunc = "mackfglcomplete#Complete"
            vim.notify("DEBUG: omnifunc forcibly set to mackfglcomplete#Complete", vim.log.levels.INFO)
        end)
    end,
})


vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.per" },
  callback = function()
    vim.bo.filetype = "per"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.4ad", "*.4st", "*.4tb", "*.4tm", "*.xcf" },
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.handlebars" },
  callback = function()
    vim.bo.filetype = "html"
  end,
})

-- C# indent: 4 spaces (matches .NET convention)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})

-- TypeScript/React indent: 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "html", "css" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

