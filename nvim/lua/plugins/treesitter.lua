-- Applies proper syntax highlighting. New languages can be installed with :TSInstall <language>
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate"
}
