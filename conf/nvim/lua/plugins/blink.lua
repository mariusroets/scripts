return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- Prevent Enter from accepting completion suggestions
      ["<CR>"] = { "fallback" },
    },
  },
}
