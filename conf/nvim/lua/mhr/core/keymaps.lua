vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set('n', '<f3>', '<cmd>AerialToggle<cr>', { desc = 'Open Symbol Navigator' })
keymap.set('n', '<f7>', '@q', { desc = 'Run macro in the q register' })
keymap.set('n', '<f12>', '<cmd>cd ~/.config/nvim<cr><cmd>e init.lua<cr>', { desc = 'Edit NVim config' })
keymap.set('n', '<tab>', '<cmd>bnext<cr>' , { desc = 'Go to the next buffer' })
keymap.set('n', '<s-tab>', '<cmd>bprevious<cr>' , { desc = 'Go to the previous buffer' })
keymap.set('n', '<c-tab>', '<cmd>edit #<cr>' , { desc = 'Go to the alternate buffer' })
keymap.set('n', '<c-q>', '<cmd>edit #<cr>' , { desc = 'Go to the alternate buffer' })
keymap.set('n', '<c-x>', '<cmd>NvimTreeClose<cr><cmd>AerialClose<cr><cmd>bdelete<cr>' , { desc = 'Close the current buffer' })
keymap.set('n', '<leader>t', '<cmd>NvimTreeFindFile<cr>', { desc = 'Go to the tree for current file' })
-- keymap.set('n', '<C-J>', '<Cmd>NvimTmuxNavigateDown<CR>', { desc = 'Go to split below' })
-- keymap.set('n', '<C-K>', '<Cmd>NvimTmuxNavigateUp<CR>', { desc = 'Go to split above' })
-- keymap.set('n', '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', { desc = 'Go to split left' })
-- keymap.set('n', '<C-L>', '<Cmd>NvimTmuxNavigateRight<CR>', { desc = 'Go to split right' })
