return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
        { "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
        { "<leader>xl", "<cmd>Trouble lsp toggle<CR>", desc = "LSP definitions /references under cursor" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Open trouble quickfix list" },
        { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
    },
}
