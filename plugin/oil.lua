require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/malewicz1337/oil-git.nvim" },
        { src = "https://github.com/stevearc/oil.nvim" },
    }

    require("oil").setup {
        keymaps = {
            ["q"] = "actions.close",
            ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        },
        view_options = { show_hidden = true },
        win_options = { signcolumn = "yes:2" },
    }
    require("oil-git").setup { symbol_position = "signcolumn" }

    vim.keymap.set("n", "<leader>e", function()
        require("oil").toggle_float()
    end, { desc = "Oil File Explorer" })
end, { sync = true })
