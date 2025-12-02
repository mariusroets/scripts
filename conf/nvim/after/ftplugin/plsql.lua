

local tmux = require("custom.tmux")
local sql = require("custom.sql")
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

local function oracle_get_ddl(opts)
    sql.oracle_get_ddl(opts.fargs[1], opts.fargs[2], opts.fargs[3], opts.fargs[4])
end
vim.api.nvim_create_user_command('OracleCompare', sql.get_and_diff_ddl, {nargs = 1, desc = "Params: <database name>"})
vim.api.nvim_create_user_command('OracleGetDDL', oracle_get_ddl, {nargs = "*", desc = "Params: <database name> <object type> <owner> <object>"})
vim.api.nvim_create_user_command('OracleDisableDiff', sql.disable_diff, {})

vim.keymap.set('n', '<F9>', '<cmd>w<cr><cmd>Compile<cr>', { buffer = true })
vim.keymap.set('i', '<F9>', '<esc><cmd>w<cr><cmd>Compile<cr>', { buffer = true })
vim.keymap.set('n', '<F10>', '<cmd>set ft=sql<cr>', { buffer = true })
vim.keymap.set('n', '<F11>', '<cmd>DisableDiff<cr>', { buffer = true })

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function oracle_palette()
    -- 1. Get all active user commands
    local commands = vim.api.nvim_get_commands({})
    local oracle_cmds = {}

    -- 2. Filter list for commands starting with "Oracle"
    for name, def in pairs(commands) do
        if name:match("^Oracle") then
            table.insert(oracle_cmds, {
                name = name,
                -- Fallback text if you forgot to add a desc
                desc = def.definition or "No description provided", 
            })
        end
    end

    -- 3. Sort alphabetically
    table.sort(oracle_cmds, function(a, b) return a.name < b.name end)

    -- 4. Create the Telescope Picker
    pickers.new({}, {
        prompt_title = "Oracle Operations",
        finder = finders.new_table({
            results = oracle_cmds,
            -- This determines how the list looks
            entry_maker = function(entry)
                return {
                    value = entry,
                    -- THE MAGIC: Format it so Description sits next to Name
                    display = string.format("%-25s │ %s", entry.name, entry.desc),
                    ordinal = entry.name .. " " .. entry.desc,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- Execute the command
                vim.cmd(selection.value.name)
            end)
            return true
        end,
    }):find()
end

-- Create the command to open the palette
vim.api.nvim_create_user_command("OraclePalette", oracle_palette, {})
vim.keymap.set('n', '<leader>op', '<cmd>OraclePalette<cr>', { desc = 'Show all Oracle functions' })
