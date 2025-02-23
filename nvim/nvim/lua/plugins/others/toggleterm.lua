return {
    'akinsho/toggleterm.nvim',
    event = 'ColorScheme',
    config = function()
        local highlights = require('rose-pine.plugins.toggleterm')
        require('toggleterm').setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.25
                end
            end,
            -- size = vim.o.columns * 0.3,
            open_mapping = [[<c-\>]],
            -- highlights = highlights,
            direction = 'float',
            close_on_exit = true,
            float_opts = {
                border = 'curved',
                width = 60,
                height = 60,
                row = 0,
                col = 250,
                winblend = 0,
            },
        })

        local Terminal  = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = 'float',
            float_opts = {
                border = 'double',
                width = 180,
                height = 40,
                winblend = 0,
            }
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = 'LazyGit' })
    end
}
