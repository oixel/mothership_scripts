  6 --
  5 -- Should be place in ~/.config/nvim
  4 --
  3
  2 -- Opt into desired features
  1 vim.opt.rnu = true  -- Displays relative line distance from cursor
7   vim.opt.number = true  -- Enable line number on current line
  1
  2 -- Set tabs to be equivalent to 4 spaces
  3 vim.opt.tabstop = 4
  4 vim.opt.shiftwidth = 4
  5
  6 -- Adds a light gray highlight to the line that the cursor is currently one
  7 vim.o.cursorline = true
  8 vim.cmd([[highlight CursorLine guibg=#4a4a4a guifg=NONE]])
  9
 10 -- Add keybind to open telescope for finding file with '!'
 11 vim.keymap.set('n', '!', '<cmd>Telescope find_files<cr>', { desc = 'Enable Telescope with find_files' })
 12
 13 -- Tracks whether the custom writing settings have been enabled
 14 _G.write_settings_enabled = false
 15
 16 -- Tracks whether user is actively in WriteMode
 17 -- Ensures ZenMode disables write settings when exitting write mode
 18 _G.is_in_write_mode = false
 19
 20 -- Enable custom write settings
 21 local function enable_write_settings()
 22 ▎   -- Turn on spell check
 23 ▎   vim.opt.spell = true
 24 ▎   vim.opt.spelllang = "en_us"
 25 ▎
 26 ▎   -- Set custom spellfile directory
 27 ▎   vim.opt.spellfile = "/home/oixel/.vim/spell/en.utf-8.add"
 28 ▎
 29 ▎   vim.opt.rnu = false  -- Disable relative line numbering while in WriteMode
 30 ▎   vim.opt.linebreak = true  -- Enable wrapping on empty space
 31 ▎
 32 ▎   -- Toggle keybindings for 'j' and 'k' to work with visual lines.
 33 ▎   vim.keymap.set("n", "j", "gj", { noremap=true, silent=true, desc="Move cursor down one visual line" })
 34 ▎   vim.keymap.set("n", "k", "gk", { noremap=true, silent=true, desc="Move cursor up one visual line" })
 35 ▎
 36 ▎   -- Change boolean to reflect new state of writing settings
 37 ▎   _G.write_settings_enabled = true
 38 end
 39
 40 -- Disable custom write settings
 41 local function disable_write_settings()
 42 ▎   -- Disable all enabled optional settings
 43 ▎   vim.opt.spell = false
init.lua                                                                                                                                                                                          7,36           Top
