
local tmux = require("custom.tmux")
local count_panes = tmux.CountPanes
local bottom = tmux.BottomPane
local send = tmux.SendKeys

vim.api.nvim_create_user_command("Run",
    function()
        local x, err = count_panes()
        if err then
            return
        end

        if x == 1 then
            bottom()
        end
        print(x, err)
        local path = vim.fn.expand("%")
        send("eskmanage run " .. path)
    end,
    {})

vim.keymap.set('n', '<F9>', '<cmd>Run<cr>')
