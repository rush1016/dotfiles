return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                variant = 'main',
                before_highlight = function(group, highlight, palette)
                    if highlight.bg then
                        highlight.bg = "#000000"
                    end
                end,
            })
            -- vim.cmd.colorscheme 'rose-pine'
        end
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup({
                specs = {
                    github_dark_default = {
                        bg0 = '#000000',
                        bg1 = '#000000',
                        bg2 = '#000000',
                        bg3 = '#000000',
                        bg4 = '#000000',
                        float_bg = '#000000',
                    }
                },
                darken = {
                    floats = true,
                    sidebars = {
                        enable = false,
                        list = {'qf', 'netrw'}
                    }
                }
             })

            vim.cmd.colorscheme('github_dark_default')
        end,
    }
}
