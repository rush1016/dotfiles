-- Neotree
vim.keymap.set('n', '<leader>n', ':Neotree toggle<cr>', { silent = true, desc = 'Filetree' })

-- Close buffer
vim.keymap.set('n', '<leader>w', ' :<C-U>bprevious <bar> bdelete #<CR>', { silent = true, desc = 'Close buffer' })

-- Add description to letter binding
vim.keymap.set('n', '<leader>f', '', { silent = true, desc = 'Find options' })
vim.keymap.set('n', '<leader>g', '', { silent = true, desc = 'Git options' })

-- Navigate panes / buffers
vim.keymap.set('n', '<c-j>', '<c-w>j', {})
vim.keymap.set('n', '<c-k>', '<c-w>k', {})
vim.keymap.set('n', '<c-l>', '<c-w>l', {})
vim.keymap.set('n', '<c-h>', '<c-w>h', {})

-- Add new lines
vim.keymap.set('i', '<C-j>', '<Esc>o', { silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>O', { silent = true })
vim.keymap.set('i', '<C-CR>', '<Esc>o', { silent = true })
vim.keymap.set('i', '<C-S-CR>', '<Esc>O', { silent = true })

-- Beginning or end of selection
vim.keymap.set('v', '<S-i>', '<esc>`<i', { noremap = true })
vim.keymap.set('v', '<S-a>', '<esc>`>a', { noremap = true })

-- Toggle wrap/nowrap with \w
vim.keymap.set('n', '\\w', function()
    vim.wo.wrap = not vim.wo.wrap
end, { desc = 'Toggle wrap' })

vim.keymap.set('n', '\\r', function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle relative number' })
