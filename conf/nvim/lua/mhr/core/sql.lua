local M = {}

function M.get_stored_proc_def(opts)
    local pattern = [[create or replace\s\+\(.\+\)\s\+\(\w\+\).\(\w\+\)]]

    local line_nr = vim.fn.search(pattern, 'n')
    local line = vim.fn.getline(line_nr)
    local values = vim.fn.matchlist(line, pattern)
    vim.print(values)
    os.execute("export-plsql " .. opts.fargs[1] .. " " .. string.upper(values[3]) .. " " .. string.upper(values[4]) .. " '" .. string.upper(values[2]) .. "' /tmp/neovim-temp.sql &> /dev/null")
    vim.cmd("edit /tmp/neovim-temp.sql")
    vim.cmd("set filetype=plsql")
    vim.cmd("diffthis")
    vim.cmd("b#")
    vim.cmd("diffthis")
    vim.cmd("vsplit")
    vim.cmd("b#")
end

function M.disable_diff()
    vim.cmd("diffoff")
    vim.cmd("quit")
    vim.cmd("diffoff")
end

return M
