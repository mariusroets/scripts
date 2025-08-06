

local tmux = require("custom.tmux")
local count_panes = tmux.CountPanes
local open_window = tmux.OpenSql
local send = tmux.SendKeys

vim.api.nvim_create_user_command("DB", open_window, {nargs = 1})

vim.api.nvim_create_user_command("RunSql",
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
    end,
    {})

vim.keymap.set('n', '<F9>', '<cmd>w<cr><cmd>RunSql<cr>', { buffer = true })
vim.keymap.set('i', '<F9>', '<esc><cmd>w<cr><cmd>RunSql<cr>', { buffer = true })
vim.keymap.set('n', '<F10>', '<cmd>set ft=plsql<cr>', { buffer = true })
