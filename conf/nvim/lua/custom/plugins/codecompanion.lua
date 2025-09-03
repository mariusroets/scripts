-- ~/.config/nvim/lua/plugins.lua (inside your CodeCompanion.nvim config)
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
              -- Gemini adapter configuration
              gemini = function()
                return require("codecompanion.adapters").extend("gemini", {
                  -- It will automatically pick up GEMINI_API_KEY from environment
                  -- api_key = os.getenv("GEMINI_API_KEY"), -- Uncomment if you prefer explicit env var access
                  model = "gemini-2.0-flash", -- Or "gemini-1.5-flash", "gemini-1.5-pro", etc. Choose your preferred model.
                })
              end,
          }
          -- You can add other adapters here like openai, anthropic, etc.
        },
        -- Set default strategies to use Gemini
        strategies = {
          chat = { adapter = "gemini" },
          inline = { adapter = "gemini" },
          -- agent = { adapter = "gemini" }, -- If you plan to use agentic workflows
        },
        -- Optional: Further customization
        chat_buffer = {
          render_markdown = true, -- Recommended for better chat output
        },
        -- prompt_library = {
        --   enabled = true,
        --   -- You can define custom prompts here
        -- },
      })
    end,
  },
}
