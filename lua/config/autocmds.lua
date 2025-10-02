-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Force transparent backgrounds after colorscheme loads
local transparent_group = vim.api.nvim_create_augroup("user_transparent_bg", { clear = true })

local function set_transparent_background()
  local highlights_to_clear = {
    -- Core windows
    "Normal", "NormalNC", "NormalSB", "MsgArea", "MsgSeparator",
    -- Floating windows & borders
    "NormalFloat", "FloatBorder", "FloatTitle",
    -- UI chrome
    "SignColumn", "FoldColumn", "LineNr", "CursorLineNr", "ColorColumn",
    "WinBar", "WinBarNC", "TabLine", "TabLineFill", "TabLineSel",
    -- Menus & popups
    "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb", "WildMenu",
    -- Buffer edges & nontext
    "EndOfBuffer", "NonText",
    -- Terminal buffers
    "TermNormal", "TermNormalNC",
    -- Common plugins
    "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal",
    "NeoTreeNormal", "NeoTreeNormalNC", "WhichKeyFloat", "LspInfoBorder",
    -- Completion
    "CmpPmenu", "CmpPmenuBorder",
    -- Lazy UI overlay
    "LazyBackdrop",
  }
  for _, group in ipairs(highlights_to_clear) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    pcall(vim.cmd, string.format("highlight %s ctermbg=NONE", group))
  end

  -- Check if current colorscheme is light mode
  local is_light = vim.g.colors_name and vim.g.colors_name:match("light")

  if is_light then
    -- Light mode colors
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#a0a0a0", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#000000", bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#d0d0d0", bg = "NONE" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "#d0d0d0", bg = "NONE" })
    vim.api.nvim_set_hl(0, "Delimiter", { fg = "#000000" })
    vim.api.nvim_set_hl(0, "MatchParen", { fg = "#000000", bg = "#fefc00", bold = true })
    vim.api.nvim_set_hl(0, "Operator", { fg = "#000000" })
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#ffffff", bg = "#000000" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#f0f0f0" })
    -- StatusLine for light mode
    vim.api.nvim_set_hl(0, "StatusLine", { fg = "#000000", bg = "#e0e0e0" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#666666", bg = "#f0f0f0" })
  else
    -- Dark mode colors
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#5c6370", bg = "NONE" })
    vim.api.nvim_set_hl(0, "NonText", { fg = "#5c6370", bg = "NONE" })
    vim.api.nvim_set_hl(0, "Delimiter", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "MatchParen", { fg = "#000000", bg = "#fefc00", bold = true })
    vim.api.nvim_set_hl(0, "Operator", { fg = "#ffffff" })
    -- StatusLine for dark mode (transparent)
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
  end
end

vim.api.nvim_create_autocmd({ "ColorSchemePre", "ColorScheme", "VimEnter", "UIEnter", "WinEnter", "BufWinEnter" }, {
  group = transparent_group,
  callback = function()
    -- clear then set to ensure default bg is used
    pcall(vim.cmd, "highlight clear Normal")
    pcall(vim.cmd, "highlight clear NormalFloat")
    set_transparent_background()
    -- apply again on next tick to override late plugin highlights
    vim.schedule(set_transparent_background)
    -- apply again after small delay for very-late mutations
    vim.defer_fn(set_transparent_background, 80)
  end,
})

-- Helper: :TransparentDebug prints who last set Normal
vim.api.nvim_create_user_command("TransparentDebug", function()
  vim.cmd("verbose highlight Normal")
  vim.cmd("verbose highlight NormalFloat")
  local norm = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
  print(string.format("Normal bg=%s", norm.bg or "NONE"))
  print(string.format("NormalFloat bg=%s", float.bg or "NONE"))
end, {})

