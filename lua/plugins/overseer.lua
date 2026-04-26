return {
  "stevearc/overseer.nvim",
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 15,
      default_detail = 2,
    },
  },
  keys = {
    { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
  },
}
