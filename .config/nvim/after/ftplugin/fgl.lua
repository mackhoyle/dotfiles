--vim.api.nvim_create_autocmd("FileType", {
--    pattern = "fgl",
--    callback = function()
--        vim.bo.omnifunc = "mackfglcomplete#Complete"
--        vim.notify("DEBUG: omnifunc set to mackfglcomplete#Complete", vim.log.levels.INFO)
--    end,
--})

