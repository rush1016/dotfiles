return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            numhl = true,
            signcolumn = false,
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    -- opts.silent = true
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                vim.keymap.set('n', '<leader>h', '', { silent = true, desc = 'Other git options' })
                map('n', '<leader>hs', gitsigns.stage_hunk, { silent = true, desc = 'Stage hunk' })
                map('n', '<leader>hr', gitsigns.reset_hunk, { silent = true, desc = 'Reset hunk' })
                map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { silent = true, desc = 'Stage hunk' })
                map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { silent = true, desc = 'Reset hunk' })
                map('n', '<leader>hS', gitsigns.stage_buffer, { silent = true, desc = 'Stage buffer' })
                map('n', '<leader>hu', gitsigns.undo_stage_hunk, { silent = true, desc = 'Undo stage buffer' })
                map('n', '<leader>hR', gitsigns.reset_buffer, { silent = true, desc = 'Reset buffer' })
                map('n', '<leader>hp', gitsigns.preview_hunk, { silent = true, desc = 'Preview hunk' })
                map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { silent = true, desc = 'Preview blame' })
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { silent = true, desc = 'Toggle current line blame' })
                map('n', '<leader>hd', gitsigns.diffthis, { silent = true, desc = 'Open diff' })
                map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { silent = true, desc = 'Open diff' })
                map('n', '<leader>td', gitsigns.toggle_deleted, { silent = true, desc = 'Toggle deleted' })

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        })
    end
}
