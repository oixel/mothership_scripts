-- Get gruxbox colorscheme
-- (https://github.com/ellisonleao/gruvbox.nvim)
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		-- Force dark mode
		vim.o.background = "dark"

		-- Load the colorscheme
		vim.cmd([[colorscheme gruvbox]])
	end,
}
