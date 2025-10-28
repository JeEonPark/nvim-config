-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all
keymap.set("n", "<A-a>", "gg<S-v>G")

-- Save file
keymap.set("n", "<A-s>", ":w<CR>", opts)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

keymap.set("n", "dd", ":delete _<CR>", opts)
vim.keymap.set("n", "D", '"_d', { noremap = true }) -- D 대신 복사 안 되는 d
vim.keymap.set("v", "D", '"_d', { noremap = true }) -- 비주얼에서도

-- option number 버퍼 라인 숫자로 이동
keymap.set("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
keymap.set("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
keymap.set("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
keymap.set("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
keymap.set("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
keymap.set("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
keymap.set("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opts)
keymap.set("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opts)
keymap.set("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opts)
keymap.set("n", "<A-0>", ":BufferLineGoToBuffer last<CR>", opts)

-- 버퍼 닫기
keymap.set("n", "<A-w>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Delete Every Lines
keymap.set("n", "da", ":%d _<CR>", opts)

-- jk, kj to ESC
keymap.set("i", "jk", "<C-[>", opts)
keymap.set("i", "kj", "<C-[>", opts)

-- Copy LSP diagnostic message to clipboard
vim.keymap.set("n", "<leader>ce", function()
  local msg = vim.diagnostic.get(vim.api.nvim_get_current_buf(), { lnum = vim.fn.line('.') - 1 })[1]
  if msg then
    vim.fn.setreg("+", msg.message)
    print("📋 Diagnostic message copied to clipboard!")
  else
    print("⚠️ No diagnostic message on the current line.")
  end
end, { desc = "Copy LSP diagnostic message to clipboard" })

