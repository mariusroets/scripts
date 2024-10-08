

local tmux = require("mhr.core.tmux")
local sql = require("mhr.core.sql")
local count_panes = tmux.CountPanes
local open_window = tmux.OpenSql
local send = tmux.SendKeys

vim.api.nvim_create_user_command("DB", open_window, {nargs = 1})

vim.api.nvim_create_user_command("Compile",
    function()
        local x, err = count_panes()
        if err then
            return
        end

        if x == 1 then
            open_window()
        end
        local path = vim.fn.expand("%")

        send("@" .. path)
        send("/")
    end,
    {})

vim.api.nvim_create_user_command('Compare', sql.get_stored_proc_def, {nargs = 1})
vim.api.nvim_create_user_command('DisableDiff', sql.disable_diff, {})

vim.keymap.set('n', '<F9>', '<cmd>w<cr><cmd>Compile<cr>', { buffer = true })
vim.keymap.set('i', '<F9>', '<esc><cmd>w<cr><cmd>Compile<cr>', { buffer = true })
vim.keymap.set('n', '<F8>', '<cmd>set ft=sql<cr>', { buffer = true })
vim.keymap.set('n', '<F7>', '<cmd>DisableDiff<cr>', { buffer = true })
