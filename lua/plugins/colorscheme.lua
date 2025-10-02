return {
	-- {
	--   "folke/tokyonight.nvim",
	--   lazy = false,
	--   priority = 1000,
	--   opts = {
	-- 	transparent = true,
	-- 	styles = { sidebars = "transparent", floats = "transparent" },
	--   },
	-- },

	-- Configure LazyVim to load tokyonight
	-- {
	-- 	"LazyVim/LazyVim",
	--  	opts = {
	-- 		colorscheme = "tokyonight",
	--   	},
	-- },

	-- Install vim-colors-xcode
  -- change dark light
	{
		"lunacookies/vim-colors-xcode",
		lazy = false,
		priority = 1000,
		config = function()
			-- Enhance readability for xcodelight on transparent backgrounds
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "xcodelight",
				callback = function()
					-- Make colors more vibrant for better visibility on transparent background
					vim.api.nvim_set_hl(0, "Normal", { fg = "#1a1a1a" }) -- darker from #262626
					vim.api.nvim_set_hl(0, "Comment", { fg = "#6b7a87", italic = true }) -- darker from #8a99a6
					vim.api.nvim_set_hl(0, "Keyword", { fg = "#9a2a91" }) -- more vibrant from #ad3da4
					vim.api.nvim_set_hl(0, "Function", { fg = "#0c5a8a" }) -- darker from #0f68a0
					vim.api.nvim_set_hl(0, "String", { fg = "#b82717" }) -- more saturated from #d12f1b
					vim.api.nvim_set_hl(0, "Type", { fg = "#0c5a8a" }) -- darker from #0f68a0
					vim.api.nvim_set_hl(0, "Constant", { fg = "#6d3f9a" }) -- more vibrant from #804fb8
					vim.api.nvim_set_hl(0, "Number", { fg = "#6d3f9a" }) -- more vibrant from #804fb8
					vim.api.nvim_set_hl(0, "Operator", { fg = "#1a1a1a" }) -- darker from #262626

					-- Fix diffview.nvim file panel visibility
					vim.api.nvim_set_hl(0, "DiffviewFilePanelTitle", { fg = "#1a1a1a" })
					vim.api.nvim_set_hl(0, "DiffviewFilePanelFileName", { fg = "#1a1a1a" })
					vim.api.nvim_set_hl(0, "DiffviewFilePanelPath", { fg = "#6b7a87" })
					vim.api.nvim_set_hl(0, "DiffviewFilePanelCounter", { fg = "#0c5a8a" })
				end,
			})
		end,
		keys = {
			{
				"<leader>td",
				function()
					vim.cmd("colorscheme xcodedark")
					vim.fn.writefile({ "xcodedark" }, vim.fn.stdpath("data") .. "/last_colorscheme")
				end,
				desc = "Switch to dark mode",
			},
			{
				"<leader>tl",
				function()
					vim.cmd("colorscheme xcodelight")
					vim.fn.writefile({ "xcodelight" }, vim.fn.stdpath("data") .. "/last_colorscheme")
				end,
				desc = "Switch to light mode",
			},
		},
	},

	-- Configure LazyVim to load xcode colorscheme
	{
		"LazyVim/LazyVim",
		opts = function()
			local last_colorscheme_file = vim.fn.stdpath("data") .. "/last_colorscheme"
			local colorscheme = "xcodedark" -- default

			if vim.fn.filereadable(last_colorscheme_file) == 1 then
				local lines = vim.fn.readfile(last_colorscheme_file)
				if #lines > 0 then
					colorscheme = lines[1]
				end
			end

			return {
				colorscheme = colorscheme,
			}
		end,
	},
}
