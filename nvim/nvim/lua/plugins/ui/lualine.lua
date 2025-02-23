return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local project_root = function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end


        local custom_github_dark_default = require('lualine.themes.github_dark_default')

        -- Set background color to 'None' for multiple modes
        local modes = { 'normal', 'terminal', 'insert', 'visual', 'command' }
        for _, mode in ipairs(modes) do
            custom_github_dark_default[mode].c.bg = 'None'
        end

        require('lualine').setup({
            options = {
                theme = custom_github_dark_default
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    project_root,
                    {
                        'filename',
                        path = 1,
                        file_status = true,
                    }
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'filetype'}
            },
        })
    end
}
