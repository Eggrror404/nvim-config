local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Toggle line wrap
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Line Wrap" })

-- Show diagnostic popup
-- normally can be accessed with <C-w>d
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic popup" })

-- Split
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })

-- Copy to & paste from system keyboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "System keyboard yank" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "System keyboard paste" })
