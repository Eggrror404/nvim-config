-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "LCD on vim startup",
    group = vim.api.nvim_create_augroup("vim-enter-lcd", { clear = true }),
    callback = function()
        local target_path = vim.fn.expand "%:p"

        if target_path == "" then
            return
        end

        if target_path:find "^oil:///" == 1 then
            target_path = require("oil").get_current_dir() or ""
        elseif vim.fn.isdirectory(target_path) == 0 then
            target_path = vim.fn.expand "%:p:h"
        end

        if vim.fn.isdirectory(target_path) == 1 then
            vim.cmd.lcd(vim.fn.fnameescape(target_path))
        end
    end,
})
