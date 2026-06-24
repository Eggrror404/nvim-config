require("pack").add {
    { src = "https://github.com/malewicz1337/oil-git.nvim", eager = true },
    {
        src = "https://github.com/stevearc/oil.nvim",
        eager = true,
        opts = {
            keymaps = {
                ["q"] = "actions.close",
                ["<C-v>"] = { "actions.select", opts = { vertical = true } },
            },
            view_options = { show_hidden = true },
            win_options = { signcolumn = "auto:2" },
        },
        setup = function(opts)
            require("oil").setup(opts)
            require("oil-git").setup { symbol_position = "signcolumn" }

            vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "Oil File Explorer" })
        end,
    },
}
