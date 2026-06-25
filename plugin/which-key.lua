require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/folke/which-key.nvim" },
    }

    require("which-key").setup {
        icons = { mappings = false },
        spec = {
            { "<leader>s", group = "Search" },
            { "<leader>h", group = "Git Hunk" },
            { "<leader>u", group = "Toggle" },
            { "<leader>G", group = "GitHub" },
        },
    }
end)
