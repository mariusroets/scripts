-- Customize trouble symbols sidebar to a reasonable size
return {
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = {
      use_diagnostic_signs = true,
      modes = {
        symbols = {
          win = {
            size = 0.35,
          },
        },
      },
    },
  },
}
