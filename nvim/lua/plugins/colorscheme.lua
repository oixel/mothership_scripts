return {
  -- Gets gruvbox color scheme from GitHub
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    -- Force dark mode
    vim.o.background = "dark"

    -- Load the colorscheme
    vim.cmd([[colorscheme gruvbox]])
}
