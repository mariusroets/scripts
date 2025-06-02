vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- window management
vim.keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
vim.keymap.set('n', '<leader>-', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally

vim.keymap.set('n', '<f3>', '<cmd>AerialToggle<cr>', { desc = 'Open Symbol Navigator' })
vim.keymap.set('n', '<f4>', '<cmd>ToggleViewLayout<cr>', { desc = 'Open in split window mode' })
vim.keymap.set('n', '<f7>', '@q', { desc = 'Run macro in the q register' })
vim.keymap.set('n', '<f12>', '<cmd>cd ~/.config/nvim<cr><cmd>e init.lua<cr>', { desc = 'Edit NVim config' })
vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Go to the next buffer' })
vim.keymap.set('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<c-tab>', '<cmd>edit #<cr>', { desc = 'Go to the alternate buffer' })
vim.keymap.set('n', '<c-q>', '<cmd>edit #<cr>', { desc = 'Go to the alternate buffer' })
vim.keymap.set('n', '<c-x>', '<cmd>NvimTreeClose<cr><cmd>AerialClose<cr><cmd>bdelete<cr>', { desc = 'Close the current buffer' })
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFindFile<cr>', { desc = 'Go to the tree for current file' })
