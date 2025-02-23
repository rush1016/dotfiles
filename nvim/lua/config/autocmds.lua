vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        local filesize = vim.fn.getfsize(vim.fn.expand("%:p"))
        if filesize < 1024 * 1024 then
            return
        end

        vim.treesitter.stop()
    end,
})
