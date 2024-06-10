
function CountPanes()
    local handle = assert(io.popen("tmux list-panes")) -- Open pipe to capture output

    local line_count = 0
    for line in handle:lines() do
        line_count = line_count + 1
    end
    handle:close()

    return line_count, nil -- Return line count and nil for success
end

function BottomPane()
    os.execute('tmux split-window -v -f -l 15 -c "#{pane_current_path}"')
end

function SendKeys(keys)
    os.execute("tmux send-keys -t 2 '" .. keys .. "' C-m")
end

function OpenSql(opts)
    os.execute('tmux split-window -v -f -l 15 -c "#{pane_current_path}"')
    os.execute("tmux send-keys -t 2 'db " .. opts.fargs[1] .. "' C-m")
    os.execute([[tmux send-keys -t 2 'set sqlprompt "_USER @ _CONNECT_IDENTIFIER> "' C-m]])
end
