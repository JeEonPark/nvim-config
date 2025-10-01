return {
	{
	  "folke/tokyonight.nvim",
	  lazy = false,
	  priority = 1000,
	  opts = {
		transparent = true,
		styles = { sidebars = "transparent", floats = "transparent" },
	  },
	},

	-- Configure LazyVim to load tokyonight
	{
		"LazyVim/LazyVim",
	 	opts = {
			colorscheme = "tokyonight",
	  	},
	},
}
