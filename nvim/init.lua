--
-- Should be place in ~/.config/nvim
--

-- Tracks whether the custom writing settings have been enabled
_G.write_settings_enabled = false

-- Tracks whether user is actively in WriteMode
-- Ensures ZenMode disables write settings when exitting write mode
_G.is_in_write_mode = false

-- Enable custom write settings
local function enable_write_settings()
	-- Turn on spell check
	vim.opt.spell = true
	vim.opt.spelllang = "en_us"

	-- Set custom spellfile directory
	vim.opt.spellfile = "/home/oixel/.vim/spell/en.utf-8.add"
	
	-- Enable line numbers and wrapping on empty space
	vim.opt.number = true
	vim.opt.linebreak = true

	-- Toggle keybindings for 'j' and 'k' to work with visual lines.
	vim.keymap.set("n", "j", "gj", { noremap=true, silent=true, desc="Move cursor down one visual line" })
	vim.keymap.set("n", "k", "gk", { noremap=true, silent=true, desc="Move cursor up one visual line" })
	
	-- Change boolean to reflect new state of writing settings
	_G.write_settings_enabled = true
end

-- Disable custom write settings
local function disable_write_settings()
	-- Disable all enabled optional settings
	vim.opt.spell = false 
	vim.opt.number = false 
	vim.opt.linebreak = false 
	
	-- Remap keybindings back to normal (move down one actual line)
	vim.keymap.del("n", "j")
	vim.keymap.del("n", "k")

	-- Change boolean to reflect new state of writing settings
	_G.write_settings_enabled = false
end

-- Toggles all my desired writing settings.
local function toggle_write_settings()
	-- Checks whether writing mode is turned on. If it is NOT, then toggle WriteMode on.
	if not _G.write_settings_enabled then
		enable_write_settings()
	else
		disable_write_settings()
	end
end

-- Toggles both my custom writing settings and ZenMode
local function toggle_write_mode()
	-- Enable my custom writing settings
	enable_write_settings()

	-- Enable ZenMode
	require("zen-mode").toggle()
	
	-- Toggle boolean to reflect new writing mode
	_G.is_in_write_mode = not _G.is_in_write_mode
end

-- Allows for toggling of custom writing settings
vim.api.nvim_create_user_command(
	"ToggleWriteSettings",
	toggle_write_settings,
	{
		desc = "Toggle custom writing settings",
		bang = true,  -- ALlows for the command to be force with !
		nargs = 0,  -- No arguments required
	}
)

-- Create a custom command to enable writing mode
vim.api.nvim_create_user_command(
	"WriteMode",
	toggle_write_mode,
	{
		desc = "Toggles both my custom writing settings and ZenMode",
		bang = true,  -- ALlows for the command to be force with ! 
		nargs = 0, -- No arguments required
	}
)

-- Makes Ctrl + B open the file explorer
vim.api.nvim_set_keymap('n', '<C-b>, ':Explore<CR>', { noremap = true, silent = true })

-- Insert Lazy vim config
require("config.lazy")

-- Call functionality on zen-mode closing
require("zen-mode").setup({
	on_close = function()
		-- Toggle custom write settings to their original state
		if _G.is_in_write_mode then
			disable_write_settings()
		end
	end
})
