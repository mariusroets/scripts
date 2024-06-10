

local tmux = require("mhr.core.tmux")
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

vim.keymap.set('n', '<F9>', '<cmd>Compile<cr>')
