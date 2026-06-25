-- use <space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- enable mouse for all modes
vim.o.mouse = "a"

-- use register * for vim clipboard
vim.o.clipboard = "unnamed"

-- continue indentation
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true

-- case-insensitive searching UNLESS \C or 1+ capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- signcolumn
vim.o.signcolumn = "yes"

-- decrease update time
vim.o.updatetime = 250

-- decrease mapped sequence wait time
vim.o.timeoutlen = 500

-- new windows open on right/below and moves cursor
-- vim.o.splitright = true
-- vim.o.splitbelow = true

-- show whitespace chars
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live
vim.o.inccommand = "split"

-- cursor line highlight
vim.o.cursorline = true

-- minimal number of lines above/below cursor
vim.o.scrolloff = 4

-- confirm dialog for operations that would fail due to unsaved changes, e.g. `:q`
vim.o.confirm = true

-- wrap text
vim.o.wrap = true

-- scroll by 5 columns horizontally if wrapping is off
vim.o.sidescroll = 5

-- tab width
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- window borders
vim.o.winborder = "rounded"

-- 24-bit RGB (required by notify, colorizer)
vim.o.termguicolors = true
