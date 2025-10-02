return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>\\d", "<cmd>DiffviewOpen develop<cr>", desc = "Diff with develop branch" },
    { "<leader>\\c", "<cmd>DiffviewOpen HEAD<cr>", desc = "Diff with last commit" },
    { "<leader>\\q", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
}

