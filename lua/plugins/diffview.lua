return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>\\d", "<cmd>DiffviewOpen develop<cr>", desc = "Diff with develop branch" },
    { "<leader>\\c", "<cmd>DiffviewOpen HEAD<cr>", desc = "Diff with last commit" },
    { "<leader>\\q", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    {
      "<leader>\\b",
      function()
        -- Get all branches
        local branches = vim.fn.systemlist("git branch --all --format='%(refname:short)'")

        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to get git branches", vim.log.levels.ERROR)
          return
        end

        -- Show branch selector
        vim.ui.select(branches, {
          prompt = "Select branch to compare:",
        }, function(choice)
          if choice then
            vim.cmd("DiffviewOpen " .. choice)
          end
        end)
      end,
      desc = "Diff with selected branch",
    },
  },
}

