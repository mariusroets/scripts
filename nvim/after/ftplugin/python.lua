
local function count_panes()
    local handle = assert(io.popen("tmux list-panes")) -- Open pipe to capture output

    local line_count = 0
    for line in handle:lines() do
        line_count = line_count + 1
    end
    handle:close()

    return line_count, nil -- Return line count and nil for success
    -- local handle = io.popen("tmux list-panes")
    -- if handle ~= nil then
    --     local result = handle:read("*a")
    --     handle:close()
    --     print(result)
    -- end
end

vim.api.nvim_create_user_command("Run",
    function()
        local x, err = count_panes()
        if err then
            return
        end

        if x == 1 then
            os.execute('tmux split-window -v -f -l 15 -c "#{pane_current_path}"')
        end
        print(x, err)
        local path = vim.fn.expand("%")
        os.execute("tmux send-keys -t 2 'eskmanage run " .. path .. "' C-m")
    end,
    {})

vim.keymap.set('n', '<F9>', '<cmd>Run<cr>')
