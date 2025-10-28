return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({
      -- Normal 모드일 때 영어 입력기
      default_im_select = "com.apple.keylayout.ABC",

      -- macOS용 명령어
      default_command = "macism",

      -- 영어로 전환할 이벤트들
      set_default_events = {
        "InsertLeave",       -- Insert 모드 → Normal
        "CmdlineLeave",      -- 명령행 모드 → Normal
        "TermLeave",         -- Terminal 모드 → Normal
        "TermClose",         -- 터미널 닫힐 때도 영어로
      },

      -- 이전 입력기로 복원할 이벤트들
      set_previous_events = {
        "InsertEnter",       -- Insert 모드 진입 시
        "TermEnter",         -- Terminal 모드 진입 시
      },

      -- 비동기 전환 (빠르게)
      async_switch_im = true,
    })

    -- 👇 추가 기능: Neovim 포커스 복귀 시 영어 입력기로 전환
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        vim.fn.jobstart({ "macism", "com.apple.keylayout.ABC" })
      end,
    })
  end,
}



