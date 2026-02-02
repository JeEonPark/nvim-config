return {
  "gutsavgupta/nvim-gemini-companion",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    require("gemini").setup({
      -- 기본 설정으로 시작
    })
  end,
  keys = {
    { "\\g", "<cmd>GeminiToggle<cr>", desc = "Toggle Gemini sidebar" },
    { "\\c", "<cmd>GeminiSwitchToCli<cr>", desc = "Spawn Gemini AI session" },
    { "\\S", "<cmd>GeminiSend<cr>", mode = "v", desc = "Send selection to Gemini" },
    { "\\d", "<cmd>GeminiSendLineDiagnostic<cr>", desc = "Send line diagnostic to Gemini" },
    { "\\D", "<cmd>GeminiSendFileDiagnostic<cr>", desc = "Send file diagnostic to Gemini" },
    { "\\s", "<cmd>GeminiSwitchSidebarStyle<cr>", desc = "Switch sidebar style" },
  },
}
