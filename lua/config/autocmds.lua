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
    "StatusLine", "StatusLineNC", "WinBar", "WinBarNC", "TabLine", "TabLineFill", "TabLineSel",
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

