return {
  -- "johnseth97/codex.nvim",
  -- lazy = true,
  -- cmd = { "Codex", "CodexToggle" },
  -- keys = {
  --   {
  --     "<leader>o",
  --     function()
  --       require("codex").toggle()
  --     end,
  --     desc = "Toggle Codex popup",
  --   },
  -- },
  -- opts = {
  --   keymaps = {
  --     toggle = nil,
  --     quit = "<C-q>",
  --   },
  --   border = "rounded",
  --   width = 0.8,
  --   height = 0.8,
  --   model = nil,
  --   autoinstall = true,
  -- },

  {
    "rhart92/codex.nvim",
    keys = {
      {
        "<leader>ct",
        function()
          require("codex").toggle()
        end,
        desc = "Toggle Codex terminal",
      },
      {
        "<leader>cs",
        function()
          require("codex").actions.send_selection()
        end,
        mode = "v",
        desc = "Send selection to Codex",
      },
    },
    opts = {
      split = "vertical",
      size = 0.3,
      focus_after_send = true,
      autostart = false,
      log_level = "warn",
    },
  },
}
