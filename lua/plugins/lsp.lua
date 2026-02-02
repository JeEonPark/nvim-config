return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pre-alpha kotlin_lsp 비활성화
        kotlin_lsp = {
          enabled = false,
        },
        -- 공식 kotlin_language_server 활성화
        kotlin_language_server = {},
      },
    },
  },
}
