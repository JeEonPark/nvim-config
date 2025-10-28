return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `vim.g.opencode_opts.auto_reload`
    vim.opt.autoread = true

    -- Recommended/example keymaps
    vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle embedded" })
    vim.keymap.set("n", "<leader>oa", function() require("opencode").ask("@cursor: ") end, { desc = "Ask about this" })
    vim.keymap.set("x", "<leader>oa", function() require("opencode").ask("@selection: ") end, { desc = "Ask about selection" })
    vim.keymap.set("n", "<leader>o+", function() require("opencode").prompt("@buffer", { append = true }) end, { desc = "Add buffer to prompt" })
    vim.keymap.set("x", "<leader>o+", function() require("opencode").prompt("@selection", { append = true }) end, { desc = "Add selection to prompt" })
    vim.keymap.set("n", "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, { desc = "Explain this code" })
    vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session" })
    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select prompt" })
  end,
}
