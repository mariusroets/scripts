local M = {}

function M.get_stored_proc_def(db, obj_type, owner, name)
    os.execute("export-plsql " .. db .. " " .. owner .. " " .. name .. " '" .. obj_type .. "' /tmp/neovim-temp.sql &> /dev/null")
    vim.cmd("edit /tmp/neovim-temp.sql")
end

function M.get_current_stored_proc(opts)
    local pattern = [[create or replace\s\+\(.\+\)\s\+\(\w\+\).\(\w\+\)]]

    local line_nr = vim.fn.search(pattern, 'n')
    local line = vim.fn.getline(line_nr)
    local values = vim.fn.matchlist(line, pattern)
    vim.print(values)
    M.get_stored_proc_def(opts.fargs[1], values[2], values[3], values[4])
end

function M.diff_stored_proc()
    vim.cmd("set filetype=plsql")
    vim.cmd("diffthis")
    vim.cmd("b#")
    vim.cmd("diffthis")
    vim.cmd("vsplit")
    vim.cmd("b#")
end

function M.get_and_diff_stored_proc(opts)
    M.get_current_stored_proc(opts)
    M.diff_stored_proc()
end

function M.disable_diff()
    vim.cmd("diffoff")
    vim.cmd("quit")
    vim.cmd("diffoff")
end

return M
