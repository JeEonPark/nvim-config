return {
  -- Disable automatic installation of kotlin-language-server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {
          mason = false,
          enabled = false,
        },
      },
    },
  },
}
