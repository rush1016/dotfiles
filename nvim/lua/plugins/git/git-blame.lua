return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,
        message_template = " <summary> • <date> • <author> • <<sha>>",
        date_format = "%Y-%m-%d %H:%M",
        virtual_text_column = 1,
    },
    config = function(_, opts)
        require('gitblame').setup(opts)
        vim.keymap.set('n', '<leader>gcs', ':GitBlameCopySHA<cr>', { silent = true, desc = 'Copy commit hash' })
    end
}
