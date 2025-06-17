return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
    git_use_branch_name = true,
    auto_create = false,
    auto_restore = false,
    auto_save = false,
    enable = false,
  }
}
