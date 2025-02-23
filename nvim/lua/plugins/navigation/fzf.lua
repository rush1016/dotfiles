return {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local fzf = require('fzf-lua')
        local actions = fzf.actions;
        fzf.setup({
            {'max-perf', 'default', 'Telescope', 'borderless-full'},
            files = {
                prompt = "Files❯ ",
                cwd_prompt = false
            },
            winopts = {
                backdrop = 100,
                width = 0.90,
                height = 0.80,
                fullscreen = true,
                preview = {
                    default = 'builtin',
                    horizontal = 'right:50%',
                    vertical = "up:55%",
                    layout = "horizontal",
                }
            },
            keymap = {
                builtin = {
                    ["<C-d>"] = "preview-down",
                    ["<C-u>"] = "preview-up",
                },
                fzf = {
                    ["ctrl-q"] = "select-all+accept"
                },
            },
            buffers = {
                actions = {
                    ["ctrl-d"]      = false,
                    ["ctrl-x"]      = { fn = actions.buf_del, reload = true },
                }
            }
        })
        vim.keymap.set('n', '<leader>p', fzf.files, { desc = 'Open file' })
        vim.keymap.set('n', '<leader>r', fzf.oldfiles, { desc = 'Recently Opened Files' })
        vim.keymap.set('n', '<leader>fc', fzf.live_grep_resume, { desc = 'Find in workspace (continue)' })
        vim.keymap.set('n', '<leader>ff', fzf.live_grep_native, { desc = 'Find in workspace' })
        vim.keymap.set('n', '<leader>e', fzf.buffers, { desc = 'Active buffers' })
        vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Help Tags' })
        vim.keymap.set('n', '<leader>t', fzf.lsp_live_workspace_symbols, { desc = 'Find symbols in workspace' })
        vim.keymap.set('n', '<leader>o', fzf.lsp_document_symbols, { desc = 'Find symbols in document' })
        vim.keymap.set('n', '<leader>fb', fzf.blines, { desc = 'Find in buffer' })
        vim.keymap.set('n', '<leader>ft', fzf.colorschemes, { desc = 'Select theme' })

        -- Git Maps
        vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = 'Git branches' })
        vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = 'Git status' })
        vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = 'Git commit options' })
    end
}
