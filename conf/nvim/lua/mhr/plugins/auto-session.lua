return {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
        { '<leader>sf', '<cmd>SessionSearch<CR>', desc = 'Session search' },
        { '<leader>ss', '<cmd>SessionSave<CR>', desc = 'Save session' },
    },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        use_git_branch = true,
        cwd_change_handling = true,
        -- log_level = 'debug',
    }
}
